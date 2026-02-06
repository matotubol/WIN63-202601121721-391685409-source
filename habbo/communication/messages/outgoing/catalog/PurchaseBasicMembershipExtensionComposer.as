package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseBasicMembershipExtensionComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function PurchaseBasicMembershipExtensionComposer(param1:int)
      {
         super();
         var_24.push(param1);
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

