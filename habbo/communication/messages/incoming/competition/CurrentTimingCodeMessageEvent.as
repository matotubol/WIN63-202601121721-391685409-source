package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.CurrentTimingCodeMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CurrentTimingCodeMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CurrentTimingCodeMessageEvent(param1:Function)
      {
         super(param1,CurrentTimingCodeMessageEventParser);
      }
      
      public function getParser() : CurrentTimingCodeMessageEventParser
      {
         return var_15 as CurrentTimingCodeMessageEventParser;
      }
   }
}

