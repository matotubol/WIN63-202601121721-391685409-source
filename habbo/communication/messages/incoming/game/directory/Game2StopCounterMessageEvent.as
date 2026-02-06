package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2InArenaQueueMessageParser;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2StopCounterMessageParser;
   
   public class Game2StopCounterMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StopCounterMessageEvent(param1:Function)
      {
         super(param1,Game2StopCounterMessageParser);
      }
      
      public function getParser() : Game2InArenaQueueMessageParser
      {
         return this.var_15 as Game2InArenaQueueMessageParser;
      }
   }
}

