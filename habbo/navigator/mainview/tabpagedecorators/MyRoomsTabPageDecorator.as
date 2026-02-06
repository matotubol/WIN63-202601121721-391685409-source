package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.*;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.communication.messages.outgoing.navigator.CanCreateRoomMessageComposer;
   
   public class MyRoomsTabPageDecorator implements ITabPageDecorator
   {
      
      private var _navigator:HabboNavigator;
      
      private var var_168:class_2261;
      
      private const SUB_ITEMS:Array = [[5,"navigator.navisel.myrooms"],[4,"navigator.navisel.wherearemyfriends"],[3,"navigator.navisel.myfriendsrooms"],[18,"navigator.navisel.roomswithrights"],[19,"navigator.navisel.mygroups"],[6,"navigator.navisel.myfavourites"],[7,"navigator.navisel.visitedrooms"],[23,""]];
      
      public function MyRoomsTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:class_1812) : void
      {
         var _loc3_:class_1812 = param1.getChildByName("me_header") as class_1812;
         if(var_168 == null || Boolean(var_168.disposed))
         {
            var_168 = class_2261(_loc3_.findChildByName("meSubNavi"));
            prepareSubNavi();
            var_168.addEventListener("WE_SELECTED",onFilterSelected);
         }
         _loc3_.visible = true;
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
         var _loc2_:class_1812 = param1.getChildByName("me_footer") as class_1812;
         var _loc3_:class_1741 = _loc2_.findChildByName("create_room_but");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onCreateRoomClick);
         }
         _navigator.refreshButton(_loc2_,"create_room",true,null,0);
         _loc2_.visible = true;
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         startSearch();
      }
      
      private function onCreateRoomClick(param1:class_1758) : void
      {
         _navigator.send(new CanCreateRoomMessageComposer());
      }
      
      private function prepareSubNavi() : void
      {
         if(var_168 == null || Boolean(var_168.disposed))
         {
            return;
         }
         var _loc2_:Array = [];
         for each(var _loc1_ in SUB_ITEMS)
         {
            _loc2_.push(_navigator.getText(_loc1_[1]));
         }
         var_168.populate(_loc2_);
         var_168.selection = 0;
      }
      
      private function onFilterSelected(param1:class_1758) : void
      {
         startSearch();
         var _loc2_:class_1741 = param1.target;
         if(_loc2_ is class_2261)
         {
            _navigator.trackNavigationDataPoint(class_2261(_loc2_).enumerateSelection()[class_2261(_loc2_).selection],"category.view");
         }
      }
      
      private function startSearch() : void
      {
         var _loc1_:int = int(var_168 == null || Boolean(var_168.disposed) ? 0 : var_168.selection);
         _navigator.mainViewCtrl.startSearch(3,getSearchTypeForIndex(_loc1_));
      }
      
      private function getSearchTypeForIndex(param1:int) : int
      {
         if(param1 <= SUB_ITEMS.length)
         {
            return SUB_ITEMS[param1][0];
         }
         return SUB_ITEMS[0][0];
      }
      
      public function get filterCategory() : String
      {
         return var_168 && !var_168.disposed ? var_168.enumerateSelection()[var_168.selection] : null;
      }
      
      public function setSubSelection(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = null;
         if(!var_168 || Boolean(var_168.disposed))
         {
            return;
         }
         var _loc4_:int = var_168.numMenuItems;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = SUB_ITEMS[_loc3_];
            if(_loc2_[0] == param1)
            {
               var_168.selection = _loc3_;
               return;
            }
            _loc3_++;
         }
         var_168.selection = 0;
      }
      
      public function processSearchParam(param1:String) : String
      {
         return param1;
      }
   }
}

