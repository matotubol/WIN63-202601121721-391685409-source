package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetLevelUpdateEvent extends RoomSessionEvent
   {
      
      public static const PET_LEVEL_UPDATE:String = "RSPLUE_PET_LEVEL_UPDATE";
      
      private var var_2751:int;
      
      private var var_2493:int;
      
      public function RoomSessionPetLevelUpdateEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSPLUE_PET_LEVEL_UPDATE",param1,param4,param5);
         var_2751 = param2;
         var_2493 = param3;
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

