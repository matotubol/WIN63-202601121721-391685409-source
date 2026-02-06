package com.sulake.habbo.communication.messages.incoming.room.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotForceOpenContextMenuEventParser;
   
   [SecureSWF(rename="true")]
   public class BotForceOpenContextMenuEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BotForceOpenContextMenuEvent(param1:Function)
      {
         super(param1,BotForceOpenContextMenuEventParser);
      }
      
      public function getParser() : BotForceOpenContextMenuEventParser
      {
         return var_15 as BotForceOpenContextMenuEventParser;
      }
   }
}

