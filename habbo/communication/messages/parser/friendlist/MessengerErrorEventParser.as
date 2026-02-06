package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MessengerErrorEventParser implements IMessageParser
   {
      
      private var var_5215:int;
      
      private var var_2759:int;
      
      public function MessengerErrorEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_5215 = param1.readInteger();
         this.var_2759 = param1.readInteger();
         return true;
      }
      
      public function get clientMessageId() : int
      {
         return this.var_5215;
      }
      
      public function get errorCode() : int
      {
         return this.var_2759;
      }
   }
}

