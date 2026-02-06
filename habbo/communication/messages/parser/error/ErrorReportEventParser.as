package com.sulake.habbo.communication.messages.parser.error
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ErrorReportEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      private var var_2915:int;
      
      private var var_2857:String;
      
      public function ErrorReportEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2915 = param1.readInteger();
         var_2759 = param1.readInteger();
         var_2857 = param1.readString();
         return true;
      }
      
      public function flush() : Boolean
      {
         var_2759 = 0;
         var_2915 = 0;
         var_2857 = null;
         return true;
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function get messageId() : int
      {
         return var_2915;
      }
      
      public function get timestamp() : String
      {
         return var_2857;
      }
   }
}

