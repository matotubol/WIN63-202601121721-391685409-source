package com.sulake.habbo.catalog.purchase
{
   import package_10.class_1863;
   import package_6.class_2448;
   
   public class GiftWrappingConfiguration
   {
      
      private var var_3091:Boolean = false;
      
      private var var_3071:int;
      
      private var var_2374:Array;
      
      private var var_666:Array;
      
      private var var_1193:Array;
      
      private var var_3415:Array;
      
      public function GiftWrappingConfiguration(param1:class_1863)
      {
         super();
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_2448 = param1.getParser();
         if(_loc2_ == null)
         {
            return;
         }
         var_3091 = _loc2_.isWrappingEnabled;
         var_3071 = _loc2_.wrappingPrice;
         var_2374 = _loc2_.stuffTypes;
         var_666 = _loc2_.boxTypes;
         var_1193 = _loc2_.ribbonTypes;
         var_3415 = _loc2_.defaultStuffTypes;
      }
      
      public function get isEnabled() : Boolean
      {
         return var_3091;
      }
      
      public function get price() : int
      {
         return var_3071;
      }
      
      public function get stuffTypes() : Array
      {
         return var_2374;
      }
      
      public function get boxTypes() : Array
      {
         return var_666;
      }
      
      public function get ribbonTypes() : Array
      {
         return var_1193;
      }
      
      public function get defaultStuffTypes() : Array
      {
         return var_3415;
      }
   }
}

