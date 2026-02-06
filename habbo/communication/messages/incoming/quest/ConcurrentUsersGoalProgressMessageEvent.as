package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.ConcurrentUsersGoalProgressMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ConcurrentUsersGoalProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ConcurrentUsersGoalProgressMessageEvent(param1:Function)
      {
         super(param1,ConcurrentUsersGoalProgressMessageEventParser);
      }
      
      public function getParser() : ConcurrentUsersGoalProgressMessageEventParser
      {
         return var_15 as ConcurrentUsersGoalProgressMessageEventParser;
      }
   }
}

