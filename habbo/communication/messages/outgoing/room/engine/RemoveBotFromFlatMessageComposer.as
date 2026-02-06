package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RemoveBotFromFlatMessageComposer implements IMessageComposer
   {
      
      private var var_1504:int;
      
      public function RemoveBotFromFlatMessageComposer(param1:int)
      {
         super();
         var_1504 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1504];
      }
   }
}

