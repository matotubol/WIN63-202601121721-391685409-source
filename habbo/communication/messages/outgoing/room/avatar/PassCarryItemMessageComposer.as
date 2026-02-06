package com.sulake.habbo.communication.messages.outgoing.room.avatar
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PassCarryItemMessageComposer implements IMessageComposer
   {
      
      private var var_1270:int;
      
      public function PassCarryItemMessageComposer(param1:int)
      {
         super();
         var_1270 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1270];
      }
   }
}

