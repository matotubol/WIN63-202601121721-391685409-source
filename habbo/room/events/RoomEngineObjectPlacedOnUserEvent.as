package com.sulake.habbo.room.events
{
   public class RoomEngineObjectPlacedOnUserEvent extends RoomEngineObjectEvent
   {
      
      private var var_5012:int;
      
      private var var_4337:int;
      
      public function RoomEngineObjectPlacedOnUserEvent(param1:String, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param3,param4,param7,param8);
         var_5012 = droppedObjectId;
         var_4337 = param6;
      }
      
      public function get droppedObjectId() : int
      {
         return var_5012;
      }
      
      public function get droppedObjectCategory() : int
      {
         return var_4337;
      }
   }
}

