package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.QuestMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class QuestMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function QuestMessageEvent(param1:Function)
      {
         super(param1,QuestMessageEventParser);
      }
      
      public function getParser() : QuestMessageEventParser
      {
         return var_15 as QuestMessageEventParser;
      }
   }
}

