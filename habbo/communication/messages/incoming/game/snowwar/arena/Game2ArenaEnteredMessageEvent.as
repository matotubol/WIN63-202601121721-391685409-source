package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2ArenaEnteredMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2ArenaEnteredMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2ArenaEnteredMessageEvent(param1:Function)
      {
         super(param1,Game2ArenaEnteredMessageEventParser);
      }
      
      public function getParser() : Game2ArenaEnteredMessageEventParser
      {
         return this.var_15 as Game2ArenaEnteredMessageEventParser;
      }
   }
}

