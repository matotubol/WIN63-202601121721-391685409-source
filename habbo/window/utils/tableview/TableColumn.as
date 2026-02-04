package com.sulake.habbo.window.utils.tableview
{
   public class TableColumn
   {
      
      private var var_197:String;
      
      private var _columnName:String;
      
      private var var_4488:Number;
      
      private var var_2733:String;
      
      public function TableColumn(param1:String, param2:String, param3:Number, param4:String = "center")
      {
         super();
         var_197 = param1;
         _columnName = param2;
         var_4488 = param3;
         if(param4 == "left")
         {
            param4 = "none";
         }
         var_2733 = param4;
      }
      
      public function get id() : String
      {
         return var_197;
      }
      
      public function get columnName() : String
      {
         return _columnName;
      }
      
      public function get widthFactor() : Number
      {
         return var_4488;
      }
      
      public function get alignment() : String
      {
         return var_2733;
      }
   }
}

