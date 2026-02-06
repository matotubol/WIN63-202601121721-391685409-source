package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class ExtendRentOrBuyoutFurniMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function ExtendRentOrBuyoutFurniMessageComposer(param1:Boolean, param2:int, param3:Boolean)
      {
         super();
         var_24 = [param1,param2,param3];
      }
      
      public function getMessageArray() : Array
      {
         return var_24;
      }
      
      public function dispose() : void
      {
         var_24 = null;
      }
   }
}

