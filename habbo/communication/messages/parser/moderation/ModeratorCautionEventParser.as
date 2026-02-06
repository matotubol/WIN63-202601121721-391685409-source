package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ModeratorCautionEventParser implements IMessageParser
   {
      
      private var var_986:String;
      
      private var var_989:String;
      
      public function ModeratorCautionEventParser()
      {
         super();
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function flush() : Boolean
      {
         var_986 = "";
         var_989 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_986 = param1.readString();
         var_989 = param1.readString();
         return true;
      }
   }
}

