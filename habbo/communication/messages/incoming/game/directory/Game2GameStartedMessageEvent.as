package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameStartedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameStartedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameStartedMessageEvent(param1:Function)
      {
         super(param1,Game2GameStartedMessageEventParser);
      }
      
      public function getParser() : Game2GameStartedMessageEventParser
      {
         return this.var_15 as Game2GameStartedMessageEventParser;
      }
   }
}

