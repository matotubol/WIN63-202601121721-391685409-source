package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.communication.messages.incoming.room.pets.class_3828;
   
   public class RoomSessionConfirmPetBreedingEvent extends RoomSessionEvent
   {
      
      public static const CONFIRM_PET_BREEDING:String = "RSPFUE_CONFIRM_PET_BREEDING";
      
      private var var_2736:int;
      
      private var _pet1:class_3828;
      
      private var _pet2:class_3828;
      
      private var var_3299:Array;
      
      private var var_4572:int;
      
      public function RoomSessionConfirmPetBreedingEvent(param1:IRoomSession, param2:int, param3:class_3828, param4:class_3828, param5:Array, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super("RSPFUE_CONFIRM_PET_BREEDING",param1,param7,param8);
         var_2736 = param2;
         _pet1 = param3;
         _pet2 = param4;
         var_3299 = param5;
         var_4572 = param6;
      }
      
      public function get rarityCategories() : Array
      {
         return var_3299;
      }
      
      public function get nestId() : int
      {
         return var_2736;
      }
      
      public function get pet1() : class_3828
      {
         return _pet1;
      }
      
      public function get pet2() : class_3828
      {
         return _pet2;
      }
      
      public function get resultPetTypeId() : int
      {
         return var_4572;
      }
   }
}

