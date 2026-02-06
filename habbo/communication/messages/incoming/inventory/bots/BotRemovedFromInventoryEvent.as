package com.sulake.habbo.communication.messages.incoming.inventory.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.inventory.bots.BotRemovedFromInventoryEventParser;
   
   [SecureSWF(rename="true")]
   public class BotRemovedFromInventoryEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BotRemovedFromInventoryEvent(param1:Function)
      {
         super(param1,BotRemovedFromInventoryEventParser);
      }
      
      public function getParser() : BotRemovedFromInventoryEventParser
      {
         return var_15 as BotRemovedFromInventoryEventParser;
      }
   }
}

