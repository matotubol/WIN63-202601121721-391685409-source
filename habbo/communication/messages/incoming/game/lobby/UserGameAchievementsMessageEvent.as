package com.sulake.habbo.communication.messages.incoming.game.lobby
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.lobby.UserGameAchievementsMessageParser;
   
   public class UserGameAchievementsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserGameAchievementsMessageEvent(param1:Function)
      {
         super(param1,UserGameAchievementsMessageParser);
      }
      
      public function getParser() : UserGameAchievementsMessageParser
      {
         return this.var_15 as UserGameAchievementsMessageParser;
      }
   }
}

