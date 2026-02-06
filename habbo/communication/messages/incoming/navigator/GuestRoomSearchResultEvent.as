package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.GuestRoomSearchResultEventParser;
   
   [SecureSWF(rename="true")]
   public class GuestRoomSearchResultEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuestRoomSearchResultEvent(param1:Function)
      {
         super(param1,GuestRoomSearchResultEventParser);
      }
      
      public function getParser() : GuestRoomSearchResultEventParser
      {
         return this.var_15 as GuestRoomSearchResultEventParser;
      }
   }
}

