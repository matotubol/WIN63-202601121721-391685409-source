package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetLevelUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_LEVEL_UPDATE:String = "RWPLUE_PET_LEVEL_UPDATE";
      
      private var var_2751:int;
      
      private var var_2493:int;
      
      public function RoomWidgetPetLevelUpdateEvent(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPLUE_PET_LEVEL_UPDATE",param3,param4);
         var_2751 = param1;
         var_2493 = param2;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get level() : int
      {
         return var_2493;
      }
   }
}

