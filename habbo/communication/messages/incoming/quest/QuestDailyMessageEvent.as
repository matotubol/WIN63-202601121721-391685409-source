package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestDailyMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestDailyMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestDailyMessageEvent(param1:Function)
      {
         super(param1,QuestDailyMessageEventParser);
      }
      
      public function getParser() : QuestDailyMessageEventParser
      {
         return var_15 as QuestDailyMessageEventParser;
      }
   }
}

