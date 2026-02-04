package com.sulake.habbo.roomevents.wired_menu.roomlogs
{
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.common.PagedTableView;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import package_192.class_3529;
   import package_203.WiredLogEntry;
   import package_203.WiredLogPage;
   
   public class WiredRoomLogListView extends PagedTableView
   {
      
      public static const REQUEST_PAGE_RATELIMIT:uint = 190;
      
      public static const REFRESH_TIME:int = 2500;
      
      public static const LOG_COLUMN_TIMESTAMP:String = "timestamp";
      
      public static const const_343:String = "source";
      
      public static const const_601:String = "level";
      
      public static const LOG_COLUMN_MESSAGE:String = "message";
      
      private var var_55:WiredRoomLogListController;
      
      private var _ignoreDropmenuEvents:Boolean = false;
      
      private var var_1404:Timer;
      
      public function WiredRoomLogListView(param1:WiredRoomLogListController, param2:class_38)
      {
         super(param1.assets.getAssetByName("logs_overview_xml"),param2,param1.localizationManager,false);
         var_55 = param1;
         logSourceMenu.addEventListener("WE_SELECT",onSelectFilter);
         logLevelMenu.addEventListener("WE_SELECT",onSelectFilter);
         logSourceMenu.addEventListener("WE_SELECTED",onSelectedFilter);
         logLevelMenu.addEventListener("WE_SELECTED",onSelectedFilter);
         filterInput.addEventListener("WKE_KEY_DOWN",onFilterInputDown);
         autoRefreshCheckbox.select();
         startAutoRefresh();
      }
      
      private function onFilterInputDown(param1:WindowKeyboardEvent) : void
      {
         var _loc2_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.keyCode == 13)
         {
            updateFilters();
         }
      }
      
      private function startAutoRefresh() : void
      {
         if(var_1404 == null)
         {
            var_1404 = new Timer(2500);
            var_1404.addEventListener("timer",onAutoRefresh);
         }
         var_1404.start();
      }
      
      private function onAutoRefresh(param1:TimerEvent) : void
      {
         if(!autoRefreshCheckbox.isSelected || !isShowing())
         {
            return;
         }
         var _loc2_:WiredLogPage = var_55.page;
         if(_loc2_ != null)
         {
            requestPageWithFilters(_loc2_.currentPage,_loc2_.logSourceFilter,_loc2_.logLevelFilter,_loc2_.query == null ? "" : _loc2_.query,true);
         }
      }
      
      public function displayNewPage(param1:Boolean) : void
      {
         if(var_55.page == null)
         {
            return;
         }
         var _loc3_:WiredLogPage = var_55.page;
         if(!param1)
         {
            sourceOption = _loc3_.logSourceFilter;
            levelOption = _loc3_.logLevelFilter;
            filterInput.text = _loc3_.query;
         }
         onPageLoaded();
         var _loc2_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc4_ in _loc3_.elements)
         {
            _loc2_.push(new WiredRoomLogListTableObject(var_55,_loc4_));
         }
         var_647.setObjects(_loc2_);
         if(!param1)
         {
            var_647.scrollToTop();
            _window.activate();
         }
      }
      
      override protected function createTable() : void
      {
         var_647 = new TableView(_windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn("timestamp",loc("wiredmenu.logs_overview.col.timestamp"),0.2),new TableColumn("source",loc("wiredmenu.logs_overview.col.source"),0.08),new TableColumn("level",loc("wiredmenu.logs_overview.col.level"),0.08),new TableColumn("message",loc("wiredmenu.logs_overview.col.message"),0.64)];
         var_647.initialize(Vector.<TableColumn>(_loc1_),true,true);
      }
      
      override protected function calculateLastPage() : int
      {
         if(var_55.page == null)
         {
            return -1;
         }
         return Math.max(var_55.page.totalEntries - 1,0) / WiredRoomLogsConfig.PAGE_SIZE + 1;
      }
      
      override protected function currentPage() : int
      {
         if(var_55.page == null)
         {
            return -1;
         }
         return var_55.page.currentPage;
      }
      
      override protected function requestPageRatelimit() : int
      {
         return 190;
      }
      
      override protected function pagingTextKey() : String
      {
         return "wiredmenu.logs_overview.bottom_text";
      }
      
      override protected function totalEntries() : int
      {
         if(var_55.page == null)
         {
            return -1;
         }
         return var_55.page.totalEntries;
      }
      
      private function requestPageWithFilters(param1:int, param2:int, param3:int, param4:String, param5:Boolean = false) : Boolean
      {
         if(!super.requestPage(param1))
         {
            return false;
         }
         var _loc6_:WiredLogPage = var_55.page;
         if(_loc6_ == null)
         {
            return false;
         }
         if(param2 == 2147483647)
         {
            param2 = _loc6_.logSourceFilter;
         }
         if(param3 == 2147483647)
         {
            param3 = _loc6_.logLevelFilter;
         }
         if(param4 == null)
         {
            param4 = "";
         }
         var_55.send(new class_3529(param1,WiredRoomLogsConfig.PAGE_SIZE,param3,param2,param4),param5);
         onPageLoaded();
         return true;
      }
      
      override protected function requestPage(param1:int) : Boolean
      {
         return requestPageWithFilters(param1,2147483647,2147483647,null);
      }
      
      private function onSelectFilter(param1:class_1758) : void
      {
         if(_ignoreDropmenuEvents)
         {
            return;
         }
         if(!canRequestNewPage(false))
         {
            param1.preventWindowOperation();
         }
      }
      
      private function onSelectedFilter(param1:class_1758) : void
      {
         if(_ignoreDropmenuEvents)
         {
            return;
         }
         updateFilters();
      }
      
      private function updateFilters(param1:Boolean = true) : void
      {
         var firstAttempt:Boolean = param1;
         if(!canRequestNewPage(false))
         {
            if(!firstAttempt)
            {
               var_1404.reset();
               var_1404.start();
               setTimeout(function():void
               {
                  updateFilters(false);
               },190 + 10);
            }
            return;
         }
         var_1404.reset();
         var_1404.start();
         requestPageWithFilters(1,sourceOption,levelOption,filterInput.text);
      }
      
      private function set levelOption(param1:int) : void
      {
         _ignoreDropmenuEvents = true;
         logLevelMenu.selection = param1 + 1;
         _ignoreDropmenuEvents = false;
      }
      
      private function get levelOption() : int
      {
         return logLevelMenu.selection - 1;
      }
      
      private function set sourceOption(param1:int) : void
      {
         _ignoreDropmenuEvents = true;
         logSourceMenu.selection = param1 + 1;
         _ignoreDropmenuEvents = false;
      }
      
      private function get sourceOption() : int
      {
         return logSourceMenu.selection - 1;
      }
      
      public function activate() : void
      {
         _window.activate();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_55 = null;
      }
      
      private function get autoRefreshCheckbox() : class_1885
      {
         return _window.findChildByName("auto_refresh_cbx") as class_1885;
      }
      
      private function get logSourceMenu() : class_2261
      {
         return _window.findChildByName("log_source_menu") as class_2261;
      }
      
      private function get logLevelMenu() : class_2261
      {
         return _window.findChildByName("log_level_menu") as class_2261;
      }
      
      private function get filterInput() : ITextFieldWindow
      {
         return _window.findChildByName("filter_input") as ITextFieldWindow;
      }
   }
}

