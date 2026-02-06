package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class MiniMailUnreadCountEventParser implements IMessageParser
   {
      
      private var var_3859:int;
      
      public function MiniMailUnreadCountEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3859 = param1.readInteger();
         return true;
      }
      
      public function get unreadMessageCount() : int
      {
         return var_3859;
      }
   }
}

