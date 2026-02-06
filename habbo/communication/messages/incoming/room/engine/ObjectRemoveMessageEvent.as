package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMessageEvent extends MessageEvent
   {
      
      public function ObjectRemoveMessageEvent(param1:Function)
      {
         super(param1,ObjectRemoveMessageEventParser);
      }
      
      public function getParser() : ObjectRemoveMessageEventParser
      {
         return var_15 as ObjectRemoveMessageEventParser;
      }
   }
}

