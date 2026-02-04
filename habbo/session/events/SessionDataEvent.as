package com.sulake.habbo.session.events
{
   import flash.events.Event;
   
   public class SessionDataEvent extends Event
   {
      
      public function SessionDataEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

