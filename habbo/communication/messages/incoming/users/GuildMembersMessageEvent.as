package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMembersMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembersMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMembersMessageEvent(param1:Function)
      {
         super(param1,GuildMembersMessageEventParser);
      }
      
      public function get data() : class_1864
      {
         return GuildMembersMessageEventParser(var_15).data;
      }
   }
}

