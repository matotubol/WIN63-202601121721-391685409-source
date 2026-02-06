package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.SecondsUntilMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SecondsUntilMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SecondsUntilMessageEvent(param1:Function)
      {
         super(param1,SecondsUntilMessageEventParser);
      }
      
      public function getParser() : SecondsUntilMessageEventParser
      {
         return var_15 as SecondsUntilMessageEventParser;
      }
   }
}

