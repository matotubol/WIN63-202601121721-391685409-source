package com.sulake.habbo.communication.messages.incoming.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_1936
   {
      
      private var var_1229:int;
      
      private var var_2759:int;
      
      public function class_1936(param1:IMessageDataWrapper)
      {
         super();
         this.var_1229 = param1.readInteger();
         this.var_2759 = param1.readInteger();
      }
      
      public function get senderId() : int
      {
         return this.var_1229;
      }
      
      public function get errorCode() : int
      {
         return this.var_2759;
      }
   }
}

