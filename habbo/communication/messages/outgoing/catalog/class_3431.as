package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_3431 implements IMessageComposer
   {
      
      private var var_4429:int;
      
      public function class_3431(param1:int)
      {
         super();
         var_4429 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_4429];
      }
      
      public function dispose() : void
      {
      }
   }
}

