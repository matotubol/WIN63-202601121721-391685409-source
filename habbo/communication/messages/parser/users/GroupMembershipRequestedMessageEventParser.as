package com.sulake.habbo.communication.messages.parser.users
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.users.class_1893;
   
   [SecureSWF(rename="true")]
   public class GroupMembershipRequestedMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      private var var_3147:class_1893;
      
      public function GroupMembershipRequestedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3147 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         var_3147 = new class_1893(param1);
         return true;
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get requester() : class_1893
      {
         return var_3147;
      }
   }
}

