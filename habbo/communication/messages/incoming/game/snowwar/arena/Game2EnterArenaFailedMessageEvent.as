package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2EnterArenaFailedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2EnterArenaFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2EnterArenaFailedMessageEvent(param1:Function)
      {
         super(param1,Game2EnterArenaFailedMessageEventParser);
      }
      
      public function getParser() : Game2EnterArenaFailedMessageEventParser
      {
         return this.var_15 as Game2EnterArenaFailedMessageEventParser;
      }
   }
}

