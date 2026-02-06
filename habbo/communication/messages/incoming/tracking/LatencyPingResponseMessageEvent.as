package com.sulake.habbo.communication.messages.incoming.tracking
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.tracking.LatencyPingResponseMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class LatencyPingResponseMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function LatencyPingResponseMessageEvent(param1:Function)
      {
         super(param1,LatencyPingResponseMessageEventParser);
      }
      
      public function getParser() : LatencyPingResponseMessageEventParser
      {
         return var_15 as LatencyPingResponseMessageEventParser;
      }
   }
}

