package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectsMessageEvent extends MessageEvent
   {
      
      public function ObjectsMessageEvent(param1:Function)
      {
         super(param1,ObjectsMessageEventParser);
      }
      
      public function getParser() : ObjectsMessageEventParser
      {
         return var_15 as ObjectsMessageEventParser;
      }
   }
}

