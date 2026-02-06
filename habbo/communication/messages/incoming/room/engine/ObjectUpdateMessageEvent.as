package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectUpdateMessageEvent extends MessageEvent
   {
      
      public function ObjectUpdateMessageEvent(param1:Function)
      {
         super(param1,ObjectUpdateMessageEventParser);
      }
      
      public function getParser() : ObjectUpdateMessageEventParser
      {
         return var_15 as ObjectUpdateMessageEventParser;
      }
   }
}

