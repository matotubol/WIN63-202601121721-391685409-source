package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetCatalogIndexComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function GetCatalogIndexComposer(param1:String)
      {
         super();
         var_24 = [param1];
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
   }
}

