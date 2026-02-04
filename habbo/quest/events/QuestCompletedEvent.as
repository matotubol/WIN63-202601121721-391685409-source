package com.sulake.habbo.quest.events
{
   import flash.events.Event;
   import package_62.class_2098;
   
   public class QuestCompletedEvent extends Event
   {
      
      public static const QUEST_SEASONAL:String = "qce_seasonal";
      
      private var var_3213:class_2098;
      
      public function QuestCompletedEvent(param1:String, param2:class_2098, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_3213 = param2;
      }
      
      public function get questData() : class_2098
      {
         return var_3213;
      }
   }
}

