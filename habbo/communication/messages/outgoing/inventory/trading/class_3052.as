package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_3052 implements IMessageComposer
   {
      
      private var var_4773:int;
      
      public function class_3052(param1:int)
      {
         super();
         var_4773 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4773];
      }
   }
}

