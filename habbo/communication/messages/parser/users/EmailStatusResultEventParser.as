package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class EmailStatusResultEventParser implements IMessageParser
   {
      
      private var var_4346:String;
      
      private var var_4945:Boolean;
      
      private var var_4331:Boolean;
      
      public function EmailStatusResultEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4346 = param1.readString();
         var_4945 = param1.readBoolean();
         var_4331 = param1.readBoolean();
         return true;
      }
      
      public function get email() : String
      {
         return var_4346;
      }
      
      public function get isVerified() : Boolean
      {
         return var_4945;
      }
      
      public function get allowChange() : Boolean
      {
         return var_4331;
      }
   }
}

