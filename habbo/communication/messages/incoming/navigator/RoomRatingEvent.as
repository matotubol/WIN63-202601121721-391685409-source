package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.RoomRatingEventParser;
   
   [SecureSWF(rename="true")]
   public class RoomRatingEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RoomRatingEvent(param1:Function)
      {
         super(param1,RoomRatingEventParser);
      }
      
      public function getParser() : RoomRatingEventParser
      {
         return this.var_15 as RoomRatingEventParser;
      }
   }
}

