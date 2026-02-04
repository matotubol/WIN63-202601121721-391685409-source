package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import package_189.WiredVariable;
   
   public class VariableTableObject implements ITableObject
   {
      
      private var var_1108:WiredVariable;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function VariableTableObject(param1:WiredVariable, param2:HabboUserDefinedRoomEvents)
      {
         super();
         var_1108 = param1;
         _roomEvents = param2;
      }
      
      public function get identifier() : String
      {
         return var_1108.variableId;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:WiredVariable = (param2 as VariableTableObject).variable;
         if(param1 == WiredMenuOverviewTab.LIST_COLUMN_NAME)
         {
            return var_1108.variableName != _loc3_.variableName;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:WiredVariable = (param1 as VariableTableObject).variable;
         return var_1108.variableName != _loc2_.variableName;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         if(param1 == WiredMenuOverviewTab.LIST_COLUMN_NAME)
         {
            return new TableCell(TableCell.var_101,variable.variableName);
         }
         return null;
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
   }
}

