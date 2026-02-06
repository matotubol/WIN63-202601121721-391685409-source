package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameRejoinMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameRejoinMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameRejoinMessageEvent(param1:Function)
      {
         super(param1,Game2GameRejoinMessageEventParser);
      }
      
      public function getParser() : Game2GameRejoinMessageEventParser
      {
         return this.var_15 as Game2GameRejoinMessageEventParser;
      }
   }
}

