package com.sulake.habbo.room.events
{
   public class RoomEngineDimmerStateEvent extends RoomEngineEvent
   {
      
      public static const const_58:String = "REDSE_ROOM_COLOR";
      
      private var var_61:int;
      
      private var var_3997:int;
      
      private var var_2200:int;
      
      private var _color:uint;
      
      private var var_2670:int;
      
      private var var_315:int;
      
      public function RoomEngineDimmerStateEvent(param1:int, param2:int, param3:int, param4:int, param5:int, param6:uint, param7:uint, param8:Boolean = false, param9:Boolean = false)
      {
         super("REDSE_ROOM_COLOR",param1,param8,param9);
         var_315 = param2;
         var_61 = param3;
         var_3997 = param4;
         var_2200 = param5;
         _color = param6;
         var_2670 = param7;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get presetId() : int
      {
         return var_3997;
      }
      
      public function get effectId() : int
      {
         return var_2200;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return var_2670;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
   }
}

