package com.sulake.habbo.communication.messages.incoming.game.directory
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.game.directory.Game2GameDirectoryStatusMessageParser;
   
   public class Game2GameDirectoryStatusMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function Game2GameDirectoryStatusMessageEvent(param1:Function)
      {
         super(param1,Game2GameDirectoryStatusMessageParser);
      }
      
      public function getParser() : Game2GameDirectoryStatusMessageParser
      {
         return this.var_15 as Game2GameDirectoryStatusMessageParser;
      }
   }
}

