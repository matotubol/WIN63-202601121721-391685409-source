package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class EventsTabPageDecorator implements ITabPageDecorator
   {
      
      private var _navigator:HabboNavigator;
      
      private var var_168:class_2261;
      
      public function EventsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:class_1812) : void
      {
         var _loc2_:class_1812 = param1.getChildByName("room_ad_header") as class_1812;
         if(var_168 == null || Boolean(var_168.disposed))
         {
            var_168 = _loc2_.getChildByName("roomAdFilter") as class_2261;
            prepareFilter();
            var_168.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc2_.visible = true;
      }
      
      public function tabSelected() : void
      {
         if(var_168 != null && !var_168.disposed)
         {
            var_168.removeEventListener("WE_SELECTED",onFilterSelected);
            var_168.selection = 0;
            var_168.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:class_1812) : void
      {
         var _loc2_:class_1812 = param1.getChildByName("room_ads_footer") as class_1812;
         var _loc3_:class_1741 = _loc2_.findChildByName("get_event_but");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onGetEventClick);
         }
         _loc2_.visible = true;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function prepareFilter() : void
      {
         if(var_168 == null || Boolean(var_168.disposed))
         {
            return;
         }
         var _loc1_:Array = [];
         _loc1_.push(_navigator.getText("navigator.roomad.topads"));
         _loc1_.push(_navigator.getText("navigator.roomad.newads"));
         var_168.populate(_loc1_);
         var_168.selection = 0;
      }
      
      private function onFilterSelected(param1:class_1758) : void
      {
         startSearch();
      }
      
      private function onGetEventClick(param1:class_1758) : void
      {
         _navigator.openCatalogRoomAdsPage();
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = 16;
         if(var_168 != null && !var_168.disposed)
         {
            _loc1_ = getSearchType(var_168.selection);
         }
         _navigator.mainViewCtrl.startSearch(1,_loc1_);
      }
      
      private function getSearchType(param1:int) : int
      {
         switch(param1)
         {
            case 0:
               return 16;
            case 1:
               return 17;
            default:
               class_21.log("Invalid index when searching Room ad search type: " + param1);
               return 0;
         }
      }
      
      public function get filterCategory() : String
      {
         if(var_168 == null || Boolean(var_168.disposed))
         {
            return null;
         }
         return var_168.enumerateSelection()[var_168.selection];
      }
      
      public function setSubSelection(param1:int) : void
      {
      }
      
      public function processSearchParam(param1:String) : String
      {
         return param1;
      }
   }
}

