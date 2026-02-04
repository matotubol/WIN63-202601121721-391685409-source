package com.sulake.habbo.session.product
{
   public class ProductData implements class_1949
   {
      
      private var var_230:String;
      
      private var _name:String;
      
      private var var_735:String = "";
      
      public function ProductData(param1:String, param2:String)
      {
         super();
         var_230 = param1;
         _name = param2;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get description() : String
      {
         return var_735;
      }
   }
}

