package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectHSLColorEnableEvent extends RoomObjectEvent
   {
      
      public static const ROOM_BACKGROUND_COLOR:String = "ROHSLCEE_ROOM_BACKGROUND_COLOR";
      
      private var var_4040:Boolean;
      
      private var var_1941:int;
      
      private var var_2016:int;
      
      private var var_1832:int;
      
      public function RoomObjectHSLColorEnableEvent(param1:String, param2:IRoomObject, param3:Boolean, param4:int, param5:int, param6:int, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param2,param7,param8);
         var_4040 = param3;
         var_1941 = param4;
         var_2016 = param5;
         var_1832 = param6;
      }
      
      public function get enable() : Boolean
      {
         return var_4040;
      }
      
      public function get hue() : int
      {
         return var_1941;
      }
      
      public function get saturation() : int
      {
         return var_2016;
      }
      
      public function get lightness() : int
      {
         return var_1832;
      }
   }
}

