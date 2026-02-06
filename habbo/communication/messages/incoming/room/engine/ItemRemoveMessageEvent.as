package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemRemoveMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemRemoveMessageEvent extends MessageEvent
   {
      
      public function ItemRemoveMessageEvent(param1:Function)
      {
         super(param1,ItemRemoveMessageEventParser);
      }
      
      public function getParser() : ItemRemoveMessageEventParser
      {
         return var_15 as ItemRemoveMessageEventParser;
      }
   }
}

