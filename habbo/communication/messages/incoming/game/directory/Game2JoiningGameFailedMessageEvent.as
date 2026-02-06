package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2JoiningGameFailedMessageParser;
   
   public class Game2JoiningGameFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2JoiningGameFailedMessageEvent(param1:Function)
      {
         super(param1,Game2JoiningGameFailedMessageParser);
      }
      
      public function getParser() : Game2JoiningGameFailedMessageParser
      {
         return this.var_15 as Game2JoiningGameFailedMessageParser;
      }
   }
}

