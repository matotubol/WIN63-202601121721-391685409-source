package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   
   public class RoomObjectVisibilityUpdateMessage extends RoomObjectUpdateMessage
   {
      
      public static const const_77:String = "ROVUM_ENABLED";
      
      public static const const_339:String = "ROVUM_DISABLED";
      
      private var var_230:String;
      
      public function RoomObjectVisibilityUpdateMessage(param1:String)
      {
         super(null,null);
         var_230 = param1;
      }
      
      public function get type() : String
      {
         return var_230;
      }
   }
}

