package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetSelectEffectMessage extends RoomWidgetMessage
   {
      
      public static const const_862:String = "RWCM_MESSAGE_SELECT_EFFECT";
      
      public static const const_807:String = "RWCM_MESSAGE_UNSELECT_EFFECT";
      
      public static const const_578:String = "RWCM_MESSAGE_UNSELECT_ALL_EFFECTS";
      
      private var var_1137:int;
      
      public function RoomWidgetSelectEffectMessage(param1:String, param2:int = -1)
      {
         super(param1);
         var_1137 = param2;
      }
      
      public function get effectType() : int
      {
         return var_1137;
      }
   }
}

