package com.sulake.habbo.communication.messages.outgoing.inventory.furni
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class RequestRoomPropertySet implements IMessageComposer
   {
      
      private var var_4899:int = 0;
      
      public function RequestRoomPropertySet(param1:int)
      {
         super();
         var_4899 = param1;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_4899);
         return _loc1_;
      }
   }
}

