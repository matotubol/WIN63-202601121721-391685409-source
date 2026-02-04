package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetStickieDataUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const UPDATE_STICKIE_DATA:String = "RWSDUE_STICKIE_DATA";
      
      private var var_315:int = -1;
      
      private var var_2300:String;
      
      private var _text:String;
      
      private var var_628:String;
      
      private var var_55:Boolean;
      
      public function RoomWidgetStickieDataUpdateEvent(param1:String, param2:int, param3:String, param4:String, param5:String, param6:Boolean, param7:Boolean = false, param8:Boolean = false)
      {
         super(param1,param7,param8);
         var_315 = param2;
         var_2300 = param3;
         _text = param4;
         var_628 = param5;
         var_55 = param6;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectType() : String
      {
         return var_2300;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return var_628;
      }
      
      public function get controller() : Boolean
      {
         return var_55;
      }
   }
}

