package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameNotFoundMessageParser;
   
   public class Game2GameNotFoundMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameNotFoundMessageEvent(param1:Function)
      {
         super(param1,Game2GameNotFoundMessageParser);
      }
      
      public function getParser() : Game2GameNotFoundMessageParser
      {
         return this.var_15 as Game2GameNotFoundMessageParser;
      }
   }
}

