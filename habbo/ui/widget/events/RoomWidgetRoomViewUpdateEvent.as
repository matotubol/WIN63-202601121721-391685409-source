package com.sulake.habbo.ui.widget.events
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomWidgetRoomViewUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const ROOM_VIEW_SIZE_CHANGED:String = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
      
      public static const ROOM_VIEW_SCALE_CHANGED:String = "RWRVUE_ROOM_VIEW_SCALE_CHANGED";
      
      public static const ROOM_VIEW_POSITION_CHANGED:String = "RWRVUE_ROOM_VIEW_POSITION_CHANGED";
      
      private var var_3445:Rectangle;
      
      private var var_3597:Point;
      
      private var var_337:Number = 0;
      
      public function RoomWidgetRoomViewUpdateEvent(param1:String, param2:Rectangle = null, param3:Point = null, param4:Number = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_3445 = param2;
         var_3597 = param3;
         var_337 = param4;
      }
      
      public function get rect() : Rectangle
      {
         if(var_3445 != null)
         {
            return var_3445.clone();
         }
         return null;
      }
      
      public function get positionDelta() : Point
      {
         if(var_3597 != null)
         {
            return var_3597.clone();
         }
         return null;
      }
      
      public function get scale() : Number
      {
         return var_337;
      }
   }
}

