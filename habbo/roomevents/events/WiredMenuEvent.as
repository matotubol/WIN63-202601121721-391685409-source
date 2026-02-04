package com.sulake.habbo.roomevents.events
{
   import flash.events.Event;
   
   public class WiredMenuEvent extends Event
   {
      
      public static const WIRED_MENU_BUTTON_PREFERENCE_CHANGED:String = "WIRED_MENU_BUTTON_PREFERENCE_CHANGED";
      
      public function WiredMenuEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

