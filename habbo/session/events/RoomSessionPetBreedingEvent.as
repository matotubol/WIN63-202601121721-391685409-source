package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetBreedingEvent extends RoomSessionEvent
   {
      
      public static const PET_BREEDING:String = "RSPFUE_PET_BREEDING";
      
      private var var_61:int;
      
      private var var_4218:int;
      
      private var var_3827:int;
      
      public function RoomSessionPetBreedingEvent(param1:IRoomSession, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING",param1,param5,param6);
         var_61 = param2;
         var_4218 = param3;
         var_3827 = param4;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get ownPetId() : int
      {
         return var_4218;
      }
      
      public function get otherPetId() : int
      {
         return var_3827;
      }
   }
}

