package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectsDataUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectsDataUpdateMessageEvent extends MessageEvent
   {
      
      public function ObjectsDataUpdateMessageEvent(param1:Function)
      {
         super(param1,ObjectsDataUpdateMessageEventParser);
      }
      
      public function getParser() : ObjectsDataUpdateMessageEventParser
      {
         return var_15 as ObjectsDataUpdateMessageEventParser;
      }
   }
}

