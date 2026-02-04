package com.sulake.habbo.ui.widget.events
{
   public class RoomWidgetCreditFurniUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const UPDATE_CREDIT_FURNI:String = "RWCFUE_CREDIT_FURNI_UPDATE";
      
      private var var_315:int;
      
      private var var_4194:Number;
      
      private var var_2846:Boolean;
      
      public function RoomWidgetCreditFurniUpdateEvent(param1:String, param2:int, param3:Number, param4:Boolean, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         var_4194 = param3;
         var_315 = param2;
         var_2846 = param4;
      }
      
      public function get creditValue() : Number
      {
         return var_4194;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get isNftCredit() : Boolean
      {
         return var_2846;
      }
   }
}

