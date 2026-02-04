package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionConfirmPetBreedingResultEvent extends RoomSessionEvent
   {
      
      public static const CONFIRM_PET_BREEDING_RESULT:String = "RSPFUE_CONFIRM_PET_BREEDING_RESULT";
      
      private var var_2712:int;
      
      private var var_1122:int;
      
      public function RoomSessionConfirmPetBreedingResultEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING_RESULT",param1,param4,param5);
         var_2712 = param2;
         var_1122 = param3;
      }
      
      public function get breedingNestStuffId() : int
      {
         return var_2712;
      }
      
      public function get result() : int
      {
         return var_1122;
      }
   }
}

