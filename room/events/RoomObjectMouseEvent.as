package com.sulake.room.events
{
   import com.sulake.room.object.IRoomObject;
   
   public class RoomObjectMouseEvent extends RoomObjectEvent
   {
      
      public static const ROOM_OBJECT_MOUSE_CLICK:String = "ROE_MOUSE_CLICK";
      
      public static const ROOM_OBJECT_MOUSE_ENTER:String = "ROE_MOUSE_ENTER";
      
      public static const ROOM_OBJECT_MOUSE_MOVE:String = "ROE_MOUSE_MOVE";
      
      public static const ROOM_OBJECT_MOUSE_LEAVE:String = "ROE_MOUSE_LEAVE";
      
      public static const ROOM_OBJECT_MOUSE_DOUBLE_CLICK:String = "ROE_MOUSE_DOUBLE_CLICK";
      
      public static const ROOM_OBJECT_MOUSE_DOWN:String = "ROE_MOUSE_DOWN";
      
      private var var_3500:String = "";
      
      private var _altKey:Boolean;
      
      private var _ctrlKey:Boolean;
      
      private var _shiftKey:Boolean;
      
      private var var_3995:Boolean;
      
      private var var_4280:int;
      
      private var var_3917:int;
      
      private var var_4795:int;
      
      private var var_4666:int;
      
      public function RoomObjectMouseEvent(param1:String, param2:IRoomObject, param3:String, param4:Boolean = false, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false)
      {
         super(param1,param2,param8,param9);
         var_3500 = param3;
         _altKey = param4;
         _ctrlKey = param5;
         _shiftKey = param6;
         var_3995 = param7;
      }
      
      public function get eventId() : String
      {
         return var_3500;
      }
      
      public function get altKey() : Boolean
      {
         return _altKey;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _ctrlKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _shiftKey;
      }
      
      public function get buttonDown() : Boolean
      {
         return var_3995;
      }
      
      public function get localX() : int
      {
         return var_4280;
      }
      
      public function get localY() : int
      {
         return var_3917;
      }
      
      public function get spriteOffsetX() : int
      {
         return var_4795;
      }
      
      public function get spriteOffsetY() : int
      {
         return var_4666;
      }
      
      public function set localX(param1:int) : void
      {
         var_4280 = param1;
      }
      
      public function set localY(param1:int) : void
      {
         var_3917 = param1;
      }
      
      public function set spriteOffsetX(param1:int) : void
      {
         var_4795 = param1;
      }
      
      public function set spriteOffsetY(param1:int) : void
      {
         var_4666 = param1;
      }
   }
}

