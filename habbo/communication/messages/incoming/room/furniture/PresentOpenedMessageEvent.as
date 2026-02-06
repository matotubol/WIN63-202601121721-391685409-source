package com.sulake.habbo.communication.messages.incoming.room.furniture
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.PresentOpenedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PresentOpenedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PresentOpenedMessageEvent(param1:Function)
      {
         super(param1,PresentOpenedMessageEventParser);
      }
      
      public function getParser() : PresentOpenedMessageEventParser
      {
         return var_15 as PresentOpenedMessageEventParser;
      }
   }
}

