package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class GroupDetailsChangedMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      public function GroupDetailsChangedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         return true;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
   }
}

