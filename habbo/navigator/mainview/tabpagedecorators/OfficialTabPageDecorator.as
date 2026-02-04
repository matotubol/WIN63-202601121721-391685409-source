package com.sulake.habbo.navigator.mainview.tabpagedecorators
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.navigator.HabboNavigator;
   
   public class OfficialTabPageDecorator implements ITabPageDecorator
   {
      
      private var _navigator:HabboNavigator;
      
      public function OfficialTabPageDecorator(param1:HabboNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function refreshCustomContent(param1:class_1812) : void
      {
      }
      
      public function tabSelected() : void
      {
      }
      
      public function refreshFooter(param1:class_1812) : void
      {
         _navigator.officialRoomEntryManager.refreshAdFooter(param1);
      }
      
      public function navigatorOpenedWhileInTab() : void
      {
         _navigator.mainViewCtrl.startSearch(4,11,"-1",4);
      }
      
      public function get filterCategory() : String
      {
         return null;
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

