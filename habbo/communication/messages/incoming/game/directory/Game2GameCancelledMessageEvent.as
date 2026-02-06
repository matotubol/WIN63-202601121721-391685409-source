package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCancelledMessageParser;
   
   public class Game2GameCancelledMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameCancelledMessageEvent(param1:Function)
      {
         super(param1,Game2GameCancelledMessageParser);
      }
      
      public function getParser() : Game2GameCancelledMessageParser
      {
         return this.var_15 as Game2GameCancelledMessageParser;
      }
   }
}

