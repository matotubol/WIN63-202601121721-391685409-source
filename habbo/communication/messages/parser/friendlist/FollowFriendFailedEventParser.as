package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FollowFriendFailedEventParser implements IMessageParser
   {
      
      private var var_2759:int;
      
      public function FollowFriendFailedEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_2759 = param1.readInteger();
         return true;
      }
      
      public function get errorCode() : int
      {
         return this.var_2759;
      }
   }
}

