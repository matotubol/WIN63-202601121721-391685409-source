package com.sulake.habbo.communication.messages.incoming.competition
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.competition.NoOwnedRoomsAlertMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NoOwnedRoomsAlertMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NoOwnedRoomsAlertMessageEvent(param1:Function)
      {
         super(param1,NoOwnedRoomsAlertMessageEventParser);
      }
      
      public function getParser() : NoOwnedRoomsAlertMessageEventParser
      {
         return var_15 as NoOwnedRoomsAlertMessageEventParser;
      }
   }
}

