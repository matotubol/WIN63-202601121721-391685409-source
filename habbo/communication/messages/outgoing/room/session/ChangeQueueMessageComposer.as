package com.sulake.habbo.communication.messages.outgoing.room.session
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ChangeQueueMessageComposer implements IMessageComposer
   {
      
      private var var_4489:int;
      
      public function ChangeQueueMessageComposer(param1:int)
      {
         super();
         var_4489 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4489];
      }
      
      public function dispose() : void
      {
      }
      
      public function get disposed() : Boolean
      {
         return true;
      }
   }
}

