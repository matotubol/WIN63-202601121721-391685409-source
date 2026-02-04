package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetDimmerStateUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_58:String = "RWDSUE_DIMMER_STATE";
      
      private var var_61:int;
      
      private var var_3997:int;
      
      private var var_2200:int;
      
      private var _color:uint;
      
      private var var_2670:int;
      
      private var var_315:int;
      
      public function RoomWidgetDimmerStateUpdateEvent(param1:int, param2:int, param3:int, param4:int, param5:uint, param6:uint, param7:Boolean = false, param8:Boolean = false)
      {
         super("RWDSUE_DIMMER_STATE",param7,param8);
         var_315 = param1;
         var_61 = param2;
         var_3997 = param3;
         var_2200 = param4;
         _color = param5;
         var_2670 = param6;
      }
      
      public function get state() : int
      {
         return var_61;
      }
      
      public function get presetId() : int
      {
         return var_3997;
      }
      
      public function get effectId() : int
      {
         return var_2200;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get brightness() : uint
      {
         return var_2670;
      }
      
      public function get objectId() : uint
      {
         return var_315;
      }
   }
}

