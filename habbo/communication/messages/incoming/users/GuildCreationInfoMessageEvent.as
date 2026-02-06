package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildCreationInfoMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildCreationInfoMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildCreationInfoMessageEvent(param1:Function)
      {
         super(param1,GuildCreationInfoMessageEventParser);
      }
      
      public function get data() : class_1843
      {
         return GuildCreationInfoMessageEventParser(var_15).data;
      }
   }
}

