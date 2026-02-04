package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetUseProductMessage extends RoomWidgetMessage
   {
      
      public static const PET_PRODUCT:String = "RWUPM_PET_PRODUCT";
      
      public static const MONSTERPLANT_SEED:String = "RWUPM_MONSTERPLANT_SEED";
      
      private var var_3910:int = 0;
      
      private var var_2751:int = -1;
      
      public function RoomWidgetUseProductMessage(param1:String, param2:int, param3:int = -1)
      {
         super(param1);
         var_3910 = param2;
         var_2751 = param3;
      }
      
      public function get roomObjectId() : int
      {
         return var_3910;
      }
      
      public function get petId() : int
      {
         return var_2751;
      }
   }
}

