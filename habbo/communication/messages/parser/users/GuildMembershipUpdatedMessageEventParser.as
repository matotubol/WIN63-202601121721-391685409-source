package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_1893;
   
   [SecureSWF(rename="true")]
   public class GuildMembershipUpdatedMessageEventParser implements IMessageParser
   {
      
      private var var_3004:int;
      
      private var var_24:class_1893;
      
      public function GuildMembershipUpdatedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_24 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3004 = param1.readInteger();
         var_24 = new class_1893(param1);
         return true;
      }
      
      public function get guildId() : int
      {
         return var_3004;
      }
      
      public function get data() : class_1893
      {
         return var_24;
      }
   }
}

