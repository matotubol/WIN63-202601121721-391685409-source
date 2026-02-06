package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.BlockListMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class BlockListMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function BlockListMessageEvent(param1:Function)
      {
         super(param1,BlockListMessageEventParser);
      }
      
      public function get blockedUserIds() : Array
      {
         return (var_15 as BlockListMessageEventParser).blockedUsers;
      }
   }
}

