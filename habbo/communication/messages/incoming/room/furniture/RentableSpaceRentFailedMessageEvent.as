package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentFailedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceRentFailedMessageEvent extends MessageEvent
   {
      
      public function RentableSpaceRentFailedMessageEvent(param1:Function)
      {
         super(param1,RentableSpaceRentFailedMessageEventParser);
      }
      
      public function getParser() : RentableSpaceRentFailedMessageEventParser
      {
         return parser as RentableSpaceRentFailedMessageEventParser;
      }
   }
}

