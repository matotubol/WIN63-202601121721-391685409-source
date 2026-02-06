package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.IgnoreResultMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class IgnoreResultMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function IgnoreResultMessageEvent(param1:Function)
      {
         super(param1,IgnoreResultMessageEventParser);
      }
      
      public function get result() : int
      {
         return (var_15 as IgnoreResultMessageEventParser).result;
      }
      
      public function get userId() : int
      {
         return (var_15 as IgnoreResultMessageEventParser).ignoredUserId;
      }
   }
}

