package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameEndingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameEndingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameEndingMessageEvent(param1:Function)
      {
         super(param1,Game2GameEndingMessageEventParser);
      }
      
      public function getParser() : Game2GameEndingMessageEventParser
      {
         return this.var_15 as Game2GameEndingMessageEventParser;
      }
   }
}

