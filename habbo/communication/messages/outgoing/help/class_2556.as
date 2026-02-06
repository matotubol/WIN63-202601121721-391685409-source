package com.sulake.habbo.communication.messages.outgoing.help
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_2556 implements IMessageComposer
   {
      
      private var var_2851:int;
      
      public function class_2556(param1:int)
      {
         super();
         var_2851 = param1;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2851];
      }
      
      public function dispose() : void
      {
      }
   }
}

