package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectDataUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectDataUpdateMessageEvent extends MessageEvent
   {
      
      public function ObjectDataUpdateMessageEvent(param1:Function)
      {
         super(param1,ObjectDataUpdateMessageEventParser);
      }
      
      public function getParser() : ObjectDataUpdateMessageEventParser
      {
         return var_15 as ObjectDataUpdateMessageEventParser;
      }
   }
}

