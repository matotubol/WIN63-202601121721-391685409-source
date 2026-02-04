package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLobbyData
   {
      
      private var var_4977:int;
      
      private var _levelName:String;
      
      private var var_1787:int;
      
      private var var_3224:int;
      
      private var _numberOfTeams:int;
      
      private var var_4655:int;
      
      private var var_4668:String;
      
      private var var_4587:int;
      
      private var _players:Array = [];
      
      public function GameLobbyData(param1:IMessageDataWrapper)
      {
         super();
         var_4977 = param1.readInteger();
         _levelName = param1.readString();
         var_1787 = param1.readInteger();
         var_3224 = param1.readInteger();
         _numberOfTeams = param1.readInteger();
         var_4655 = param1.readInteger();
         var_4668 = param1.readString();
         var_4587 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _players.push(new GameLobbyPlayerData(param1));
            _loc3_++;
         }
      }
      
      public function get gameId() : int
      {
         return var_4977;
      }
      
      public function get gameType() : int
      {
         return var_1787;
      }
      
      public function get fieldType() : int
      {
         return var_3224;
      }
      
      public function get numberOfTeams() : int
      {
         return _numberOfTeams;
      }
      
      public function get maximumPlayers() : int
      {
         return var_4655;
      }
      
      public function get owningPlayerName() : String
      {
         return var_4668;
      }
      
      public function get levelEntryId() : int
      {
         return var_4587;
      }
      
      public function get players() : Array
      {
         return _players;
      }
   }
}

