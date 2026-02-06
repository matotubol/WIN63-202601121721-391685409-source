package com.sulake.habbo.communication.messages.incoming.game.lobby
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionProgressMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionProgressMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AchievementResolutionProgressMessageEvent(param1:Function)
      {
         super(param1,AchievementResolutionProgressMessageEventParser);
      }
      
      public function getParser() : AchievementResolutionProgressMessageEventParser
      {
         return this.var_15 as AchievementResolutionProgressMessageEventParser;
      }
   }
}

