package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ApproveNameMessageEventParser implements IMessageParser
   {
      
      private var var_1122:int;
      
      private var _nameValidationInfo:String;
      
      public function ApproveNameMessageEventParser()
      {
         super();
      }
      
      public function get result() : int
      {
         return var_1122;
      }
      
      public function get nameValidationInfo() : String
      {
         return _nameValidationInfo;
      }
      
      public function flush() : Boolean
      {
         var_1122 = -1;
         _nameValidationInfo = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1122 = param1.readInteger();
         _nameValidationInfo = param1.readString();
         return true;
      }
   }
}

