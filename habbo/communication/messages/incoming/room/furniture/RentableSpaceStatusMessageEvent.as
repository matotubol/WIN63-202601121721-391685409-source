package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.RentableSpaceStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RentableSpaceStatusMessageEvent extends MessageEvent
   {
      
      public function RentableSpaceStatusMessageEvent(param1:Function)
      {
         super(param1,RentableSpaceStatusMessageEventParser);
      }
      
      public function getParser() : RentableSpaceStatusMessageEventParser
      {
         return parser as RentableSpaceStatusMessageEventParser;
      }
   }
}

