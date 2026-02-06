package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageLoadMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageLoadMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StageLoadMessageEvent(param1:Function)
      {
         super(param1,Game2StageLoadMessageEventParser);
      }
      
      public function getParser() : Game2StageLoadMessageEventParser
      {
         return this.var_15 as Game2StageLoadMessageEventParser;
      }
   }
}

