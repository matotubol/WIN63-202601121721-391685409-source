package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetConfirmPetBreedingEvent extends RoomWidgetUpdateEvent
   {
      
      public static const CONFIRM_PET_BREEDING:String = "RWPPBE_CONFIRM_PET_BREEDING_";
      
      private var var_2736:int;
      
      private var _pet1:ConfirmPetBreedingPetData;
      
      private var _pet2:ConfirmPetBreedingPetData;
      
      private var var_3299:Array;
      
      private var var_4572:int;
      
      public function RoomWidgetConfirmPetBreedingEvent(param1:int, param2:ConfirmPetBreedingPetData, param3:ConfirmPetBreedingPetData, param4:Array, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWPPBE_CONFIRM_PET_BREEDING_",param6,param7);
         var_2736 = param1;
         _pet1 = param2;
         _pet2 = param3;
         var_3299 = param4;
         var_4572 = param5;
      }
      
      public function get rarityCategories() : Array
      {
         return var_3299;
      }
      
      public function get nestId() : int
      {
         return var_2736;
      }
      
      public function get pet1() : ConfirmPetBreedingPetData
      {
         return _pet1;
      }
      
      public function get pet2() : ConfirmPetBreedingPetData
      {
         return _pet2;
      }
      
      public function get resultPetTypeId() : int
      {
         return var_4572;
      }
   }
}

