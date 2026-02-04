package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectRoomPlaneVisibilityUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const const_255:String = "RORPVUM_WALL_VISIBILITY";
      
      public static const const_820:String = "RORPVUM_FLOOR_VISIBILITY";
      
      private var var_230:String = "";
      
      private var var_588:Boolean = false;
      
      public function RoomObjectRoomPlaneVisibilityUpdateMessage(param1:String, param2:Boolean)
      {
         super(null,null);
         var_230 = param1;
         var_588 = param2;
      }
      
      public function get type() : String
      {
         return var_230;
      }
      
      public function get visible() : Boolean
      {
         return var_588;
      }
   }
}

