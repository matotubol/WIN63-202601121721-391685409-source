package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.navigator.CanCreateRoomEventEventParser;
   
   [SecureSWF(rename="true")]
   public class CanCreateRoomEventEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CanCreateRoomEventEvent(param1:Function)
      {
         super(param1,CanCreateRoomEventEventParser);
      }
      
      public function getParser() : CanCreateRoomEventEventParser
      {
         return this.var_15 as CanCreateRoomEventEventParser;
      }
   }
}

