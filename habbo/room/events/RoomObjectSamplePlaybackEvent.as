package com.sulake.habbo.room.events
{
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectSamplePlaybackEvent extends RoomObjectFurnitureActionEvent
   {
      
      public static const ROOM_OBJECT_INITIALIZED:String = "ROPSPE_ROOM_OBJECT_INITIALIZED";
      
      public static const ROOM_OBJECT_DISPOSED:String = "ROPSPE_ROOM_OBJECT_DISPOSED";
      
      public static const PLAY_SAMPLE:String = "ROPSPE_PLAY_SAMPLE";
      
      public static const CHANGE_PITCH:String = "ROPSPE_CHANGE_PITCH";
      
      private var var_2677:int;
      
      private var var_2000:Number;
      
      public function RoomObjectSamplePlaybackEvent(param1:String, param2:IRoomObject, param3:int, param4:Number = 1, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param2,param5,param6);
         var_2677 = param3;
         var_2000 = param4;
      }
      
      public function get sampleId() : int
      {
         return var_2677;
      }
      
      public function get pitch() : Number
      {
         return var_2000;
      }
   }
}

