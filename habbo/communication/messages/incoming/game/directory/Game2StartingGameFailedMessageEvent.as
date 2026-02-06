package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2StartingGameFailedMessageParser;
   
   public class Game2StartingGameFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2StartingGameFailedMessageEvent(param1:Function)
      {
         super(param1,Game2StartingGameFailedMessageParser);
      }
      
      public function getParser() : Game2StartingGameFailedMessageParser
      {
         return this.var_15 as Game2StartingGameFailedMessageParser;
      }
   }
}

