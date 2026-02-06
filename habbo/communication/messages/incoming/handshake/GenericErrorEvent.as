package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.GenericErrorEventParser;
   
   [SecureSWF(rename="true")]
   public class GenericErrorEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GenericErrorEvent(param1:Function)
      {
         super(param1,GenericErrorEventParser);
      }
      
      public function getParser() : GenericErrorEventParser
      {
         return this.var_15 as GenericErrorEventParser;
      }
   }
}

