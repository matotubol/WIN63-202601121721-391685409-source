package com.sulake.habbo.navigator.view
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.navigator.HabboNewNavigator;
   import com.sulake.habbo.navigator.context.SearchContext;
   import package_25.class_2073;
   
   public class QuickLinksView
   {
      
      private var _navigator:HabboNewNavigator;
      
      private var var_1369:IRegionWindow;
      
      private var _itemList:IItemListWindow;
      
      private var var_1419:Array = [];
      
      private var var_2556:Array = [];
      
      public function QuickLinksView(param1:HabboNewNavigator)
      {
         super();
         _navigator = param1;
      }
      
      public function set itemList(param1:IItemListWindow) : void
      {
         _itemList = param1;
      }
      
      public function set template(param1:IRegionWindow) : void
      {
         var_1369 = param1;
      }
      
      public function setQuickLinks(param1:Vector.<class_2073>) : void
      {
         _itemList.removeListItems();
         var_1419 = [];
         var_2556 = [];
         var _loc2_:int = 0;
         while(0 < param1.length)
         {
            var _loc4_:IRegionWindow = IRegionWindow(var_1369.clone());
            _loc4_.id = 0;
            var _loc3_:ITextWindow = ITextWindow(null.findChildByName("quick_link_text"));
            null.caption = _navigator.localization.getLocalization("navigator.searchcode.title." + param1[0].searchCode,param1[0].searchCode) + (param1[0].filter != "" ? " - " + param1[0].filter : "");
            if(param1[0].searchCode.indexOf("category__") == 0)
            {
               null.caption = param1[0].searchCode.substr("category__".length) + (param1[0].filter != "" ? " - " + param1[0].filter : "");
            }
            null.procedure = listItemProcedure;
            var_1419.push(new SearchContext(param1[0].searchCode,param1[0].filter));
            var_2556.push(param1[0].id);
            _itemList.addListItem(null);
            _loc2_++;
         }
      }
      
      private function listItemProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            if(param2 is IRegionWindow)
            {
               if(var_1419.length > param2.id)
               {
                  _navigator.performSearchByContext(var_1419[param2.id]);
                  _navigator.trackEventLog("savedsearch.execute","SavedSearch",HabboNewNavigator.getEventLogExtraStringFromSearch(var_1419[param2.id].searchCode,var_1419[param2.id].filtering));
               }
            }
            else if(param2 is class_2143)
            {
               _navigator.deleteSavedSearch(var_2556[param2.parent.id]);
            }
         }
         else if(param1.type == "WME_OVER")
         {
            if(param2 is IRegionWindow)
            {
               class_2143(IRegionWindow(param2).getChildAt(1)).visible = true;
            }
            else if(param2 is class_2143)
            {
               param2.visible = true;
            }
         }
         else if(param1.type == "WME_OUT" && param2 is IRegionWindow)
         {
            class_2143(IRegionWindow(param2).getChildAt(1)).visible = false;
         }
      }
   }
}

