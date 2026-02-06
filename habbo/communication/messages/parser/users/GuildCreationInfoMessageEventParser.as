package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_1843;
   
   [SecureSWF(rename="true")]
   public class GuildCreationInfoMessageEventParser implements IMessageParser
   {
      
      private var var_24:class_1843;
      
      public function GuildCreationInfoMessageEventParser()
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
         var_24 = new class_1843(param1);
         return true;
      }
      
      public function get data() : class_1843
      {
         return var_24;
      }
   }
}

