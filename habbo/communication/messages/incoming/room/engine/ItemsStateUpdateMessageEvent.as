package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemsStateUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemsStateUpdateMessageEvent extends MessageEvent
   {
      
      public function ItemsStateUpdateMessageEvent(param1:Function)
      {
         super(param1,ItemsStateUpdateMessageEventParser);
      }
      
      public function getParser() : ItemsStateUpdateMessageEventParser
      {
         return var_15 as ItemsStateUpdateMessageEventParser;
      }
   }
}

