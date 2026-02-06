package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembershipUpdatedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipUpdatedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMembershipUpdatedMessageEvent(param1:Function)
      {
         super(param1,GuildMembershipUpdatedMessageEventParser);
      }
      
      public function get data() : class_1893
      {
         return GuildMembershipUpdatedMessageEventParser(var_15).data;
      }
      
      public function get guildId() : int
      {
         return GuildMembershipUpdatedMessageEventParser(var_15).guildId;
      }
   }
}

