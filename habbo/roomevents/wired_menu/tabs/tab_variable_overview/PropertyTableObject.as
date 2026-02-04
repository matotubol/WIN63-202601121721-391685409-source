package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class PropertyTableObject implements ITableObject
   {
      
      private var var_3099:String;
      
      private var _value:String;
      
      private var _localization:class_27;
      
      private var var_4014:Boolean;
      
      public function PropertyTableObject(param1:String, param2:Object, param3:class_27, param4:Boolean = false)
      {
         super();
         var_3099 = param1;
         _localization = param3;
         var_4014 = param4;
         var _loc5_:String = param2 as String;
         var _loc6_:Boolean = param2 as Boolean;
         if(_loc5_ != null)
         {
            _value = _loc5_;
         }
         else if(_loc6_ != null)
         {
            _value = param3.getLocalization("wiredmenu.bool." + (_loc6_ ? "yes" : "no"));
         }
         else if(param2 is int)
         {
            _value = String(param2 as int);
         }
         else
         {
            _value = "";
         }
      }
      
      public function get identifier() : String
      {
         return var_3099;
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:PropertyTableObject = param2 as PropertyTableObject;
         if(param1 == WiredMenuOverviewTab.PROPERTIES_COLUMN_VALUE)
         {
            return _value != _loc3_.value;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:PropertyTableObject = param1 as PropertyTableObject;
         return _value != _loc2_.value;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         if(param1 == WiredMenuOverviewTab.PROPERTIES_COLUMN_PROPERTY)
         {
            return new TableCell(TableCell.var_101,_localization.getLocalization("wiredmenu.variable_overview.properties." + var_3099));
         }
         if(param1 == WiredMenuOverviewTab.PROPERTIES_COLUMN_VALUE)
         {
            return new TableCell(TableCell.var_101,_value,false,var_4014);
         }
         return null;
      }
      
      public function get value() : String
      {
         return _value;
      }
   }
}

