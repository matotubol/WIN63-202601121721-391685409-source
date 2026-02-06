package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetCatalogPageComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function GetCatalogPageComposer(param1:int, param2:int, param3:String)
      {
         super();
         var_24 = [param1,param2,param3];
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

