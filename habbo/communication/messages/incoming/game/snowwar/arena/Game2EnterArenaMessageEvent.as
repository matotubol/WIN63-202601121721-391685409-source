package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2EnterArenaMessageEvent(param1:Function)
      {
         super(param1,Game2EnterArenaMessageEventParser);
      }
      
      public function getParser() : Game2EnterArenaMessageEventParser
      {
         return this.var_15 as Game2EnterArenaMessageEventParser;
      }
   }
}

