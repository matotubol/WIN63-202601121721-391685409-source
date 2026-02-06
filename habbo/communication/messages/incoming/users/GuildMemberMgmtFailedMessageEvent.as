package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMemberMgmtFailedMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberMgmtFailedMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMemberMgmtFailedMessageEvent(param1:Function)
      {
         super(param1,GuildMemberMgmtFailedMessageEventParser);
      }
      
      public function get reason() : int
      {
         return GuildMemberMgmtFailedMessageEventParser(var_15).reason;
      }
      
      public function get guildId() : int
      {
         return GuildMemberMgmtFailedMessageEventParser(var_15).guildId;
      }
   }
}

