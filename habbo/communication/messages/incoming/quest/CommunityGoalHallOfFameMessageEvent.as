package com.sulake.habbo.communication.messages.incoming.quest
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.quest.CommunityGoalHallOfFameMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class CommunityGoalHallOfFameMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function CommunityGoalHallOfFameMessageEvent(param1:Function)
      {
         super(param1,CommunityGoalHallOfFameMessageEventParser);
      }
      
      public function getParser() : CommunityGoalHallOfFameMessageEventParser
      {
         return var_15 as CommunityGoalHallOfFameMessageEventParser;
      }
   }
}

