package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveItemMessageComposer implements IMessageComposer
   {
      
      private var var_315:int;
      
      public function RemoveItemMessageComposer(param1:int)
      {
         super();
         var_315 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_315];
      }
   }
}

