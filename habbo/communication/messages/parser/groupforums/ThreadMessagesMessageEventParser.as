package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ThreadMessagesMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      private var var_2326:int;
      
      private var var_369:int;
      
      private var _amount:int;
      
      private var var_2613:Array;
      
      public function ThreadMessagesMessageEventParser()
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
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get messages() : Array
      {
         return var_2613;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         var_2326 = -1;
         var_369 = -1;
         _amount = -1;
         var_2613 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         var_2326 = param1.readInteger();
         var_369 = param1.readInteger();
         _amount = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < _amount)
         {
            var _loc3_:class_2670 = class_2670.readFromMessage(param1);
            null.groupID = _groupId;
            null.threadId = var_2326;
            var_2613.push(null);
            _loc2_++;
         }
         return true;
      }
   }
}

