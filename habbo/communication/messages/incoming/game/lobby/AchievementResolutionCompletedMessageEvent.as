package com.sulake.habbo.communication.messages.incoming.game.lobby
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.lobby.AchievementResolutionCompletedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AchievementResolutionCompletedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AchievementResolutionCompletedMessageEvent(param1:Function)
      {
         super(param1,AchievementResolutionCompletedMessageEventParser);
      }
      
      public function getParser() : AchievementResolutionCompletedMessageEventParser
      {
         return this.var_15 as AchievementResolutionCompletedMessageEventParser;
      }
   }
}

