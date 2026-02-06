package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembershipRejectedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipRejectedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMembershipRejectedMessageEvent(param1:Function)
      {
         super(param1,GuildMembershipRejectedMessageEventParser);
      }
      
      public function getParser() : GuildMembershipRejectedMessageEventParser
      {
         return GuildMembershipRejectedMessageEventParser(var_15);
      }
   }
}

