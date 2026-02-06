package com.sulake.habbo.communication.messages.incoming.game.snowwar.arena
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.arena.Game2GameChatFromPlayerMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class Game2GameChatFromPlayerMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameChatFromPlayerMessageEvent(param1:Function)
      {
         super(param1,Game2GameChatFromPlayerMessageEventParser);
      }
      
      public function getParser() : Game2GameChatFromPlayerMessageEventParser
      {
         return this.var_15 as Game2GameChatFromPlayerMessageEventParser;
      }
   }
}

