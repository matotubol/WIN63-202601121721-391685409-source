package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FindFriendsProcessResultEventParser implements IMessageParser
   {
      
      private var var_2614:Boolean;
      
      public function FindFriendsProcessResultEventParser()
      {
         super();
      }
      
      public function get success() : Boolean
      {
         return var_2614;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2614 = param1.readBoolean();
         return true;
      }
   }
}

