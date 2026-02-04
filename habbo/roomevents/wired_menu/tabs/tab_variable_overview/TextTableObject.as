package com.sulake.habbo.roomevents.wired_menu.tabs.tab_variable_overview
{
   import com.sulake.habbo.window.utils.tableview.ITableObject;
   import com.sulake.habbo.window.utils.tableview.TableCell;
   
   public class TextTableObject implements ITableObject
   {
      
      private var _value:int;
      
      private var _text:String;
      
      public function TextTableObject(param1:int, param2:String)
      {
         super();
         _value = param1;
         _text = param2;
      }
      
      public function get identifier() : String
      {
         return String(_value);
      }
      
      public function isPropertyUpdated(param1:String, param2:Object) : Boolean
      {
         var _loc3_:TextTableObject = param2 as TextTableObject;
         if(param1 == WiredMenuOverviewTab.var_4092)
         {
            return _text != _loc3_.text;
         }
         return false;
      }
      
      public function isUpdated(param1:Object) : Boolean
      {
         var _loc2_:TextTableObject = param1 as TextTableObject;
         return _text != _loc2_.text;
      }
      
      public function getTableCell(param1:String) : TableCell
      {
         if(param1 == WiredMenuOverviewTab.var_5284)
         {
            return new TableCell(TableCell.var_101,String(_value),false,true);
         }
         if(param1 == WiredMenuOverviewTab.var_4092)
         {
            return new TableCell(TableCell.var_101,text,false,true);
         }
         return null;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}

