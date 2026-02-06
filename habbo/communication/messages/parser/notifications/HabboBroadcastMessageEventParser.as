package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class HabboBroadcastMessageEventParser implements IMessageParser
   {
      
      private var var_940:String = "";
      
      public function HabboBroadcastMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_940 = param1.readString();
         return true;
      }
      
      public function get messageText() : String
      {
         return var_940;
      }
   }
}

