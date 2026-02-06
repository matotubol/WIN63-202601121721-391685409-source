package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GroupMembershipRequestedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GroupMembershipRequestedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GroupMembershipRequestedMessageEvent(param1:Function)
      {
         super(param1,GroupMembershipRequestedMessageEventParser);
      }
      
      public function getParser() : GroupMembershipRequestedMessageEventParser
      {
         return GroupMembershipRequestedMessageEventParser(var_15);
      }
   }
}

