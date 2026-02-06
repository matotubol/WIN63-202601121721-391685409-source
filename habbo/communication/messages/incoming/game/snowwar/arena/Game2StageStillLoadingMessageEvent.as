package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2StageStillLoadingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2StageStillLoadingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StageStillLoadingMessageEvent(param1:Function)
      {
         super(param1,Game2StageStillLoadingMessageEventParser);
      }
      
      public function getParser() : Game2StageStillLoadingMessageEventParser
      {
         return this.var_15 as Game2StageStillLoadingMessageEventParser;
      }
   }
}

