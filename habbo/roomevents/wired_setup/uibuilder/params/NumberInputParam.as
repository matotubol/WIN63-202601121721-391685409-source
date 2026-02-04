package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   public class NumberInputParam
   {
      
      public static var DEFAULT:TextInputParam = new TextInputParam();
      
      private var var_2875:int;
      
      private var _min:int;
      
      private var var_1935:int;
      
      private var _width:int;
      
      private var var_1641:int;
      
      private var var_2085:Boolean;
      
      private var var_4335:Boolean;
      
      public function NumberInputParam(param1:int, param2:int, param3:int, param4:int = 45, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super();
         var_2875 = param1;
         _min = param2;
         var_1935 = param3;
         var_1641 = param5;
         var_2085 = param6;
         _width = param4;
         var_4335 = param7;
      }
      
      public function get initialValue() : int
      {
         return var_2875;
      }
      
      public function get min() : int
      {
         return _min;
      }
      
      public function get max() : int
      {
         return var_1935;
      }
      
      public function get precision() : int
      {
         return var_1641;
      }
      
      public function get endsWithFive() : Boolean
      {
         return var_2085;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get nonDecimalNotations() : Boolean
      {
         return var_4335;
      }
   }
}

