package com.sulake.habbo.communication.messages.incoming.availability
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.availability.InfoHotelClosedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class InfoHotelClosedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function InfoHotelClosedMessageEvent(param1:Function)
      {
         super(param1,InfoHotelClosedMessageEventParser);
      }
      
      public function getParser() : InfoHotelClosedMessageEventParser
      {
         return var_15 as InfoHotelClosedMessageEventParser;
      }
   }
}

