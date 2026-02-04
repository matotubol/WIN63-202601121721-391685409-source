package com.sulake.habbo.avatar.nft
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.common.class_3708;
   import com.sulake.habbo.avatar.wardrobe.NftOutfit;
   
   public class NftAvatarsView implements class_3708
   {
      
      private var _window:class_1812;
      
      private var var_36:NftAvatarsModel;
      
      private var var_1722:IItemGridWindow;
      
      public function NftAvatarsView(param1:NftAvatarsModel)
      {
         super();
         var_36 = param1;
      }
      
      public function init() : void
      {
         if(var_1722)
         {
            var_1722.removeGridItems();
         }
         if(!_window)
         {
            _window = var_36.controller.view.getCategoryContainer("nfts") as class_1812;
            var_1722 = _window.findChildByName("nfts") as IItemGridWindow;
            _window.visible = false;
         }
         update();
      }
      
      public function dispose() : void
      {
         var_1722.removeGridItems();
         _window = null;
         var_36 = null;
      }
      
      public function update() : void
      {
         var _loc2_:class_1741 = null;
         var_1722.removeGridItems();
         for each(var _loc1_ in var_36.nftAvatars)
         {
            _loc2_ = _loc1_.view.window;
            var_1722.addGridItem(_loc2_);
            _loc2_.procedure = nftAvatarsEventProc;
         }
      }
      
      public function getWindowContainer() : class_1812
      {
         return _window;
      }
      
      private function nftAvatarsEventProc(param1:class_1758, param2:class_1741 = null) : void
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = param1.target as class_1741;
         }
         if(param1.type == "WME_CLICK")
         {
            _loc3_ = var_1722.getGridItemIndex(param2.parent);
            var_36.selectNftAvatar(_loc3_);
         }
      }
      
      public function switchCategory(param1:String) : void
      {
      }
      
      public function showPalettes(param1:String, param2:int) : void
      {
      }
      
      public function reset() : void
      {
      }
   }
}

