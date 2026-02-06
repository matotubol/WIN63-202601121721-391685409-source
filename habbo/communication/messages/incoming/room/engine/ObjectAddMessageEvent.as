package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectAddMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectAddMessageEvent extends MessageEvent
   {
      
      public function ObjectAddMessageEvent(param1:Function)
      {
         super(param1,ObjectAddMessageEventParser);
      }
      
      public function getParser() : ObjectAddMessageEventParser
      {
         return var_15 as ObjectAddMessageEventParser;
      }
   }
}

