package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_3702;
   
   [SecureSWF(rename="true")]
   public class UserChatlogEventParser implements IMessageParser
   {
      
      private var var_24:class_3702;
      
      public function UserChatlogEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_24 = new class_3702(param1);
         return true;
      }
      
      public function get data() : class_3702
      {
         return var_24;
      }
   }
}

