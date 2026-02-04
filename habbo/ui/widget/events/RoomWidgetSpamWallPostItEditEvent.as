package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetSpamWallPostItEditEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_530:String = "RWSWPUE_OPEN_EDITOR";
      
      private var var_315:int;
      
      private var var_559:String;
      
      private var var_2300:String;
      
      public function RoomWidgetSpamWallPostItEditEvent(param1:String, param2:int, param3:String, param4:String, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_315 = param2;
         var_559 = param3;
         var_2300 = param4;
      }
      
      public function get location() : String
      {
         return var_559;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectType() : String
      {
         return var_2300;
      }
   }
}

