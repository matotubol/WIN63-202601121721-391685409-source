package com.sulake.habbo.communication.messages.parser.vault
{
   [SecureSWF(rename="true")]
   public class class_3206
   {
      
      private var var_4317:int;
      
      private var var_4835:int;
      
      private var _amount:int;
      
      private var var_2711:String;
      
      public function class_3206(param1:int, param2:int, param3:int, param4:String)
      {
         super();
         var_4317 = param1;
         var_4835 = param2;
         _amount = param3;
         var_2711 = param4;
      }
      
      public function get rewardCategory() : int
      {
         return var_4317;
      }
      
      public function get rewardType() : int
      {
         return var_4835;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
   }
}

