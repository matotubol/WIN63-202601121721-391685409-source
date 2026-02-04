package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetUserLocationUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const USER_LOCATION_UPDATE:String = "RWULUE_USER_LOCATION_UPDATE";
      
      private var var_1270:int;
      
      private var var_2336:Rectangle;
      
      private var var_4137:Point;
      
      public function RoomWidgetUserLocationUpdateEvent(param1:int, param2:Rectangle, param3:Point, param4:Boolean = false, param5:Boolean = false)
      {
         super("RWULUE_USER_LOCATION_UPDATE",param4,param5);
         var_1270 = param1;
         var_2336 = param2;
         var_4137 = param3;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get rectangle() : Rectangle
      {
         return var_2336;
      }
      
      public function get screenLocation() : Point
      {
         return var_4137;
      }
   }
}

