package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class GameLobbyPlayerData
   {
      
      public static var var_5199:Function = comparePlayersByTotalScore;
      
      public static var var_3611:Function = comparePlayersBySkillLevel;
      
      private var var_1270:int;
      
      private var _name:String;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_3938:int;
      
      private var var_4480:int;
      
      private var var_4436:int;
      
      private var var_4183:int;
      
      public function GameLobbyPlayerData(param1:IMessageDataWrapper)
      {
         super();
         var_1270 = param1.readInteger();
         _name = param1.readString();
         var_975 = param1.readString();
         var_111 = param1.readString();
         var_3938 = param1.readInteger();
         var_4480 = param1.readInteger();
         var_4436 = param1.readInteger();
         var_4183 = param1.readInteger();
      }
      
      private static function comparePlayersByTotalScore(param1:GameLobbyPlayerData, param2:GameLobbyPlayerData) : Number
      {
         var _loc3_:int = param1.totalScore;
         var _loc4_:int = param2.totalScore;
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ == _loc4_)
         {
            return 0;
         }
         return -1;
      }
      
      private static function comparePlayersBySkillLevel(param1:GameLobbyPlayerData, param2:GameLobbyPlayerData) : Number
      {
         var _loc4_:int = param1.skillLevel;
         var _loc3_:int = param2.skillLevel;
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         if(_loc4_ == _loc3_)
         {
            return 0;
         }
         return -1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get teamId() : int
      {
         return var_3938;
      }
      
      public function get skillLevel() : int
      {
         return var_4480;
      }
      
      public function get totalScore() : int
      {
         return var_4436;
      }
      
      public function get scoreToNextLevel() : int
      {
         return var_4183;
      }
   }
}

