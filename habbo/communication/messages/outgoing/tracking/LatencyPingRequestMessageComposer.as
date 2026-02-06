package com.sulake.habbo.communication.messages.outgoing.tracking
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class LatencyPingRequestMessageComposer implements IMessageComposer
   {
      
      private var var_197:int = 0;
      
      public function LatencyPingRequestMessageComposer(param1:int)
      {
         super();
         var_197 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_197];
      }
      
      public function dispose() : void
      {
      }
   }
}

