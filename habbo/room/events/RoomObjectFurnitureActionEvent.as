package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectFurnitureActionEvent extends RoomObjectEvent
   {
      
      public static const const_841:String = "ROFCAE_DICE_OFF";
      
      public static const const_234:String = "ROFCAE_DICE_ACTIVATE";
      
      public static const USE_HABBOWHEEL:String = "ROFCAE_USE_HABBOWHEEL";
      
      public static const STICKIE:String = "ROFCAE_STICKIE";
      
      public static const const_440:String = "ROFCAE_ENTER_ONEWAYDOOR";
      
      public static const SOUND_MACHINE_INIT:String = "ROFCAE_SOUND_MACHINE_INIT";
      
      public static const SOUND_MACHINE_START:String = "ROFCAE_SOUND_MACHINE_START";
      
      public static const SOUND_MACHINE_STOP:String = "ROFCAE_SOUND_MACHINE_STOP";
      
      public static const SOUND_MACHINE_DISPOSE:String = "ROFCAE_SOUND_MACHINE_DISPOSE";
      
      public static const JUKEBOX_INIT:String = "ROFCAE_JUKEBOX_INIT";
      
      public static const const_909:String = "ROFCAE_JUKEBOX_START";
      
      public static const const_197:String = "ROFCAE_JUKEBOX_MACHINE_STOP";
      
      public static const const_65:String = "ROFCAE_JUKEBOX_DISPOSE";
      
      public static const CURSOR_REQUEST_BUTTON:String = "ROFCAE_MOUSE_BUTTON";
      
      public static const CURSOR_REQUEST_ARROW:String = "ROFCAE_MOUSE_ARROW";
      
      public static const NFT_REWARD_BOX:String = "ROFCAE_NFT_REWARD_BOX";
      
      public function RoomObjectFurnitureActionEvent(param1:String, param2:IRoomObject, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
   }
}

