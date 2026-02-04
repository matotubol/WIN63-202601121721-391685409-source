package com.sulake.habbo.roomevents.wired_setup.common.utils
{
   public class ChronoFieldRangeFilter
   {
      
      private var _name:String;
      
      private var var_5203:Boolean;
      
      private var _min:int;
      
      private var var_1935:int;
      
      private var var_5214:int;
      
      public function ChronoFieldRangeFilter(param1:String, param2:Boolean, param3:int, param4:int, param5:int = 0)
      {
         super();
         this._name = param1;
         this.var_5203 = param2;
         this._min = param3;
         this.var_1935 = param4;
         this.var_5214 = param5;
      }
      
      public function get defaultValue() : int
      {
         return var_5214;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get useFilter() : Boolean
      {
         return var_5203;
      }
      
      public function get min() : int
      {
         return _min;
      }
      
      public function get max() : int
      {
         return var_1935;
      }
   }
}

