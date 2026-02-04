package com.sulake.core.runtime.events
{
   import flash.events.Event;
   
   public class HotelViewEvent extends Event
   {
      
      public static const HOTEL_VIEW_READY:String = "HOTEL_VIEW_READY";
      
      public function HotelViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

