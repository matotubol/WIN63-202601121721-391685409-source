package com.sulake.habbo.communication.messages.outgoing.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class OpenTradingComposer implements IMessageComposer
   {
      
      private var var_4696:int;
      
      public function OpenTradingComposer(param1:int)
      {
         super();
         var_4696 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_4696];
      }
   }
}

