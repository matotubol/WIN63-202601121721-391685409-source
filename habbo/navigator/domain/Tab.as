package com.sulake.habbo.navigator.domain
{
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.habbo.navigator.HabboNavigator;
   import com.sulake.habbo.navigator.mainview.tabpagedecorators.ITabPageDecorator;
   
   public class Tab
   {
      
      private var _navigator:HabboNavigator;
      
      private var var_197:int;
      
      private var var_2572:int;
      
      private var _button:ITabButtonWindow;
      
      private var var_3845:ITabPageDecorator;
      
      private var _selected:Boolean;
      
      private var _searchMsg:int;
      
      public function Tab(param1:HabboNavigator, param2:int, param3:int, param4:ITabPageDecorator, param5:int = 1)
      {
         super();
         _navigator = param1;
         var_197 = param2;
         var_2572 = param3;
         var_3845 = param4;
         _searchMsg = param5;
      }
      
      public function sendSearchRequest() : void
      {
         var _loc1_:Boolean = _navigator.context.configuration.getBoolean("navigator.2014.personalized.navigator");
         if(_loc1_ && id == 2)
         {
            var_2572 = 22;
         }
         _navigator.mainViewCtrl.startSearch(var_197,var_2572,"-1",_searchMsg);
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get defaultSearchType() : int
      {
         return var_2572;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get tabPageDecorator() : ITabPageDecorator
      {
         return var_3845;
      }
      
      public function get searchMsg() : int
      {
         return _searchMsg;
      }
      
      public function get button() : ITabButtonWindow
      {
         return _button;
      }
      
      public function set button(param1:ITabButtonWindow) : void
      {
         _button = param1;
      }
   }
}

