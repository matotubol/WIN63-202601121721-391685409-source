package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlacePetMessageComposer implements IMessageComposer
   {
      
      private var var_2751:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      public function PlacePetMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_2751 = param1;
         var_25 = param2;
         var_26 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_2751,var_25,var_26];
      }
   }
}

