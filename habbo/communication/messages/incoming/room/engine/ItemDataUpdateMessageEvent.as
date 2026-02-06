package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemDataUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemDataUpdateMessageEvent extends MessageEvent
   {
      
      public function ItemDataUpdateMessageEvent(param1:Function)
      {
         super(param1,ItemDataUpdateMessageEventParser);
      }
      
      public function getParser() : ItemDataUpdateMessageEventParser
      {
         return var_15 as ItemDataUpdateMessageEventParser;
      }
   }
}

