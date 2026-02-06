package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestCompletedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestCompletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestCompletedMessageEvent(param1:Function)
      {
         super(param1,QuestCompletedMessageEventParser);
      }
      
      public function getParser() : QuestCompletedMessageEventParser
      {
         return var_15 as QuestCompletedMessageEventParser;
      }
   }
}

