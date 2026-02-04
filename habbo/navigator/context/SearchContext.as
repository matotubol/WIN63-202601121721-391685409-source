package com.sulake.habbo.navigator.context
{
   public class SearchContext
   {
      
      private var var_3861:String;
      
      private var _filtering:String;
      
      public function SearchContext(param1:String, param2:String)
      {
         super();
         this.var_3861 = param1;
         this._filtering = param2;
      }
      
      public function get searchCode() : String
      {
         return var_3861;
      }
      
      public function get filtering() : String
      {
         return _filtering;
      }
      
      public function toString() : String
      {
         return var_3861 + " : " + _filtering;
      }
   }
}

