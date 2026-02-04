package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetClothingChangeUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const SHOW_GENDER_SELECTION:String = "RWCCUE_SHOW_GENDER_SELECTION";
      
      public static const SHOW_CLOTHING_EDITOR:String = "RWCCUE_SHOW_CLOTHING_EDITOR";
      
      private var var_315:int = -1;
      
      private var var_3874:int = -1;
      
      private var var_1951:int = -1;
      
      public function RoomWidgetClothingChangeUpdateEvent(param1:String, param2:int = 0, param3:int = 0, param4:int = 0, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_315 = param2;
         var_3874 = param3;
         var_1951 = param4;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get objectCategory() : int
      {
         return var_3874;
      }
      
      public function get roomId() : int
      {
         return var_1951;
      }
   }
}

