package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.SeasonalCalendarDailyOfferMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class SeasonalCalendarDailyOfferMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function SeasonalCalendarDailyOfferMessageEvent(param1:Function)
      {
         super(param1,SeasonalCalendarDailyOfferMessageEventParser);
      }
      
      public function get offer() : class_2138
      {
         return SeasonalCalendarDailyOfferMessageEventParser(parser).offerData;
      }
      
      public function get pageId() : int
      {
         return SeasonalCalendarDailyOfferMessageEventParser(parser).pageId;
      }
   }
}

