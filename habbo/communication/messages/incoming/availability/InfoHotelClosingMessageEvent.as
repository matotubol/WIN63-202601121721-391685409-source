package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class InfoHotelClosingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InfoHotelClosingMessageEvent(param1:Function)
      {
         super(param1,InfoHotelClosingMessageEventParser);
      }
      
      public function getParser() : InfoHotelClosingMessageEventParser
      {
         return var_15 as InfoHotelClosingMessageEventParser;
      }
   }
}

