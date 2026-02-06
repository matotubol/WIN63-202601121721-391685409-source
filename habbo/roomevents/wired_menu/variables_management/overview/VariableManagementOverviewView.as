package com.sulake.habbo.roomevents.wired_menu.variables_management.overview
{
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.common.PagedTableView;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableColumn;
   import com.sulake.habbo.window.utils.tableview.TableView;
   import package_117.WiredGetVariableOwnersPageComposer;
   import package_189.WiredVariable;
   import package_201.WiredUserVariablesElement;
   import package_201.WiredUserVariablesPage;
   
   public class VariableManagementOverviewView extends PagedTableView
   {
      
      public static const REQUEST_PAGE_RATELIMIT:uint = 280;
      
      public static const LOG_COLUMN_USERTYPE:String = "usertype";
      
      public static const LOG_COLUMN_NAME:String = "name";
      
      public static const LOG_COLUMN_CREATION_TIME:String = "creation_time";
      
      public static const LOG_COLUMN_LAST_UPDATE_TIME:String = "last_update_time";
      
      public static const const_856:String = "value";
      
      public static const LOG_COLUMN_MANAGE:String = "manage";
      
      private var var_55:VariableManagementOverviewController;
      
      private var _ignoreDropmenuEvents:Boolean = false;
      
      public function VariableManagementOverviewView(param1:VariableManagementOverviewController, param2:class_38)
      {
         super(param1.assets.getAssetByName("variables_management_overview_xml"),param2,param1.localizationManager);
         var_55 = param1;
         userTypeMenu.addEventListener("WE_SELECT",onSelectFilter);
         sortTypeMenu.addEventListener("WE_SELECT",onSelectFilter);
         userTypeMenu.addEventListener("WE_SELECTED",onSelectedFilter);
         sortTypeMenu.addEventListener("WE_SELECTED",onSelectedFilter);
      }
      
      public function displayNewPage() : void
      {
         if(var_55.page == null)
         {
            return;
         }
         var _loc2_:WiredUserVariablesPage = var_55.page;
         var _loc4_:String = _loc2_.variableId;
         var _loc3_:WiredVariable = var_55.roomEvents.variablesSynchronizer.getCachedVariableById(_loc4_);
         if(_loc3_ == null)
         {
            return;
         }
         variableNameValue.text = _loc3_?.variableName;
         userTypeOption = _loc2_.userTypeFilter;
         sortTypeOption = _loc2_.sortTypFilter;
         onPageLoaded();
         var _loc1_:Vector.<ITableObject> = new Vector.<ITableObject>();
         for each(var _loc5_ in _loc2_.elements)
         {
            _loc1_.push(new VariableManagementOverviewTableObject(var_55,_loc5_,_loc3_));
         }
         var_647.setObjects(_loc1_);
         var_647.scrollToTop();
         _window.activate();
      }
      
      override protected function createTable() : void
      {
         var_647 = new TableView(_windowManager,tableViewContainer,true);
         var _loc1_:Array = [new TableColumn("usertype",loc("wiredmenu.variable_management.col.usertype"),0.1),new TableColumn("name",loc("wiredmenu.variable_management.col.name"),0.18),new TableColumn("creation_time",loc("wiredmenu.variable_management.col.creation_time"),0.21),new TableColumn("last_update_time",loc("wiredmenu.variable_management.col.last_update_time"),0.21),new TableColumn("value",loc("wiredmenu.variable_management.col.value"),0.18),new TableColumn("manage",loc("wiredmenu.variable_management.col.manage"),0.12)];
         var_647.initialize(Vector.<TableColumn>(_loc1_),true,true);
      }
      
      override protected function calculateLastPage() : int
      {
         if(var_55.page == null)
         {
            return -1;
         }
         return Math.max(var_55.page.totalEntries - 1,0) / VariableManagementConfig.PAGE_SIZE + 1;
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
         return 280;
      }
      
      override protected function pagingTextKey() : String
      {
         return "wiredmenu.variable_management.bottom_text";
      }
      
      override protected function totalEntries() : int
      {
         if(var_55.page == null)
         {
            return -1;
         }
         return var_55.page.totalEntries;
      }
      
      private function requestPageWithFilters(param1:int, param2:int, param3:int) : Boolean
      {
         if(!super.requestPage(param1))
         {
            return false;
         }
         var _loc4_:WiredUserVariablesPage = var_55.page;
         if(_loc4_ == null)
         {
            return false;
         }
         if(param2 == 2147483647)
         {
            param2 = _loc4_.sortTypFilter;
         }
         if(param3 == 2147483647)
         {
            param3 = _loc4_.userTypeFilter;
         }
         var_55.send(new WiredGetVariableOwnersPageComposer(_loc4_.variableId,param1,VariableManagementConfig.PAGE_SIZE,param2,param3));
         onPageLoaded();
         return true;
      }
      
      override protected function requestPage(param1:int) : Boolean
      {
         return requestPageWithFilters(param1,2147483647,2147483647);
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
         if(!canRequestNewPage(false))
         {
            return;
         }
         requestPageWithFilters(1,sortTypeOption,userTypeOption);
      }
      
      private function set sortTypeOption(param1:int) : void
      {
         _ignoreDropmenuEvents = true;
         sortTypeMenu.selection = param1;
         _ignoreDropmenuEvents = false;
      }
      
      private function get sortTypeOption() : int
      {
         return sortTypeMenu.selection;
      }
      
      private function set userTypeOption(param1:int) : void
      {
         var _loc2_:int = param1;
         if(_loc2_ == 4)
         {
            _loc2_ = 3;
         }
         else if(_loc2_ != 1 && _loc2_ != 2)
         {
            _loc2_ = 0;
         }
         _ignoreDropmenuEvents = true;
         userTypeMenu.selection = _loc2_;
         _ignoreDropmenuEvents = false;
      }
      
      private function get userTypeOption() : int
      {
         var _loc1_:int = userTypeMenu.selection;
         if(_loc1_ == 3)
         {
            return 4;
         }
         if(_loc1_ == 1 || _loc1_ == 2)
         {
            return _loc1_;
         }
         return -1;
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
      
      private function get variableNameValue() : ITextWindow
      {
         return _window.findChildByName("variable_name_value") as ITextWindow;
      }
      
      private function get userTypeMenu() : class_2261
      {
         return _window.findChildByName("user_type_menu") as class_2261;
      }
      
      private function get sortTypeMenu() : class_2261
      {
         return _window.findChildByName("sort_type_menu") as class_2261;
      }
   }
}

