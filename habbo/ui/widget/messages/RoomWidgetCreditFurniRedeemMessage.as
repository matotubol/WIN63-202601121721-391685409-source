package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetCreditFurniRedeemMessage extends RoomWidgetMessage
   {
      
      public static const const_364:String = "RWFCRM_REDEEM";
      
      private var var_315:int;
      
      public function RoomWidgetCreditFurniRedeemMessage(param1:String, param2:int)
      {
         super(param1);
         var_315 = param2;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
   }
}

