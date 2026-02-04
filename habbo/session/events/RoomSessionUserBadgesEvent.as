package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionUserBadgesEvent extends RoomSessionEvent
   {
      
      public static const USER_BADGES:String = "RSUBE_BADGES";
      
      private var var_1270:int = 0;
      
      private var var_179:Array = [];
      
      public function RoomSessionUserBadgesEvent(param1:IRoomSession, param2:int, param3:Array, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSUBE_BADGES",param1,param4,param5);
         var_1270 = param2;
         var_179 = param3;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get badges() : Array
      {
         return var_179;
      }
   }
}

