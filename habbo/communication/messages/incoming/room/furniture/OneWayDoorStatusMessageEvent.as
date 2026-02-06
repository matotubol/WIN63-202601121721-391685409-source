package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.OneWayDoorStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class OneWayDoorStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function OneWayDoorStatusMessageEvent(param1:Function)
      {
         super(param1,OneWayDoorStatusMessageEventParser);
      }
      
      public function getParser() : OneWayDoorStatusMessageEventParser
      {
         return var_15 as OneWayDoorStatusMessageEventParser;
      }
   }
}

