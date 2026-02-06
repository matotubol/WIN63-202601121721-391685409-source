package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemsMessageEvent extends MessageEvent
   {
      
      public function ItemsMessageEvent(param1:Function)
      {
         super(param1,ItemsMessageEventParser);
      }
      
      public function getParser() : ItemsMessageEventParser
      {
         return var_15 as ItemsMessageEventParser;
      }
   }
}

