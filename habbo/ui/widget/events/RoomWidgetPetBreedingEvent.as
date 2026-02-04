package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetBreedingEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_1133:int = 0;
      
      public static const const_1154:int = 1;
      
      public static const TYPE_ACCEPT:int = 2;
      
      public static const TYPE_REQUEST:int = 3;
      
      public static const PET_BREEDING:String = "RWPPBE_PET_BREEDING_";
      
      private var var_61:int;
      
      private var var_4218:int;
      
      private var var_3827:int;
      
      public function RoomWidgetPetBreedingEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("RWPPBE_PET_BREEDING_",param1,param2);
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function set state(param1:int) : void
      {
         var_61 = param1;
      }
      
      public function get ownPetId() : int
      {
         return var_4218;
      }
      
      public function set ownPetId(param1:int) : void
      {
         var_4218 = param1;
      }
      
      public function get otherPetId() : int
      {
         return var_3827;
      }
      
      public function set otherPetId(param1:int) : void
      {
         var_3827 = param1;
      }
   }
}

