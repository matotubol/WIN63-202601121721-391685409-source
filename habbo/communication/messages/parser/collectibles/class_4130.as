package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_4130 extends class_2870
   {
      
      private var _amount:int;
      
      public function class_4130(param1:IMessageDataWrapper)
      {
         super(param1);
      }
      
      override public function readAdditionalParams(param1:IMessageDataWrapper) : void
      {
         _amount = param1.readInteger();
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}

