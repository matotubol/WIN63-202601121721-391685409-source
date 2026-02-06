package com.sulake.habbo.communication.messages.parser.room.engine
{
   [SecureSWF(rename="true")]
   public class class_2476
   {
      
      private var var_4181:int;
      
      private var var_586:Number;
      
      private var _headDirection:Number;
      
      public function class_2476(param1:int, param2:Number, param3:Number)
      {
         super();
         var_4181 = param1;
         var_586 = param2;
         _headDirection = param3;
      }
      
      public function get userIndex() : int
      {
         return var_4181;
      }
      
      public function get bodyDirection() : Number
      {
         return var_586;
      }
      
      public function get headDirection() : Number
      {
         return _headDirection;
      }
   }
}

