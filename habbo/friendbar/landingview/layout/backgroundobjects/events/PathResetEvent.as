package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events
{
   import flash.events.Event;
   
   public class PathResetEvent extends Event
   {
      
      public static const MOVING_OBJECT_PATH_RESET:String = "LWMOPRE_MOVING_OBJECT_PATH_RESET";
      
      private var var_315:int;
      
      public function PathResetEvent(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         var_315 = param2;
         super("LWMOPRE_MOVING_OBJECT_PATH_RESET",param3,param4);
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
   }
}

