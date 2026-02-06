package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.PlayListMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class PlayListMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function PlayListMessageEvent(param1:Function)
      {
         super(param1,PlayListMessageEventParser);
      }
      
      public function getParser() : PlayListMessageEventParser
      {
         return this.var_15 as PlayListMessageEventParser;
      }
   }
}

