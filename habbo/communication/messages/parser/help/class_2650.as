package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_2650 implements IMessageParser
   {
      
      private var var_4527:String;
      
      public function class_2650()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4527 = param1.readString();
         return true;
      }
      
      public function get infoUrl() : String
      {
         return var_4527;
      }
   }
}

