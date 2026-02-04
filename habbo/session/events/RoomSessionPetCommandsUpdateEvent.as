package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPetCommandsUpdateEvent extends RoomSessionEvent
   {
      
      public static const PET_COMMANDS:String = "RSPIUE_ENABLED_PET_COMMANDS";
      
      private var var_2751:int;
      
      private var var_4783:Array;
      
      private var var_4649:Array;
      
      public function RoomSessionPetCommandsUpdateEvent(param1:IRoomSession, param2:int, param3:Array, param4:Array, param5:Boolean = false, param6:Boolean = false)
      {
         super("RSPIUE_ENABLED_PET_COMMANDS",param1,param5,param6);
         var_2751 = param2;
         var_4783 = param3;
         var_4649 = param4;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
      
      public function get allCommands() : Array
      {
         return var_4783;
      }
      
      public function get enabledCommands() : Array
      {
         return var_4649;
      }
   }
}

