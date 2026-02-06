package com.sulake.habbo.communication.messages.parser.friendfurni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FriendFurniStartConfirmationMessageEventParser implements IMessageParser
   {
      
      private var _stuffId:int;
      
      private var var_3219:Boolean;
      
      public function FriendFurniStartConfirmationMessageEventParser()
      {
         super();
      }
      
      public function get stuffId() : int
      {
         return _stuffId;
      }
      
      public function get isOwner() : Boolean
      {
         return var_3219;
      }
      
      public function flush() : Boolean
      {
         _stuffId = -1;
         var_3219 = false;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _stuffId = param1.readInteger();
         var_3219 = param1.readBoolean();
         return true;
      }
   }
}

