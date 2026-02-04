package com.sulake.habbo.roomevents.events
{
   import flash.events.Event;
   
   public class WiredUserClickHandledEvent extends Event
   {
      
      public static const WIRED_USER_CLICK_HANDLED:String = "WIRED_USER_CLICK_HANDLED";
      
      private var _index:int;
      
      private var var_2817:Boolean;
      
      public function WiredUserClickHandledEvent(param1:String, param2:int, param3:Boolean, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         _index = param2;
         var_2817 = param3;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function get openMenu() : Boolean
      {
         return var_2817;
      }
   }
}

