package com.sulake.habbo.communication.messages.parser.friendfurni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniOtherLockConfirmedMessageEventParser implements IMessageParser
   {
      
      private var _stuffId:int;
      
      public function FriendFurniOtherLockConfirmedMessageEventParser()
      {
         super();
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         return true;
      }
   }
}

