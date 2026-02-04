package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetRoomQueueUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const VISITOR_QUEUE_STATUS:String = "RWRQUE_VISITOR_QUEUE_STATUS";
      
      public static const SPECTATOR_QUEUE_STATUS:String = "RWRQUE_SPECTATOR_QUEUE_STATUS";
      
      private var var_2134:int;
      
      private var var_5067:Boolean;
      
      private var var_1037:Boolean;
      
      private var var_3534:Boolean;
      
      public function RoomWidgetRoomQueueUpdateEvent(param1:String, param2:int, param3:Boolean, param4:Boolean, param5:Boolean, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         var_2134 = param2;
         var_5067 = param3;
         var_1037 = param4;
         var_3534 = param5;
      }
      
      public function get position() : int
      {
         return var_2134;
      }
      
      public function get hasHabboClub() : Boolean
      {
         return var_5067;
      }
      
      public function get isActive() : Boolean
      {
         return var_1037;
      }
      
      public function get isClubQueue() : Boolean
      {
         return var_3534;
      }
   }
}

