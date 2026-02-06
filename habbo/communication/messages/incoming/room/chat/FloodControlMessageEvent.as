package com.sulake.habbo.communication.messages.incoming.room.chat
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.chat.FloodControlMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class FloodControlMessageEvent extends MessageEvent
   {
      
      public function FloodControlMessageEvent(param1:Function)
      {
         super(param1,FloodControlMessageEventParser);
      }
      
      public function getParser() : FloodControlMessageEventParser
      {
         return var_15 as FloodControlMessageEventParser;
      }
   }
}

