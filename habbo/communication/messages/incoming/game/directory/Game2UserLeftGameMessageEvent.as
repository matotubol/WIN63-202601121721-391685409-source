package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserLeftGameMessageParser;
   
   public class Game2UserLeftGameMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2UserLeftGameMessageEvent(param1:Function)
      {
         super(param1,Game2UserLeftGameMessageParser);
      }
      
      public function getParser() : Game2UserLeftGameMessageParser
      {
         return this.var_15 as Game2UserLeftGameMessageParser;
      }
   }
}

