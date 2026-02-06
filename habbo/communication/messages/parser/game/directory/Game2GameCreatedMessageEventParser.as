package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   
   [SecureSWF(rename="true")]
   public class Game2GameCreatedMessageEventParser implements IMessageParser
   {
      
      private var var_3927:GameLobbyData;
      
      public function Game2GameCreatedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3927 = new GameLobbyData(param1);
         return true;
      }
      
      public function get gameLobbyData() : GameLobbyData
      {
         return var_3927;
      }
   }
}

