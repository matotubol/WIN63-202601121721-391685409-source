package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2PlayerData;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaMessageEventParser implements IMessageParser
   {
      
      private var var_1787:int;
      
      private var var_3224:int;
      
      private var _numberOfTeams:int;
      
      private var _players:Array;
      
      private var var_2721:GameLevelData;
      
      public function Game2EnterArenaMessageEventParser()
      {
         super();
         _players = [];
      }
      
      public function flush() : Boolean
      {
         var_1787 = -1;
         var_3224 = -1;
         _numberOfTeams = -1;
         for each(var _loc1_ in _players)
         {
            _loc1_.dispose();
         }
         _players = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1787 = param1.readInteger();
         var_3224 = param1.readInteger();
         _numberOfTeams = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:Game2PlayerData = new Game2PlayerData();
            _loc4_.parse(param1);
            _players.push(null);
            _loc3_++;
         }
         var_2721 = new GameLevelData(param1);
         return true;
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
      
      public function get players() : Array
      {
         return _players;
      }
      
      public function get gameLevel() : GameLevelData
      {
         return var_2721;
      }
   }
}

