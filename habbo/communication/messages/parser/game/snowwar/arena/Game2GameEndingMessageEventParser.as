package com.sulake.habbo.communication.messages.parser.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2GameResult;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2SnowWarGameStats;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.Game2TeamScoreData;
   
   [SecureSWF(rename="true")]
   public class Game2GameEndingMessageEventParser implements IMessageParser
   {
      
      private var var_3209:int;
      
      private var _teams:Array;
      
      private var var_810:Array;
      
      private var var_4671:Game2SnowWarGameStats;
      
      private var var_1995:Game2GameResult;
      
      public function Game2GameEndingMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3209 = -1;
         _teams = [];
         var_810 = [];
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3209 = param1.readInteger();
         var_1995 = new Game2GameResult(param1);
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            _teams.push(new Game2TeamScoreData(param1));
            _loc3_++;
         }
         var_4671 = new Game2SnowWarGameStats(param1);
         return true;
      }
      
      public function get timeToNextState() : int
      {
         return var_3209;
      }
      
      public function get teams() : Array
      {
         return _teams;
      }
      
      public function get teamScores() : Array
      {
         return var_810;
      }
      
      public function get gameResult() : Game2GameResult
      {
         return var_1995;
      }
      
      public function get generalStats() : Game2SnowWarGameStats
      {
         return var_4671;
      }
   }
}

