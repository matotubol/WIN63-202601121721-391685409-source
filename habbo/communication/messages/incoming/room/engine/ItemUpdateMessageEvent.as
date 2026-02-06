package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemUpdateMessageEvent extends MessageEvent
   {
      
      public function ItemUpdateMessageEvent(param1:Function)
      {
         super(param1,ItemUpdateMessageEventParser);
      }
      
      public function getParser() : ItemUpdateMessageEventParser
      {
         return var_15 as ItemUpdateMessageEventParser;
      }
   }
}

