package com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2FullGameStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2FullGameStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2FullGameStatusMessageEvent(param1:Function)
      {
         super(param1,Game2FullGameStatusMessageEventParser);
      }
      
      public function getParser() : Game2FullGameStatusMessageEventParser
      {
         return this.var_15 as Game2FullGameStatusMessageEventParser;
      }
   }
}

