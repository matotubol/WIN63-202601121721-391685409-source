package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CallForHelpResultMessageEventParser implements IMessageParser
   {
      
      private var var_2830:int;
      
      private var var_940:String;
      
      public function CallForHelpResultMessageEventParser()
      {
         super();
      }
      
      public function get resultType() : int
      {
         return var_2830;
      }
      
      public function get messageText() : String
      {
         return var_940;
      }
      
      public function flush() : Boolean
      {
         var_2830 = -1;
         var_940 = "";
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2830 = param1.readInteger();
         var_940 = param1.readString();
         return true;
      }
   }
}

