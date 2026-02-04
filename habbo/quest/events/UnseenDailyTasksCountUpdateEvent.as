package com.sulake.habbo.quest.events
{
   import flash.events.Event;
   
   public class UnseenDailyTasksCountUpdateEvent extends Event
   {
      
      public static const TYPE:String = "qe_udtcue";
      
      private var _count:int;
      
      public function UnseenDailyTasksCountUpdateEvent(param1:int, param2:Boolean = false, param3:Boolean = false)
      {
         super("qe_udtcue",param2,param3);
         _count = param1;
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}

