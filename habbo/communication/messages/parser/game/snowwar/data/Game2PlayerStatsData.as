package com.sulake.habbo.communication.messages.parser.game.snowwar.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class Game2PlayerStatsData
   {
      
      private var var_808:int;
      
      private var var_4276:int;
      
      private var var_4211:int;
      
      private var var_4837:int;
      
      private var var_4234:int;
      
      private var var_4707:int;
      
      private var var_3871:int;
      
      private var var_4254:int;
      
      private var var_4356:int;
      
      private var var_4230:int;
      
      public function Game2PlayerStatsData(param1:IMessageDataWrapper)
      {
         super();
         var_808 = param1.readInteger();
         var_4276 = param1.readInteger();
         var_4211 = param1.readInteger();
         var_4837 = param1.readInteger();
         var_4234 = param1.readInteger();
         var_4707 = param1.readInteger();
         var_3871 = param1.readInteger();
         var_4254 = param1.readInteger();
         var_4356 = param1.readInteger();
         var_4230 = param1.readInteger();
      }
      
      public function get score() : int
      {
         return var_808;
      }
      
      public function get kills() : int
      {
         return var_4276;
      }
      
      public function get deaths() : int
      {
         return var_4211;
      }
      
      public function get snowballHits() : int
      {
         return var_4837;
      }
      
      public function get snowballHitsTaken() : int
      {
         return var_4234;
      }
      
      public function get snowballsThrown() : int
      {
         return var_4707;
      }
      
      public function get snowballsCreated() : int
      {
         return var_3871;
      }
      
      public function get snowballsFromMachine() : int
      {
         return var_4254;
      }
      
      public function get friendlyHits() : int
      {
         return var_4356;
      }
      
      public function get friendlyKills() : int
      {
         return var_4230;
      }
   }
}

