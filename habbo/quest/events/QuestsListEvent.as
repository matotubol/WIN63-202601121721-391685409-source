package com.sulake.habbo.quest.events
{
   import flash.events.Event;
   
   public class QuestsListEvent extends Event
   {
      
      public static const QUESTS_SEASONAL:String = "qe_quests_seasonal";
      
      public static const QUESTS:String = "qu_quests";
      
      private var var_1446:Array;
      
      private var var_4145:Boolean;
      
      public function QuestsListEvent(param1:String, param2:Array, param3:Boolean, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         var_1446 = param2;
      }
      
      public function get quests() : Array
      {
         return var_1446;
      }
      
      public function get openWindow() : Boolean
      {
         return var_4145;
      }
   }
}

