package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameLongDataMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameLongDataMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameLongDataMessageEvent(param1:Function)
      {
         super(param1,Game2GameLongDataMessageEventParser);
      }
      
      public function getParser() : Game2GameLongDataMessageEventParser
      {
         return this.var_15 as Game2GameLongDataMessageEventParser;
      }
   }
}

