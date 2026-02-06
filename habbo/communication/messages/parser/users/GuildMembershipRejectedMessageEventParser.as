package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipRejectedMessageEventParser implements IMessageParser
   {
      
      private var var_3004:int;
      
      private var var_1270:int;
      
      public function GuildMembershipRejectedMessageEventParser()
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
         var_1270 = param1.readInteger();
         return true;
      }
      
      public function get guildId() : int
      {
         return var_3004;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
   }
}

