package com.sulake.habbo.communication.messages.incoming.notifications
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.notifications.RestoreClientMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class RestoreClientMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function RestoreClientMessageEvent(param1:Function)
      {
         super(param1,RestoreClientMessageEventParser);
      }
      
      public function getParser() : RestoreClientMessageEventParser
      {
         return var_15 as RestoreClientMessageEventParser;
      }
   }
}

