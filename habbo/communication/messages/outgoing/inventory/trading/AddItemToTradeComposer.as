package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class AddItemToTradeComposer implements IMessageComposer
   {
      
      private var var_4773:int;
      
      public function AddItemToTradeComposer(param1:int)
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

