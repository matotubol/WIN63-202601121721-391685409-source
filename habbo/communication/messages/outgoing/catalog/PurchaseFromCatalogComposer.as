package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseFromCatalogComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function PurchaseFromCatalogComposer(param1:int, param2:int, param3:String, param4:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
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

