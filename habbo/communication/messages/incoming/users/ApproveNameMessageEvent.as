package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.ApproveNameMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class ApproveNameMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function ApproveNameMessageEvent(param1:Function)
      {
         super(param1,ApproveNameMessageEventParser);
      }
      
      public function getParser() : ApproveNameMessageEventParser
      {
         return var_15 as ApproveNameMessageEventParser;
      }
   }
}

