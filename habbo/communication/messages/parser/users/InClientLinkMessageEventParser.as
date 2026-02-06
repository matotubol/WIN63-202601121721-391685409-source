package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InClientLinkMessageEventParser implements IMessageParser
   {
      
      private var var_777:String;
      
      public function InClientLinkMessageEventParser()
      {
         super();
      }
      
      public function get link() : String
      {
         return var_777;
      }
      
      public function flush() : Boolean
      {
         var_777 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_777 = param1.readString();
         return true;
      }
   }
}

