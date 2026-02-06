package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotAddedToInventoryEventParser;
   
   [SecureSWF(rename="true")]
   public class BotAddedToInventoryEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BotAddedToInventoryEvent(param1:Function)
      {
         super(param1,BotAddedToInventoryEventParser);
      }
      
      public function getParser() : BotAddedToInventoryEventParser
      {
         return var_15 as BotAddedToInventoryEventParser;
      }
   }
}

