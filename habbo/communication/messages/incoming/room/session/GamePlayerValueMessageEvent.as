package com.sulake.habbo.communication.messages.incoming.room.session
{
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.session.GamePlayerValueMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GamePlayerValueMessageEvent extends MessageEvent
   {
      
      public function GamePlayerValueMessageEvent(param1:Function)
      {
         super(param1,GamePlayerValueMessageEventParser);
      }
      
      public function getParser() : GamePlayerValueMessageEventParser
      {
         return var_15 as GamePlayerValueMessageEventParser;
      }
   }
}

