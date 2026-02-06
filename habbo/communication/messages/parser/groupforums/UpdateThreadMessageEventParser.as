package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class UpdateThreadMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      private var var_3310:class_3434;
      
      public function UpdateThreadMessageEventParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get thread() : class_3434
      {
         return var_3310;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         var_3310 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         var_3310 = class_3434.readFromMessage(param1);
         return true;
      }
   }
}

