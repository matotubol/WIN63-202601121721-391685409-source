package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class InstantMessageErrorEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      private var var_1270:int;
      
      private var var_986:String;
      
      public function InstantMessageErrorEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2759 = param1.readInteger();
         this.var_1270 = param1.readInteger();
         this.var_986 = param1.readString();
         return true;
      }
      
      public function get errorCode() : int
      {
         return this.var_2759;
      }
      
      public function get userId() : int
      {
         return this.var_1270;
      }
      
      public function get message() : String
      {
         return this.var_986;
      }
   }
}

