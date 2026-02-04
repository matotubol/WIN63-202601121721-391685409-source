package com.sulake.habbo.roomevents.wired_menu.tabs.tab_inspection
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   import package_189.WiredVariable;
   
   public class VariableValueTableObject implements ITableObject
   {
      
      private var _highlightChanges:Boolean;
      
      private var var_1108:WiredVariable;
      
      private var _value:int;
      
      private var var_2782:Boolean;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      public function VariableValueTableObject(param1:WiredVariable, param2:int, param3:Boolean, param4:Boolean, param5:HabboUserDefinedRoomEvents)
      {
         super();
         var_1108 = param1;
         _value = param2;
         var_2782 = param3;
         _highlightChanges = param4;
         _roomEvents = param5;
      }
      
      public static function createVariableValueCell(param1:WiredVariable, param2:int, param3:HabboUserDefinedRoomEvents, param4:Boolean, param5:Boolean) : TableCell
      {
         var _loc7_:Boolean = false;
         var _loc8_:String = null;
         var _loc6_:class_27 = param3.localization;
         if(param1.hasValue)
         {
            _loc7_ = param2 == 2147483647 || param2 == -2147483648;
            if(_loc7_)
            {
               return new TableCell(TableCell.var_101,_loc6_.getLocalization("wiredmenu.inspection.flash_restriction.text"),false,false,null,null,false,_loc6_.getLocalization("wiredmenu.inspection.flash_restriction.desc"),16734003);
            }
            _loc8_ = Util.variableValueWithString(param1,param2);
            return new TableCell(TableCell.var_101,_loc8_,param1.canWriteValue && param5,true,String(param2),null,param4);
         }
         return new TableCell(TableCell.var_101,"");
      }
      
      public function get identifier() : String
      {
         return var_1108.variableId;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:VariableValueTableObject = param2 as VariableValueTableObject;
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE)
         {
            return var_1108.variableName != _loc3_.variable.variableName;
         }
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE)
         {
            if(var_2782 != _loc3_.canModify)
            {
               return true;
            }
            if(var_1108.hasValue != _loc3_.variable.hasValue)
            {
               return true;
            }
            if(!var_1108.hasValue)
            {
               return false;
            }
            return _value != _loc3_.value || Util.getConnectedText(variable,_value) != Util.getConnectedText(_loc3_.variable,_loc3_.value);
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         return isPropertyUpdated(WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE,param1) || isPropertyUpdated(WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE,param1);
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VARIABLE)
         {
            return new TableCell(TableCell.var_101,var_1108.variableName,false,true,var_1108.variableName);
         }
         if(param1 == WiredMenuInspectionTab.VARIABLES_COLUMN_VALUE)
         {
            return createVariableValueCell(var_1108,_value,_roomEvents,_highlightChanges,var_2782);
         }
         return null;
      }
      
      private function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1);
      }
      
      public function get variable() : WiredVariable
      {
         return var_1108;
      }
      
      public function get value() : int
      {
         return _value;
      }
      
      public function get canModify() : Boolean
      {
         return var_2782;
      }
   }
}

