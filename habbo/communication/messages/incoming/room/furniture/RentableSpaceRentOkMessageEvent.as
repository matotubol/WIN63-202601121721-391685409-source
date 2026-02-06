package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceRentOkMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceRentOkMessageEvent extends MessageEvent
   {
      
      public function RentableSpaceRentOkMessageEvent(param1:Function)
      {
         super(param1,RentableSpaceRentOkMessageEventParser);
      }
      
      public function getParser() : RentableSpaceRentOkMessageEventParser
      {
         return parser as RentableSpaceRentOkMessageEventParser;
      }
   }
}

