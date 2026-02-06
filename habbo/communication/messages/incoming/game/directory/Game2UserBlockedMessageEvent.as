package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2UserBlockedMessageParser;
   
   public class Game2UserBlockedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2UserBlockedMessageEvent(param1:Function)
      {
         super(param1,Game2UserBlockedMessageParser);
      }
      
      public function getParser() : Game2UserBlockedMessageParser
      {
         return this.var_15 as Game2UserBlockedMessageParser;
      }
   }
}

