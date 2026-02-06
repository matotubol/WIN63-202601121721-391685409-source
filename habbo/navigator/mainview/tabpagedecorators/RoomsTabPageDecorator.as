package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_3364;
   
   public class RoomsTabPageDecorator implements ITabPageDecorator
   {
      
      private var _navigator:HabboNavigator;
      
      private var var_168:class_2261;
      
      private var var_2243:Boolean = false;
      
      public function RoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:class_1812) : void
      {
         var _loc3_:class_1812 = param1.getChildByName("rooms_header") as class_1812;
         if(var_168 == null || Boolean(var_168.disposed))
         {
            var_168 = class_2261(_loc3_.findChildByName("roomCtgFilter"));
            prepareRoomCategories();
            var_168.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc3_.visible = true;
      }
      
      public function prepareRoomCategories() : void
      {
         if(var_168 == null || Boolean(var_168.disposed))
         {
            return;
         }
         var _loc1_:Array = [_navigator.getText("navigator.navisel.popularrooms"),_navigator.getText("navigator.navisel.highestscore")];
         var_2243 = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
         if(var_2243)
         {
            _loc1_.push(_navigator.getText("navigator.navisel.recommendedrooms"));
         }
         for each(var _loc2_ in _navigator.data.visibleCategories)
         {
            _loc1_.push(_loc2_.nodeName);
         }
         var_168.populate(_loc1_);
         var_168.selection = defaultSelection;
      }
      
      private function get defaultSelection() : int
      {
         return var_2243 ? 2 : 0;
      }
      
      public function tabSelected() : void
      {
         if(var_168 != null && !var_168.disposed)
         {
            var_168.removeEventListener("WE_SELECTED",onFilterSelected);
            var_168.selection = defaultSelection;
            var_168.addEventListener("WE_SELECTED",onFilterSelected);
         }
      }
      
      public function refreshFooter(param1:class_1812) : void
      {
         _navigator.officialRoomEntryManager.refreshAdFooter(param1);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function onFilterSelected(param1:class_1758) : void
      {
         startSearch();
      }
      
      private function startSearch() : void
      {
         var _loc3_:int = 0;
         var _loc4_:class_3364 = null;
         var _loc1_:int = 0;
         var _loc2_:int = var_168 && !var_168.disposed ? var_168.selection : defaultSelection;
         class_21.log("Room filter changed: " + _loc2_);
         if(_loc2_ == 0)
         {
            _navigator.mainViewCtrl.startSearch(2,1);
         }
         else if(_loc2_ == 1)
         {
            _navigator.mainViewCtrl.startSearch(2,2);
         }
         else if(_loc2_ == 2 && var_2243)
         {
            _navigator.mainViewCtrl.startSearch(2,22);
         }
         else
         {
            _loc3_ = 2;
            if(var_2243)
            {
               _loc3_++;
            }
            _loc4_ = _navigator.data.visibleCategories[_loc2_ - _loc3_];
            if(_loc4_ == null)
            {
               class_21.log("No fc found: " + _loc2_ + ", " + _navigator.data.visibleCategories.length);
               return;
            }
            _loc1_ = _loc4_.nodeId;
            class_21.log("Searching with catId: " + _loc1_);
            _navigator.mainViewCtrl.startSearch(2,1,"" + _loc1_);
         }
         if(var_168 && !var_168.disposed)
         {
            _navigator.trackNavigationDataPoint(var_168.enumerateSelection()[var_168.selection],"category.view");
         }
      }
      
      public function get filterCategory() : String
      {
         return var_168 && !var_168.disposed ? var_168.enumerateSelection()[var_168.selection] : null;
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

