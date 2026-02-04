package com.sulake.habbo.game.snowwar.arena
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.GameLevelData;
   
   public interface class_2692 extends class_13
   {
      
      function initialize(param1:SynchronizedGameArena, param2:GameLevelData) : void;
      
      function get gameArena() : SynchronizedGameArena;
      
      function get roomType() : String;
   }
}

