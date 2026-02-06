package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.NowPlayingMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NowPlayingMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NowPlayingMessageEvent(param1:Function)
      {
         super(param1,NowPlayingMessageEventParser);
      }
      
      public function getParser() : NowPlayingMessageEventParser
      {
         return this.var_15 as NowPlayingMessageEventParser;
      }
   }
}

