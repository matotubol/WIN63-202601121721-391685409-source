package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlacePostItMessageComposer implements IMessageComposer
   {
      
      private var var_2529:int;
      
      private var var_559:String;
      
      public function PlacePostItMessageComposer(param1:int, param2:String)
      {
         super();
         var_2529 = param1;
         var_559 = param2;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2529,var_559];
      }
   }
}

