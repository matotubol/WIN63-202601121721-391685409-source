package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetStatusUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_STATUS_UPDATE:String = "RWPIUE_PET_STATUS_UPDATE";
      
      private var var_2751:int;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4233:Boolean;
      
      public function RoomWidgetPetStatusUpdateEvent(param1:int, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWPIUE_PET_STATUS_UPDATE",param6,param7);
         var_2751 = param1;
         var_3982 = param2;
         var_4043 = param3;
         var_3818 = param4;
         var_4233 = param5;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get canBreed() : Boolean
      {
         return var_3982;
      }
      
      public function get canHarvest() : Boolean
      {
         return var_4043;
      }
      
      public function get canRevive() : Boolean
      {
         return var_3818;
      }
      
      public function get hasBreedingPermission() : Boolean
      {
         return var_4233;
      }
   }
}

