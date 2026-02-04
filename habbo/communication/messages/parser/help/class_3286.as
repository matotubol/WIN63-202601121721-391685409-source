package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3286 implements IMessageParser
   {
      
      private var var_4285:int;
      
      private var var_940:String;
      
      public function class_3286()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4285 = param1.readInteger();
         var_940 = param1.readString();
         return true;
      }
      
      public function get closeReason() : int
      {
         return var_4285;
      }
      
      public function get messageText() : String
      {
         return var_940;
      }
   }
}

