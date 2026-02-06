package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumThreadsMessageEventParser implements IMessageParser
   {
      
      private var _groupId:int;
      
      private var var_369:int;
      
      private var _amount:int;
      
      private var var_3704:Array;
      
      public function ForumThreadsMessageEventParser()
      {
         super();
      }
      
      public function get groupId() : int
      {
         return _groupId;
      }
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get threads() : Array
      {
         return var_3704;
      }
      
      public function flush() : Boolean
      {
         _groupId = -1;
         var_369 = -1;
         _amount = -1;
         var_3704 = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _groupId = param1.readInteger();
         var_369 = param1.readInteger();
         _amount = param1.readInteger();
         var _loc2_:int = 0;
         while(0 < amount)
         {
            var_3704.push(class_3434.readFromMessage(param1));
            _loc2_++;
         }
         return true;
      }
   }
}

