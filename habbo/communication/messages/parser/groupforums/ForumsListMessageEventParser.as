package com.sulake.habbo.communication.messages.parser.groupforums
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ForumsListMessageEventParser implements IMessageParser
   {
      
      private var var_4569:int;
      
      private var _totalAmount:int;
      
      private var var_369:int;
      
      private var _amount:int;
      
      private var _forums:Array;
      
      public function ForumsListMessageEventParser()
      {
         super();
      }
      
      public function get listCode() : int
      {
         return var_4569;
      }
      
      public function get totalAmount() : int
      {
         return _totalAmount;
      }
      
      public function get startIndex() : int
      {
         return var_369;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get forums() : Array
      {
         return _forums;
      }
      
      public function flush() : Boolean
      {
         _forums = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_4569 = param1.readInteger();
         _totalAmount = param1.readInteger();
         var_369 = param1.readInteger();
         _amount = param1.readInteger();
         _forums = [];
         var _loc2_:int = 0;
         while(0 < amount)
         {
            _forums.push(class_3590.readFromMessage(param1));
            _loc2_++;
         }
         return true;
      }
   }
}

