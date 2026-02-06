package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UnreadForumsCountMessageEventParser implements IMessageParser
   {
      
      private var var_3335:int;
      
      public function UnreadForumsCountMessageEventParser()
      {
         super();
      }
      
      public function get unreadForumsCount() : int
      {
         return var_3335;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3335 = param1.readInteger();
         return true;
      }
   }
}

