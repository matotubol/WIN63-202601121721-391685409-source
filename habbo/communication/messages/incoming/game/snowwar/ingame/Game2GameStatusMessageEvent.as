package com.sulake.habbo.communication.messages.incoming.game.snowwar.ingame
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.ingame.Game2GameStatusMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameStatusMessageEvent(param1:Function)
      {
         super(param1,Game2GameStatusMessageEventParser);
      }
      
      public function getParser() : Game2GameStatusMessageEventParser
      {
         return this.var_15 as Game2GameStatusMessageEventParser;
      }
   }
}

