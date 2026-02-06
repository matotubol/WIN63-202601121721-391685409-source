package com.sulake.habbo.communication.messages.outgoing.nux
{
   [SecureSWF(rename="true")]
   public class class_2597
   {
      
      private var var_4289:int;
      
      private var var_4633:int;
      
      private var var_4517:int;
      
      public function class_2597(param1:int, param2:int, param3:int)
      {
         super();
         var_4289 = param1;
         var_4633 = param2;
         var_4517 = param3;
      }
      
      public function get dayIndex() : int
      {
         return var_4289;
      }
      
      public function get stepIndex() : int
      {
         return var_4633;
      }
      
      public function get giftIndex() : int
      {
         return var_4517;
      }
   }
}

