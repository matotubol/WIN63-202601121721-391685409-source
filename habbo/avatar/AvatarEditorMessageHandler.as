package com.sulake.habbo.avatar
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.avatar.view.AvatarEditorNameChangeView;
   import com.sulake.habbo.communication.class_57;
   import package_124.class_2452;
   import package_124.class_2467;
   import package_124.class_2592;
   import package_124.class_3660;
   import package_128.class_2461;
   import package_128.class_2873;
   import package_128.class_3233;
   import package_22.class_2414;
   import package_24.class_1886;
   import package_24.class_2598;
   import package_24.class_3130;
   import package_4.class_1757;
   import package_85.class_3391;
   
   public class AvatarEditorMessageHandler
   {
      
      private var _communication:class_57;
      
      private var var_55:HabboAvatarEditorManager;
      
      public function AvatarEditorMessageHandler(param1:HabboAvatarEditorManager, param2:class_57)
      {
         super();
         var_55 = param1;
         _communication = param2;
         _communication.addHabboConnectionMessageEvent(new class_3660(onAvatarEffectActivated));
         _communication.addHabboConnectionMessageEvent(new class_2452(onAvatarEffectSelected));
         _communication.addHabboConnectionMessageEvent(new class_2598(onWardrobe));
         _communication.addHabboConnectionMessageEvent(new class_2467(onAvatarEffectAdded));
         _communication.addHabboConnectionMessageEvent(new class_3391(onRoomAvatarEffects));
         _communication.addHabboConnectionMessageEvent(new class_1757(onUserRights));
         _communication.addHabboConnectionMessageEvent(new class_2592(onAvatarEffectExpired));
         _communication.addHabboConnectionMessageEvent(new class_3130(onCheckUserNameResult));
      }
      
      public function dispose() : void
      {
         _communication = null;
         var_55 = null;
      }
      
      public function saveWardrobeOutfit(param1:int, param2:IOutfit) : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc3_:class_2873 = new class_2873(param1,param2.figure,param2.gender);
         _communication.connection.send(_loc3_);
         _loc3_.dispose();
         _loc3_ = null;
      }
      
      public function checkName(param1:String) : void
      {
         if(_communication == null)
         {
            return;
         }
         _communication.connection.send(new class_2461(param1));
      }
      
      private function onCheckUserNameResult(param1:class_3130) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc3_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:AvatarEditorNameChangeView = _loc3_.view.avatarEditorNameChangeView;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc4_:class_2414 = param1.getParser();
         if(_loc4_.resultCode == class_1886.var_1851)
         {
            _loc2_.checkedName = _loc4_.name;
         }
         else
         {
            _loc2_.setNameNotAvailableView(_loc4_.resultCode,_loc4_.name,_loc4_.nameSuggestions);
         }
      }
      
      public function getWardrobe() : void
      {
         if(_communication == null)
         {
            return;
         }
         var _loc1_:class_3233 = new class_3233();
         _communication.connection.send(_loc1_);
         _loc1_.dispose();
         _loc1_ = null;
      }
      
      private function onWardrobe(param1:class_2598) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.wardrobe.updateSlots(param1.state,param1.outfits);
         }
      }
      
      private function onUserRights(param1:class_1757) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.clubMemberLevel = param1.clubLevel != 0 ? 2 : 0;
            _loc2_.update();
         }
      }
      
      private function onAvatarEffectAdded(param1:IMessageEvent) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
         }
      }
      
      private function onAvatarEffectActivated(param1:class_3660) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
            _loc2_.figureData.avatarEffectType = param1.getParser().type;
            _loc2_.figureData.updateView();
         }
      }
      
      private function onAvatarEffectExpired(param1:class_2592) : void
      {
         var _loc3_:int = 0;
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.effects.reset();
            _loc3_ = param1.getParser().type;
            if(_loc2_.figureData.avatarEffectType == _loc3_)
            {
               _loc2_.figureData.avatarEffectType = -1;
               _loc2_.figureData.updateView();
            }
         }
      }
      
      private function onRoomAvatarEffects(param1:class_3391) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_ && var_55.roomDesktop != null && param1.getParser().userId == var_55.roomDesktop.roomSession.ownUserRoomId)
         {
            _loc2_.figureData.avatarEffectType = param1.getParser().effectId;
            _loc2_.figureData.updateView();
         }
      }
      
      private function onAvatarEffectSelected(param1:class_2592) : void
      {
         if(param1 == null || !var_55)
         {
            return;
         }
         var _loc2_:HabboAvatarEditor = var_55.getEditor(0);
         if(_loc2_)
         {
            _loc2_.figureData.avatarEffectType = param1.getParser().type;
            _loc2_.figureData.updateView();
         }
      }
   }
}

