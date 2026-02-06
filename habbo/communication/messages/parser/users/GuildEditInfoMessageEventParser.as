package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_1819;
   
   [SecureSWF(rename="true")]
   public class GuildEditInfoMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_1819;
      
      public function GuildEditInfoMessageEventParser()
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
         var_24 = new class_1819(param1);
         return true;
      }
      
      public function get data() : class_1819
      {
         return var_24;
      }
   }
}

