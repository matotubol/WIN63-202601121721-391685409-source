package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.NoobnessLevelMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class NoobnessLevelMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function NoobnessLevelMessageEvent(param1:Function)
      {
         super(param1,NoobnessLevelMessageEventParser);
      }
      
      public function get noobnessLevel() : int
      {
         return (this.var_15 as NoobnessLevelMessageEventParser).noobnessLevel;
      }
   }
}

