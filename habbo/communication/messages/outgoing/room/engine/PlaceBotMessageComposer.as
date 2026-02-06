package com.sulake.habbo.communication.messages.outgoing.room.engine
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class PlaceBotMessageComposer implements IMessageComposer
   {
      
      private var var_1504:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      public function PlaceBotMessageComposer(param1:int, param2:int, param3:int)
      {
         super();
         var_1504 = param1;
         var_25 = param2;
         var_26 = param3;
      }
      
      public function dispose() : void
      {
      }
      
      public function getMessageArray() : Array
      {
         return [var_1504,var_25,var_26];
      }
   }
}

