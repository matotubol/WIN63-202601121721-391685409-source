package com.sulake.habbo.communication.messages.parser.friendlist
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendNotificationEventParser implements IMessageParser
   {
      
      private var var_2834:int = -1;
      
      private var var_2699:String;
      
      private var var_986:String;
      
      public function FriendNotificationEventParser()
      {
         super();
      }
      
      public function get typeCode() : int
      {
         return var_2834;
      }
      
      public function get avatarId() : String
      {
         return var_2699;
      }
      
      public function get message() : String
      {
         return var_986;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2699 = param1.readString();
         var_2834 = param1.readInteger();
         var_986 = param1.readString();
         return true;
      }
   }
}

