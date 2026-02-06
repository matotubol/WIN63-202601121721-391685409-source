package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalProgressMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CommunityGoalProgressMessageEvent(param1:Function)
      {
         super(param1,CommunityGoalProgressMessageEventParser);
      }
      
      public function getParser() : CommunityGoalProgressMessageEventParser
      {
         return var_15 as CommunityGoalProgressMessageEventParser;
      }
   }
}

