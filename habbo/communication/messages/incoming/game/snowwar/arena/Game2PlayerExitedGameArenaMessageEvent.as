package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerExitedGameArenaMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerExitedGameArenaMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2PlayerExitedGameArenaMessageEvent(param1:Function)
      {
         super(param1,Game2PlayerExitedGameArenaMessageEventParser);
      }
      
      public function getParser() : Game2PlayerExitedGameArenaMessageEventParser
      {
         return this.var_15 as Game2PlayerExitedGameArenaMessageEventParser;
      }
   }
}

