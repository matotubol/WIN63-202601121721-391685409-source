package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   [SecureSWF(rename="true")]
   public class SetRoomBackgroundColorDataComposer implements IMessageComposer
   {
      
      private var var_2536:int;
      
      private var var_1941:int;
      
      private var var_2016:int;
      
      private var var_1832:int;
      
      public function SetRoomBackgroundColorDataComposer(param1:int, param2:int, param3:int, param4:int)
      {
         super();
         var_2536 = param1;
         var_1941 = param2;
         var_2016 = param3;
         var_1832 = param4;
      }
      
      public function getMessageArray() : Array
      {
         return [var_2536,var_1941,var_2016,var_1832];
      }
      
      public function dispose() : void
      {
      }
   }
}

