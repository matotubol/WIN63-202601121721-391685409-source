package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2TeamPlayerData
   {
      
      private var var_1270:int;
      
      private var _userName:String;
      
      private var var_808:int;
      
      private var var_975:String;
      
      private var var_111:String;
      
      private var var_4191:Game2PlayerStatsData;
      
      private var var_3938:int;
      
      private var var_2805:Boolean;
      
      public function Game2TeamPlayerData(param1:int, param2:IMessageDataWrapper)
      {
         super();
         var_3938 = param1;
         _userName = param2.readString();
         var_1270 = param2.readInteger();
         var_975 = param2.readString();
         var_111 = param2.readString();
         var_808 = param2.readInteger();
         var_4191 = new Game2PlayerStatsData(param2);
         var_2805 = false;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function get gender() : String
      {
         return var_111;
      }
      
      public function get playerStats() : Game2PlayerStatsData
      {
         return var_4191;
      }
      
      public function get teamId() : int
      {
         return var_3938;
      }
      
      public function get willRejoin() : Boolean
      {
         return var_2805;
      }
      
      public function set willRejoin(param1:Boolean) : void
      {
         var_2805 = param1;
      }
   }
}

