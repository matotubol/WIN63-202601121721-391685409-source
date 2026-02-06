package com.sulake.habbo.communication.messages.parser.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PostItPlacedEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var var_4733:int;
      
      public function PostItPlacedEventParser()
      {
         super();
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_197 = param1.readInteger();
         var_4733 = param1.readInteger();
         return true;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get itemsLeft() : int
      {
         return var_4733;
      }
   }
}

