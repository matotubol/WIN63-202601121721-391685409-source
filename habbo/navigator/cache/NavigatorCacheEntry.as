package com.sulake.habbo.navigator.cache
{
   import package_25.class_1995;
   
   public class NavigatorCacheEntry
   {
      
      private var _key:String;
      
      private var var_5106:class_1995;
      
      private var var_4239:Number;
      
      private var var_4451:Number;
      
      public function NavigatorCacheEntry(param1:String, param2:class_1995, param3:Number, param4:Number)
      {
         super();
         _key = param1;
         var_5106 = param2;
         var_4239 = param3;
         var_4451 = param4;
      }
      
      public function hasExpired(param1:Number) : Boolean
      {
         return param1 >= var_4451;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get payload() : class_1995
      {
         return var_5106;
      }
   }
}

