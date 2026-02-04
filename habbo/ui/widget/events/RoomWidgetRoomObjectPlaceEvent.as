package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectPlaceEvent extends RoomWidgetRoomObjectUpdateEvent
   {
      
      public static const const_781:String = "RWROUE_OBJECT_PLACED";
      
      private var var_3429:String = "";
      
      private var var_25:Number = 0;
      
      private var var_26:Number = 0;
      
      private var var_176:Number = 0;
      
      private var var_81:int = 0;
      
      private var _placedInRoom:Boolean = false;
      
      private var _placedOnFloor:Boolean = false;
      
      private var _placedOnWall:Boolean = false;
      
      private var var_4264:String = null;
      
      private var var_4096:String = null;
      
      public function RoomWidgetRoomObjectPlaceEvent(param1:String, param2:int, param3:int, param4:int, param5:String, param6:Number, param7:Number, param8:Number, param9:int, param10:Boolean, param11:Boolean, param12:Boolean, param13:String, param14:String, param15:Boolean = false, param16:Boolean = false)
      {
         super(param1,param2,param3,param4,param15,param16);
         var_3429 = param5;
         var_25 = param6;
         var_26 = param7;
         var_176 = param8;
         var_81 = param9;
         _placedInRoom = param10;
         _placedOnFloor = param11;
         _placedOnWall = param12;
         var_4264 = param13;
         var_4096 = param14;
      }
      
      public function get wallLocation() : String
      {
         return var_3429;
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function get z() : Number
      {
         return var_176;
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get placedOnFloor() : Boolean
      {
         return _placedOnFloor;
      }
      
      public function get placedOnWall() : Boolean
      {
         return _placedOnWall;
      }
      
      public function get instanceData() : String
      {
         return var_4264;
      }
      
      public function get placementSource() : String
      {
         return var_4096;
      }
   }
}

