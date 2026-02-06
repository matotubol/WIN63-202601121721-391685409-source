package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembershipsMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipsMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMembershipsMessageEvent(param1:Function)
      {
         super(param1,GuildMembershipsMessageEventParser);
      }
      
      public function get guilds() : Array
      {
         return GuildMembershipsMessageEventParser(var_15).guilds;
      }
   }
}

