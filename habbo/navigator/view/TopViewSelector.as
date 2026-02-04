package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITabButtonWindow;
   import com.sulake.core.window.components.ITabContextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   
   public class TopViewSelector
   {
      
      private var _navigator:HabboNewNavigator;
      
      private var var_1369:ITabButtonWindow;
      
      private var _tabContext:ITabContextWindow;
      
      public function TopViewSelector(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function set template(param1:ITabButtonWindow) : void
      {
         var_1369 = param1;
      }
      
      public function set tabContext(param1:ITabContextWindow) : void
      {
         _tabContext = param1;
      }
      
      public function refresh() : void
      {
         var _loc1_:int = 0;
         var _loc3_:String = null;
         var _loc2_:ITabButtonWindow = null;
         clearTabs();
         _loc1_ = 0;
         while(_loc1_ < _navigator.contextContainer.getTopLevelSearches().length)
         {
            _loc3_ = _navigator.contextContainer.getTopLevelSearches()[_loc1_];
            _loc2_ = ITabButtonWindow(var_1369.clone());
            _loc2_.caption = "${navigator.toplevelview." + _loc3_ + "}";
            _loc2_.id = _loc1_;
            _loc2_.procedure = topViewSelectorButtonProcedure;
            _tabContext.addTabItem(_loc2_);
            _loc1_++;
         }
      }
      
      public function selectTabByIndex(param1:int) : void
      {
         _tabContext.selector.setSelected(_tabContext.getTabItemAt(param1));
      }
      
      private function clearTabs() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _tabContext.numTabItems)
         {
            _tabContext.removeTabItem(_tabContext.getTabItemAt(0));
            _loc1_++;
         }
      }
      
      private function topViewSelectorButtonProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(_navigator.contextContainer.getTopLevelSearches().length > param2.id)
            {
               _navigator.performSearch(_navigator.contextContainer.getTopLevelSearches()[param2.id],"",_navigator.view.currentFilterText());
            }
         }
      }
   }
}

