package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetConfirmPetBreedingResultEvent extends RoomWidgetUpdateEvent
   {
      
      public static const CONFIRM_PET_BREEDING_RESULT:String = "RWPPBE_CONFIRM_PET_BREEDING_RESULT";
      
      public static const SUCCESS:int = 0;
      
      public static const NO_NEST_FOUND:int = 1;
      
      public static const PETS_MISSING:int = 2;
      
      public static const INVALID_NAME:int = 3;
      
      private var var_2712:int;
      
      private var var_1122:int;
      
      public function RoomWidgetConfirmPetBreedingResultEvent(param1:int, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super("RWPPBE_CONFIRM_PET_BREEDING_RESULT",param3,param4);
         var_2712 = param1;
         var_1122 = param2;
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

