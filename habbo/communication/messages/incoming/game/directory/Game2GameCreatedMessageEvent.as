package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameCreatedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameCreatedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameCreatedMessageEvent(param1:Function)
      {
         super(param1,Game2GameCreatedMessageEventParser);
      }
      
      public function getParser() : Game2GameCreatedMessageEventParser
      {
         return this.var_15 as Game2GameCreatedMessageEventParser;
      }
   }
}

