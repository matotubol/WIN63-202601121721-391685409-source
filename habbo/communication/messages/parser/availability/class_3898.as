package com.sulake.habbo.communication.messages.parser.availability
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class class_3898 implements IMessageParser
   {
      
      private var _isOpen:Boolean;
      
      private var var_2957:int;
      
      public function class_3898()
      {
         super();
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get minutesUntilChange() : int
      {
         return var_2957;
      }
      
      public function flush() : Boolean
      {
         _isOpen = false;
         var_2957 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         _isOpen = param1.readInteger() > 0;
         var_2957 = param1.readInteger();
         return true;
      }
   }
}

