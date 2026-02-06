package com.sulake.habbo.avatar.nft
{
   import com.sulake.habbo.avatar.HabboAvatarEditor;
   import com.sulake.habbo.avatar.common.CategoryBaseModel;
   import com.sulake.habbo.avatar.common.CategoryData;
   import com.sulake.habbo.avatar.common.class_2582;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   import com.sulake.habbo.communication.messages.incoming.nft.UserNftWardrobeMessageEvent;
   import com.sulake.habbo.communication.messages.parser.nft.NftWardrobeItem;
   import com.sulake.habbo.communication.messages.outgoing.nft.GetUserNftWardrobeMessageComposer;
   
   public class NftAvatarsModel extends CategoryBaseModel implements class_2582
   {
      
      private var _nftAvatars:Array;
      
      private var var_1998:UserNftWardrobeMessageEvent;
      
      private var var_5068:NftWardrobeParamView;
      
      private var var_2397:NftOutfit;
      
      public function NftAvatarsModel(param1:HabboAvatarEditor)
      {
         super(param1);
         _nftAvatars = [];
         requestNftAvatars(param1);
      }
      
      private function requestNftAvatars(param1:HabboAvatarEditor) : void
      {
         if(param1.manager.communication)
         {
            var_1998 = new UserNftWardrobeMessageEvent(onUserNftWardrobeMessage);
            param1.manager.communication.addHabboConnectionMessageEvent(var_1998);
            param1.manager.communication.connection.send(new GetUserNftWardrobeMessageComposer());
         }
      }
      
      private function onUserNftWardrobeMessage(param1:UserNftWardrobeMessageEvent) : void
      {
         for each(var _loc2_ in param1.getParser().nftAvatars)
         {
            _nftAvatars.push(new NftOutfit(var_55,_loc2_.id,_loc2_.figureString,_loc2_.gender,_loc2_.tokenId,_loc2_.contractKey));
         }
      }
      
      override public function dispose() : void
      {
         if(controller && var_1998)
         {
            controller.manager.communication.removeHabboConnectionMessageEvent(var_1998);
            var_1998 = null;
         }
         _nftAvatars = null;
         super.dispose();
      }
      
      override protected function init() : void
      {
         if(!var_18)
         {
            var_18 = new NftAvatarsView(this);
            var_5068 = new NftWardrobeParamView(this);
         }
         var_18.init();
         var_265 = true;
      }
      
      public function selectNftAvatar(param1:int) : void
      {
         var _loc2_:NftOutfit = _nftAvatars[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.figure == "")
            {
               return;
            }
            var_55.setNftOutfit(_loc2_);
            var_55.loadAvatarInEditor(_loc2_.figure,_loc2_.gender,var_55.clubMemberLevel);
         }
         if(var_2397 != null)
         {
            var_2397.view.toggleActive(false);
         }
         var_2397 = _loc2_;
         if(var_2397 != null)
         {
            var_2397.view.toggleActive(true);
         }
         var_5068.updateView(_loc2_);
      }
      
      public function getNftAvatarByTokenId(param1:String) : NftOutfit
      {
         var _loc3_:* = 0;
         var _loc2_:NftOutfit = null;
         _loc3_ = 0;
         while(_loc3_ < _nftAvatars.length)
         {
            _loc2_ = _nftAvatars[_loc3_];
            if(_loc2_.tokenId == param1)
            {
               return _loc2_;
            }
            _loc3_++;
         }
         return null;
      }
      
      public function get nftAvatars() : Array
      {
         return _nftAvatars;
      }
      
      override public function switchCategory(param1:String = "") : void
      {
      }
      
      override public function getCategoryData(param1:String) : CategoryData
      {
         return null;
      }
      
      override public function selectPart(param1:String, param2:int) : void
      {
      }
   }
}

