package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseFromCatalogAsGiftComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function PurchaseFromCatalogAsGiftComposer(param1:int, param2:int, param3:String, param4:String, param5:String, param6:int, param7:int, param8:int, param9:Boolean)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
         var_24.push(param5);
         var_24.push(param6);
         var_24.push(param7);
         var_24.push(param8);
         var_24.push(param9);
      }
      
      public function dispose() : void
      {
         var_24 = [];
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

