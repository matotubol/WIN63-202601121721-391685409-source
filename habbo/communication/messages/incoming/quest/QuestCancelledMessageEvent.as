package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestCancelledMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestCancelledMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestCancelledMessageEvent(param1:Function)
      {
         super(param1,QuestCancelledMessageEventParser);
      }
      
      public function getParser() : QuestCancelledMessageEventParser
      {
         return var_15 as QuestCancelledMessageEventParser;
      }
   }
}

