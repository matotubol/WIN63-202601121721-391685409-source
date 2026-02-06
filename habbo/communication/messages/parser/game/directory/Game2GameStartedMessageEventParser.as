package com.sulake.habbo.communication.messages.parser.game.directory
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLobbyData;
   
   [SecureSWF(rename="true")]
   public class Game2GameStartedMessageEventParser implements IMessageParser
   {
      
      private var var_3258:GameLobbyData;
      
      public function Game2GameStartedMessageEventParser()
      {
         super();
      }
      
      public function get lobbyData() : GameLobbyData
      {
         return var_3258;
      }
      
      public function flush() : Boolean
      {
         var_3258 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3258 = new GameLobbyData(param1);
         return true;
      }
   }
}

