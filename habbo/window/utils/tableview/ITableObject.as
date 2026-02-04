package com.sulake.habbo.window.utils.tableview
{
   public interface ITableObject
   {
      
      function get identifier() : String;
      
      function getTableCell(param1:String) : TableCell;
      
      function isPropertyUpdated(param1:String, param2:Object) : Boolean;
      
      function isUpdated(param1:Object) : Boolean;
   }
}

