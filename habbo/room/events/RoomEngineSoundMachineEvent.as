package com.sulake.habbo.room.events
{
   public class RoomEngineSoundMachineEvent extends RoomEngineObjectEvent
   {
      
      public static const SOUND_MACHINE_INIT:String = "ROSM_SOUND_MACHINE_INIT";
      
      public static const SOUND_MACHINE_SWITCHED_ON:String = "ROSM_SOUND_MACHINE_SWITCHED_ON";
      
      public static const SOUND_MACHINE_SWITCHED_OFF:String = "ROSM_SOUND_MACHINE_SWITCHED_OFF";
      
      public static const SOUND_MACHINE_DISPOSE:String = "ROSM_SOUND_MACHINE_DISPOSE";
      
      public static const JUKEBOX_INIT:String = "ROSM_JUKEBOX_INIT";
      
      public static const const_1136:String = "ROSM_JUKEBOX_SWITCHED_ON";
      
      public static const const_632:String = "ROSM_JUKEBOX_SWITCHED_OFF";
      
      public static const const_65:String = "ROSM_JUKEBOX_DISPOSE";
      
      public function RoomEngineSoundMachineEvent(param1:String, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
   }
}

