package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import package_37.class_3688;
   
   public class RoomSessionPetBreedingResultEvent extends RoomSessionEvent
   {
      
      public static const PET_BREEDING_RESULT:String = "RSPFUE_PET_BREEDING_RESULT";
      
      private var var_357:class_3688;
      
      private var var_3914:class_3688;
      
      public function RoomSessionPetBreedingResultEvent(param1:IRoomSession, param2:class_3688, param3:class_3688, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPFUE_PET_BREEDING_RESULT",param1,param4,param5);
         var_357 = param2;
         var_3914 = param3;
      }
      
      public function get resultData() : class_3688
      {
         return var_357;
      }
      
      public function get otherResultData() : class_3688
      {
         return var_3914;
      }
   }
}

