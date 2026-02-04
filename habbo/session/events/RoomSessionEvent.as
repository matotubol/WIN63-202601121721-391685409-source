package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   import flash.events.Event;
   
   public class RoomSessionEvent extends Event
   {
      
      public static const const_420:String = "RSE_CREATED";
      
      public static const const_496:String = "RSE_STARTED";
      
      public static const const_314:String = "RSE_ENDED";
      
      public static const SESSION_ROOM_DATA:String = "RSE_ROOM_DATA";
      
      private var var_70:IRoomSession;
      
      private var var_4396:Boolean;
      
      public function RoomSessionEvent(param1:String, param2:IRoomSession, param3:Boolean = true, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         var_70 = param2;
         var_4396 = param3;
      }
      
      public function get session() : IRoomSession
      {
         return var_70;
      }
      
      public function get openLandingPage() : Boolean
      {
         return var_4396;
      }
   }
}

