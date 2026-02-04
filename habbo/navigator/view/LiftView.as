package com.sulake.habbo.navigator.view
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import flash.utils.getTimer;
   
   public class LiftView implements class_31
   {
      
      private static const AUTO_CYCLE_TIMEOUT_MS:uint = 8000;
      
      private var _navigator:HabboNewNavigator;
      
      private var var_2213:class_1993;
      
      private var var_2646:IItemListWindow;
      
      private var var_4415:IRegionWindow;
      
      private var var_312:int = -1;
      
      private var var_1920:uint = getTimer();
      
      public function LiftView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
         _navigator.registerUpdateReceiver(this,1000);
      }
      
      public function dispose() : void
      {
         _navigator.removeUpdateReceiver(this);
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _navigator == null;
      }
      
      public function set pagerIconTemplate(param1:IRegionWindow) : void
      {
         var_4415 = param1;
      }
      
      public function set borderWindow(param1:class_1993) : void
      {
         var_2213 = param1;
         var_2646 = IItemListWindow(var_2213.findChildByName("pager_itemlist"));
         IRegionWindow(var_2213.findChildByName("room_image_click_region")).procedure = goToRoomRegionProcedure;
      }
      
      public function refresh(param1:Boolean = true) : void
      {
         var_2646.destroyListItems();
         var_312 = param1 ? 0 : var_312;
         var _loc2_:int = 0;
         while(0 < _navigator.liftDataContainer.liftedRooms.length)
         {
            var_2646.addListItem(var_4415.clone());
            _loc2_++;
         }
         setPagerToSelectedPage();
         drawSelectedPage();
      }
      
      private function setPagerToSelectedPage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IRegionWindow = null;
         _loc1_ = 0;
         while(_loc1_ < var_2646.numListItems)
         {
            _loc2_ = IRegionWindow(var_2646.getListItemAt(_loc1_));
            IStaticBitmapWrapperWindow(_loc2_.findChildByName("icon")).assetUri = _loc1_ == var_312 ? "progress_disk_flat_on" : "progress_disk_flat_off";
            _loc2_.id = _loc1_;
            _loc2_.procedure = pagerPageProcedure;
            _loc1_++;
         }
      }
      
      private function drawSelectedPage() : void
      {
         setPagerToSelectedPage();
         IStaticBitmapWrapperWindow(var_2213.findChildByName("room_image")).assetUri = _navigator.liftDataContainer.getUrlForLiftImageAtIndex(var_312);
         if(var_312 < _navigator.liftDataContainer.liftedRooms.length)
         {
            var_2213.findChildByName("caption_text").caption = _navigator.liftDataContainer.liftedRooms[var_312].caption;
         }
      }
      
      private function autoCycleToNextPage() : void
      {
         var_312 = var_312 + 1;
         if(var_312 > _navigator.liftDataContainer.liftedRooms.length - 1)
         {
            var_312 = 0;
         }
         refresh(false);
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:uint = uint(getTimer());
         if(var_1920 + 8000 < _loc2_)
         {
            autoCycleToNextPage();
            var_1920 = _loc2_;
         }
      }
      
      private function pagerPageProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2.id != var_312)
            {
               var_312 = param2.id;
               drawSelectedPage();
               var_1920 = getTimer();
               _navigator.trackEventLog("browse.promotion","Promotion","",var_312);
            }
         }
      }
      
      private function goToRoomRegionProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_navigator.liftDataContainer.liftedRooms.length > var_312)
            {
               _navigator.goToRoom(_navigator.liftDataContainer.liftedRooms[var_312].flatId,"promotion");
            }
         }
      }
   }
}

