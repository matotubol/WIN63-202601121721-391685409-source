package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.HandItemReceivedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class HandItemReceivedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function HandItemReceivedMessageEvent(param1:Function)
      {
         super(param1,HandItemReceivedMessageEventParser);
      }
      
      public function get giverUserId() : int
      {
         return HandItemReceivedMessageEventParser(var_15).giverUserId;
      }
      
      public function get handItemType() : int
      {
         return HandItemReceivedMessageEventParser(var_15).handItemType;
      }
   }
}

