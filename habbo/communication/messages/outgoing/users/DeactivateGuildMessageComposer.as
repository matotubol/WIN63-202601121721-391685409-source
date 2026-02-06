package com.sulake.habbo.communication.messages.outgoing.users
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class DeactivateGuildMessageComposer implements IMessageComposer
   {
      
      private var var_3004:int;
      
      public function DeactivateGuildMessageComposer(param1:int)
      {
         super();
         var_3004 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_3004];
      }
      
      public function dispose() : void
      {
      }
   }
}

