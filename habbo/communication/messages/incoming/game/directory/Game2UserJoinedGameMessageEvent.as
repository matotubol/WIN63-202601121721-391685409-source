package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserJoinedGameMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2UserJoinedGameMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2UserJoinedGameMessageEvent(param1:Function)
      {
         super(param1,Game2UserJoinedGameMessageEventParser);
      }
      
      public function getParser() : Game2UserJoinedGameMessageEventParser
      {
         return this.var_15 as Game2UserJoinedGameMessageEventParser;
      }
   }
}

