package com.sulake.habbo.communication.messages.parser.help
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3936 implements IMessageParser
   {
      
      private var var_2943:int;
      
      private var var_3179:String;
      
      public function class_3936()
      {
         super();
      }
      
      public function get questionId() : int
      {
         return var_2943;
      }
      
      public function get answerText() : String
      {
         return var_3179;
      }
      
      public function flush() : Boolean
      {
         var_2943 = -1;
         var_3179 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2943 = param1.readInteger();
         var_3179 = param1.readString();
         return true;
      }
   }
}

