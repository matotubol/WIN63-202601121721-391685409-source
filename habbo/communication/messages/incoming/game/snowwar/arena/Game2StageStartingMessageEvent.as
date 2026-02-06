package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStartingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageStartingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StageStartingMessageEvent(param1:Function)
      {
         super(param1,Game2StageStartingMessageEventParser);
      }
      
      public function getParser() : Game2StageStartingMessageEventParser
      {
         return this.var_15 as Game2StageStartingMessageEventParser;
      }
   }
}

