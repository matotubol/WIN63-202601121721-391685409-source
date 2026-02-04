package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetPetCommandsUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const PET_COMMANDS:String = "RWPCUE_PET_COMMANDS";
      
      public static const OPEN_PET_TRAINING:String = "RWPCUE_OPEN_PET_TRAINING";
      
      public static const CLOSE_PET_TRAINING:String = "RWPCUE_CLOSE_PET_TRAINING";
      
      private var var_197:int;
      
      private var var_2517:Array;
      
      private var var_2317:Array;
      
      public function RoomWidgetPetCommandsUpdateEvent(param1:int, param2:Array, param3:Array, param4:Boolean = false, param5:Boolean = false)
      {
         super("RWPCUE_PET_COMMANDS",param4,param5);
         var_197 = param1;
         var_2517 = param2;
         var_2317 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get allCommands() : Array
      {
         return var_2517;
      }
      
      public function get enabledCommands() : Array
      {
         return var_2317;
      }
   }
}

