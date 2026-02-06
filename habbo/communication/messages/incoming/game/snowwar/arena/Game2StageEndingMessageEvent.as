package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageEndingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageEndingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StageEndingMessageEvent(param1:Function)
      {
         super(param1,Game2StageEndingMessageEventParser);
      }
      
      public function getParser() : Game2StageEndingMessageEventParser
      {
         return this.var_15 as Game2StageEndingMessageEventParser;
      }
   }
}

