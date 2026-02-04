package com.sulake.habbo.room.events
{
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectPlaySoundIdEvent extends RoomObjectFurnitureActionEvent
   {
      
      public static const PLAY_SOUND:String = "ROPSIE_PLAY_SOUND";
      
      public static const PLAY_SOUND_AT_PITCH:String = "ROPSIE_PLAY_SOUND_AT_PITCH";
      
      private var var_4391:String;
      
      private var var_2000:Number;
      
      public function RoomObjectPlaySoundIdEvent(param1:String, param2:IRoomObject, param3:String, param4:Number = 1, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         var_4391 = param3;
         var_2000 = param4;
      }
      
      public function get soundId() : String
      {
         return var_4391;
      }
      
      public function get pitch() : Number
      {
         return var_2000;
      }
   }
}

