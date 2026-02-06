package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserBannedMessageEventParser implements IMessageParser
   {
      
      private var var_986:String;
      
      public function UserBannedMessageEventParser()
      {
         super();
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function flush() : Boolean
      {
         var_986 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_986 = param1.readString();
         return true;
      }
   }
}

