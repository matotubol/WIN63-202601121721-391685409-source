package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetHabboClubUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_81:String = "RWBIUE_HABBO_CLUB";
      
      private var var_4752:int = 0;
      
      private var var_5136:int = 0;
      
      private var var_3948:int = 0;
      
      private var var_4275:Boolean = false;
      
      private var var_2971:int;
      
      public function RoomWidgetHabboClubUpdateEvent(param1:int, param2:int, param3:int, param4:Boolean, param5:int, param6:Boolean = false, param7:Boolean = false)
      {
         super("RWBIUE_HABBO_CLUB",param6,param7);
         var_4752 = param1;
         var_5136 = param2;
         var_3948 = param3;
         var_4275 = param4;
         var_2971 = param5;
      }
      
      public function get daysLeft() : int
      {
         return var_4752;
      }
      
      public function get periodsLeft() : int
      {
         return var_5136;
      }
      
      public function get pastPeriods() : int
      {
         return var_3948;
      }
      
      public function get allowClubDances() : Boolean
      {
         return var_4275;
      }
      
      public function get clubLevel() : int
      {
         return var_2971;
      }
   }
}

