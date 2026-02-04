package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionPresentEvent extends RoomSessionEvent
   {
      
      public static const ROOM_SESSION_PRESENT_OPENED:String = "RSPE_PRESENT_OPENED";
      
      private var var_1015:int = 0;
      
      private var var_757:String = "";
      
      private var var_2711:String;
      
      private var var_195:int = 0;
      
      private var var_982:String = "";
      
      private var _placedInRoom:Boolean;
      
      private var _petFigureString:String;
      
      public function RoomSessionPresentEvent(param1:String, param2:IRoomSession, param3:int, param4:String, param5:String, param6:int, param7:String, param8:Boolean, param9:String, param10:Boolean = false, param11:Boolean = false)
      {
         super(param1,param2,param10,param11);
         var_1015 = param3;
         var_757 = param4;
         var_2711 = param5;
         var_195 = param6;
         var_982 = param7;
         _placedInRoom = param8;
         _petFigureString = param9;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get placedItemId() : int
      {
         return var_195;
      }
      
      public function get placedInRoom() : Boolean
      {
         return _placedInRoom;
      }
      
      public function get placedItemType() : String
      {
         return var_982;
      }
      
      public function get petFigureString() : String
      {
         return _petFigureString;
      }
   }
}

