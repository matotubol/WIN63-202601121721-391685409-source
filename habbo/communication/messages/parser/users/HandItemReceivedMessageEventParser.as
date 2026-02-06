package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HandItemReceivedMessageEventParser implements IMessageParser
   {
      
      private var var_2999:int = -1;
      
      private var var_3087:int = 0;
      
      public function HandItemReceivedMessageEventParser()
      {
         super();
      }
      
      public function get giverUserId() : int
      {
         return var_2999;
      }
      
      public function get handItemType() : int
      {
         return var_3087;
      }
      
      public function flush() : Boolean
      {
         var_2999 = -1;
         var_3087 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2999 = param1.readInteger();
         var_3087 = param1.readInteger();
         return true;
      }
   }
}

