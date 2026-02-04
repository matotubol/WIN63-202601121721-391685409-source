package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   public class DefaultGameStage implements class_2692
   {
      
      protected var var_112:SynchronizedGameArena;
      
      protected var var_2721:GameLevelData;
      
      private var var_1134:Boolean = false;
      
      public function DefaultGameStage()
      {
         super();
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         var_112 = null;
         var_2721 = null;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function initialize(param1:SynchronizedGameArena, param2:GameLevelData) : void
      {
         var_112 = param1;
         var_2721 = param2;
      }
      
      public function get gameArena() : SynchronizedGameArena
      {
         return var_112;
      }
      
      public function get gameLevelData() : GameLevelData
      {
         return var_2721;
      }
      
      public function get roomType() : String
      {
         return "";
      }
   }
}

