package com.sulake.habbo.communication.messages.incoming.users
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.users.GuildMemberFurniCountInHQMessageEventParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberFurniCountInHQMessageEvent extends MessageEvent implements IMessageEvent
   {
      
      public function GuildMemberFurniCountInHQMessageEvent(param1:Function)
      {
         super(param1,GuildMemberFurniCountInHQMessageEventParser);
      }
      
      public function userId() : int
      {
         return GuildMemberFurniCountInHQMessageEventParser(var_15).userId;
      }
      
      public function furniCount() : int
      {
         return GuildMemberFurniCountInHQMessageEventParser(var_15).furniCount;
      }
   }
}

