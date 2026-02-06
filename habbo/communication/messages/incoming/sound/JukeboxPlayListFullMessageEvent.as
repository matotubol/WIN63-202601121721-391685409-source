package com.sulake.habbo.communication.messages.incoming.sound
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.sound.JukeboxPlayListFullMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class JukeboxPlayListFullMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function JukeboxPlayListFullMessageEvent(param1:Function)
      {
         super(param1,JukeboxPlayListFullMessageEventParser);
      }
      
      public function getParser() : JukeboxPlayListFullMessageEventParser
      {
         return this.var_15 as JukeboxPlayListFullMessageEventParser;
      }
   }
}

