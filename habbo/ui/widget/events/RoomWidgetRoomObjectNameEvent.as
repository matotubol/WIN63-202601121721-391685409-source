package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomObjectNameEvent extends RoomWidgetUpdateEvent
   {
      
      public static const OBJECT_NAME:String = "RWONE_TYPE";
      
      private var var_1270:int;
      
      private var var_191:int;
      
      private var _userName:String;
      
      private var var_3359:int;
      
      private var var_3915:int;
      
      public function RoomWidgetRoomObjectNameEvent(param1:int, param2:int, param3:String, param4:int, param5:int)
      {
         var_1270 = param1;
         var_191 = param2;
         _userName = param3;
         var_3359 = param4;
         var_3915 = param5;
         super("RWONE_TYPE",false,false);
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get userName() : String
      {
         return _userName;
      }
      
      public function get userType() : int
      {
         return var_3359;
      }
      
      public function get roomIndex() : int
      {
         return var_3915;
      }
   }
}

