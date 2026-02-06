package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ObjectRemoveConfirmMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveConfirmMessageEvent extends MessageEvent
   {
      
      public function ObjectRemoveConfirmMessageEvent(param1:Function)
      {
         super(param1,ObjectRemoveConfirmMessageEventParser);
      }
      
      public function getParser() : ObjectRemoveConfirmMessageEventParser
      {
         return var_15 as ObjectRemoveConfirmMessageEventParser;
      }
   }
}

