package com.sulake.habbo.communication.messages.parser.inventory.badges
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_2384
   {
      
      private var var_605:String;
      
      private var var_1909:int;
      
      public function class_2384(param1:String, param2:IMessageDataWrapper)
      {
         super();
         var_605 = "ACH_" + param1 + param2.readInteger();
         var_1909 = param2.readInteger();
      }
      
      public function get badgeId() : String
      {
         return var_605;
      }
      
      public function get limit() : int
      {
         return var_1909;
      }
   }
}

