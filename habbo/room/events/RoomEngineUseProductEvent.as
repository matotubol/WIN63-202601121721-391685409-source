package com.sulake.habbo.room.events
{
   public class RoomEngineUseProductEvent extends RoomEngineObjectEvent
   {
      
      public static const USE_PRODUCT_FROM_ROOM:String = "ROSM_USE_PRODUCT_FROM_ROOM";
      
      public static const USE_PRODUCT_FROM_INVENTORY:String = "ROSM_USE_PRODUCT_FROM_INVENTORY";
      
      private var var_4796:int;
      
      private var var_4235:int;
      
      public function RoomEngineUseProductEvent(param1:String, param2:int, param3:int, param4:int, param5:int = -1, param6:int = -1, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param3,param4,param7,param8);
         var_4796 = param5;
         var_4235 = param6;
      }
      
      public function get inventoryStripId() : int
      {
         return var_4796;
      }
      
      public function get furnitureTypeId() : int
      {
         return var_4235;
      }
   }
}

