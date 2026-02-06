package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.OfficialRoomsEventParser;
   
   [SecureSWF(rename="true")]
   public class OfficialRoomsEvent extends MessageEvent implements IMessageEvent
   {
      
      public function OfficialRoomsEvent(param1:Function)
      {
         super(param1,OfficialRoomsEventParser);
      }
      
      public function getParser() : OfficialRoomsEventParser
      {
         return this.var_15 as OfficialRoomsEventParser;
      }
   }
}

