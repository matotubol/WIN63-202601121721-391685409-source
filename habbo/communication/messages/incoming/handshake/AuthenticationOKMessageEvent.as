package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.AuthenticationOKMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class AuthenticationOKMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function AuthenticationOKMessageEvent(param1:Function)
      {
         super(param1,AuthenticationOKMessageEventParser);
      }
      
      public function get suggestedLoginActions() : Array
      {
         return (this.var_15 as AuthenticationOKMessageEventParser).suggestedLoginActions;
      }
   }
}

