package com.sulake.habbo.communication.messages.incoming.handshake
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.handshake.UserRightsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class UserRightsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function UserRightsMessageEvent(param1:Function)
      {
         super(param1,UserRightsMessageEventParser);
      }
      
      public function get clubLevel() : int
      {
         return (this.var_15 as UserRightsMessageEventParser).clubLevel;
      }
      
      public function get securityLevel() : int
      {
         return (this.var_15 as UserRightsMessageEventParser).securityLevel;
      }
      
      public function get isAmbassador() : Boolean
      {
         return (this.var_15 as UserRightsMessageEventParser).isAmbassador;
      }
   }
}

