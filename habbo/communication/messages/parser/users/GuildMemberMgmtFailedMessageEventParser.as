package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMemberMgmtFailedMessageEventParser implements IMessageParser
   {
      
      private var var_3004:int;
      
      private var var_2352:int;
      
      public function GuildMemberMgmtFailedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3004 = param1.readInteger();
         var_2352 = param1.readInteger();
         return true;
      }
      
      public function get guildId() : int
      {
         return var_3004;
      }
      
      public function get reason() : int
      {
         return var_2352;
      }
   }
}

