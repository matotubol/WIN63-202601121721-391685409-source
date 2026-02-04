package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3926 implements IMessageParser
   {
      
      private var var_3095:int;
      
      private var var_3307:String;
      
      public function class_3926()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3095 = -1;
         var_3307 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3095 = param1.readInteger();
         var_3307 = param1.readString();
         return true;
      }
      
      public function get votingTimeout() : int
      {
         return var_3095;
      }
      
      public function get chatRecord() : String
      {
         return var_3307;
      }
   }
}

