package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class class_2298 implements IMessageComposer
   {
      
      private var var_120:Array = [];
      
      public function class_2298(param1:Boolean)
      {
         super();
         var_120.push(param1);
      }
      
      public function dispose() : void
      {
         var_120 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_120;
      }
   }
}

