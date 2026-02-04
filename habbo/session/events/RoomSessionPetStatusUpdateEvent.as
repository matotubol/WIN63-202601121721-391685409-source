package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetStatusUpdateEvent extends RoomSessionEvent
   {
      
      public static const PET_STATUS_UPDATE:String = "RSPFUE_PET_STATUS_UPDATE";
      
      private var var_2751:int;
      
      private var var_3982:Boolean;
      
      private var var_4043:Boolean;
      
      private var var_3818:Boolean;
      
      private var var_4233:Boolean;
      
      public function RoomSessionPetStatusUpdateEvent(param1:IRoomSession, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_PET_STATUS_UPDATE",param1,param7,param8);
         var_2751 = param2;
         var_3982 = param3;
         var_4043 = param4;
         var_3818 = param5;
         var_4233 = param6;
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

