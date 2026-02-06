package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UserTypingMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var var_874:Boolean = false;
      
      public function UserTypingMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get isTyping() : Boolean
      {
         return var_874;
      }
      
      public function flush() : Boolean
      {
         var_1270 = 0;
         var_874 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1270 = param1.readInteger();
         var_874 = param1.readInteger() == 1;
         return true;
      }
   }
}

