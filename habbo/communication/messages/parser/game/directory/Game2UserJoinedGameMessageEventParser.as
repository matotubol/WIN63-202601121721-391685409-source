package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyPlayerData;
   
   [SecureSWF(rename="true")]
   public class Game2UserJoinedGameMessageEventParser implements IMessageParser
   {
      
      private var var_4991:GameLobbyPlayerData;
      
      private var var_4565:Boolean;
      
      public function Game2UserJoinedGameMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4991 = new GameLobbyPlayerData(param1);
         var_4565 = param1.readBoolean();
         return true;
      }
      
      public function get user() : GameLobbyPlayerData
      {
         return var_4991;
      }
      
      public function get wasTeamSwitched() : Boolean
      {
         return var_4565;
      }
   }
}

