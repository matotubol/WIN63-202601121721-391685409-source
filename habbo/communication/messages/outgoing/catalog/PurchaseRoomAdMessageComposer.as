package com.sulake.habbo.communication.messages.outgoing.catalog
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PurchaseRoomAdMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array = [];
      
      public function PurchaseRoomAdMessageComposer(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:String, param7:int)
      {
         super();
         var_24.push(param1);
         var_24.push(param2);
         var_24.push(param3);
         var_24.push(param4);
         var_24.push(param5);
         var_24.push(param6);
         var_24.push(param7);
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
      }
   }
}

