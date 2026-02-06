package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class IssueDeletedMessageEventParser implements IMessageParser
   {
      
      private var var_3038:int;
      
      public function IssueDeletedMessageEventParser()
      {
         super();
      }
      
      public function get issueId() : int
      {
         return var_3038;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3038 = parseInt(param1.readString());
         return true;
      }
   }
}

