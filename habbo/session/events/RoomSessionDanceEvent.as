package com.sulake.habbo.session.events
{
   import com.sulake.habbo.session.IRoomSession;
   
   public class RoomSessionDanceEvent extends RoomSessionEvent
   {
      
      public static const const_52:String = "RSDE_DANCE";
      
      private var var_1270:int;
      
      private var var_2890:int;
      
      public function RoomSessionDanceEvent(param1:IRoomSession, param2:int, param3:int, param4:Boolean = false, param5:Boolean = false)
      {
         super("RSDE_DANCE",param1,param4,param5);
         var_1270 = param2;
         var_2890 = param3;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get danceStyle() : int
      {
         return var_2890;
      }
   }
}

