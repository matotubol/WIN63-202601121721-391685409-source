package com.sulake.habbo.communication.messages.incoming.room.bots
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.bots.BotSkillListUpdateEventParser;
   
   [SecureSWF(rename="true")]
   public class BotSkillListUpdateEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BotSkillListUpdateEvent(param1:Function)
      {
         super(param1,BotSkillListUpdateEventParser);
      }
      
      public function getParser() : BotSkillListUpdateEventParser
      {
         return var_15 as BotSkillListUpdateEventParser;
      }
   }
}

