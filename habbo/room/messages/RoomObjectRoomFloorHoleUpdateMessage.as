package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectRoomFloorHoleUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const ADD_HOLE:String = "RORPFHUM_ADD";
      
      public static const REMOVE_HOLE:String = "RORPFHUM_REMOVE";
      
      private var var_230:String = "";
      
      private var var_197:int;
      
      private var var_25:int;
      
      private var var_26:int;
      
      private var _width:int;
      
      private var var_385:int;
      
      private var var_4463:Boolean;
      
      public function RoomObjectRoomFloorHoleUpdateMessage(param1:String, param2:int, param3:int = 0, param4:int = 0, param5:int = 0, param6:int = 0, param7:Boolean = false)
      {
         super(null,null);
         var_230 = param1;
         var_197 = param2;
         var_25 = param3;
         var_26 = param4;
         _width = param5;
         var_385 = param6;
         var_4463 = param7;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function get invert() : Boolean
      {
         return var_4463;
      }
   }
}

