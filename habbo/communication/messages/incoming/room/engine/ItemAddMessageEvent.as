package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemAddMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemAddMessageEvent extends MessageEvent
   {
      
      public function ItemAddMessageEvent(param1:Function)
      {
         super(param1,ItemAddMessageEventParser);
      }
      
      public function getParser() : ItemAddMessageEventParser
      {
         return var_15 as ItemAddMessageEventParser;
      }
   }
}

