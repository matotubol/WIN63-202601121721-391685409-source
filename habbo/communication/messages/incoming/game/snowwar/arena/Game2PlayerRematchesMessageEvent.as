package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2PlayerRematchesMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2PlayerRematchesMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2PlayerRematchesMessageEvent(param1:Function)
      {
         super(param1,Game2PlayerRematchesMessageEventParser);
      }
      
      public function getParser() : Game2PlayerRematchesMessageEventParser
      {
         return this.var_15 as Game2PlayerRematchesMessageEventParser;
      }
   }
}

