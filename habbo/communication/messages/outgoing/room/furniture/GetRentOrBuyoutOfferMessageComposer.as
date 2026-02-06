package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class GetRentOrBuyoutOfferMessageComposer implements IMessageComposer
   {
      
      private var var_24:Array;
      
      public function GetRentOrBuyoutOfferMessageComposer(param1:Boolean, param2:String, param3:Boolean)
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

