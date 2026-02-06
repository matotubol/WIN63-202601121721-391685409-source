package com.sulake.habbo.communication.messages.incoming.room.engine
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.engine.ItemStateUpdateMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ItemStateUpdateMessageEvent extends MessageEvent
   {
      
      public function ItemStateUpdateMessageEvent(param1:Function)
      {
         super(param1,ItemStateUpdateMessageEventParser);
      }
      
      public function getParser() : ItemStateUpdateMessageEventParser
      {
         return var_15 as ItemStateUpdateMessageEventParser;
      }
   }
}

