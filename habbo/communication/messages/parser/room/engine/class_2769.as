package com.sulake.habbo.communication.messages.parser.room.engine
{
   [SecureSWF(rename="true")]
   public class class_2769
   {
      
      private var var_2529:int;
      
      private var var_3973:Boolean;
      
      private var var_4082:int;
      
      private var var_4697:int;
      
      private var var_4401:int;
      
      private var var_4882:int;
      
      private var var_4161:int;
      
      private var var_4349:int;
      
      private var var_4498:int;
      
      private var var_3892:int;
      
      private var _animationTime:Number;
      
      public function class_2769(param1:int, param2:Boolean, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:Number)
      {
         super();
         var_2529 = param1;
         var_3973 = param2;
         var_4082 = param3;
         var_4697 = param4;
         var_4401 = param5;
         var_4882 = param6;
         var_4161 = param7;
         var_4349 = param8;
         var_4498 = param9;
         var_3892 = param10;
         _animationTime = param11;
      }
      
      public function get itemId() : int
      {
         return var_2529;
      }
      
      public function get isDirectionRight() : Boolean
      {
         return var_3973;
      }
      
      public function get oldWallX() : int
      {
         return var_4082;
      }
      
      public function get oldWallY() : int
      {
         return var_4697;
      }
      
      public function get oldOffsetX() : int
      {
         return var_4401;
      }
      
      public function get oldOffsetY() : int
      {
         return var_4882;
      }
      
      public function get newWallX() : int
      {
         return var_4161;
      }
      
      public function get newWallY() : int
      {
         return var_4349;
      }
      
      public function get newOffsetX() : int
      {
         return var_4498;
      }
      
      public function get newOffsetY() : int
      {
         return var_3892;
      }
      
      public function get animationTime() : Number
      {
         return _animationTime;
      }
   }
}

