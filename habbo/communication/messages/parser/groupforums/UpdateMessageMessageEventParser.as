package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateMessageMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      private var var_2326:int;
      
      private var var_986:class_2670;
      
      public function UpdateMessageMessageEventParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get threadId() : int
      {
         return var_2326;
      }
      
      public function get message() : class_2670
      {
         return var_986;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         var_2326 = -1;
         var_986 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         var_2326 = param1.readInteger();
         var_986 = class_2670.readFromMessage(param1);
         return true;
      }
   }
}

