package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetFurniActionMessage extends RoomWidgetMessage
   {
      
      public static const ROTATE:String = "RWFUAM_ROTATE";
      
      public static const MOVE:String = "RWFAM_MOVE";
      
      public static const const_1022:String = "RWFAM_PICKUP";
      
      public static const const_640:String = "RWFAM_EJECT";
      
      public static const USE:String = "RWFAM_USE";
      
      public static const SAVE_STUFF_DATA:String = "RWFAM_SAVE_STUFF_DATA";
      
      public static const const_112:String = "RWFAM_WIRED_INSPECT";
      
      private var var_2536:int = 0;
      
      private var var_4952:int = 0;
      
      private var _offerId:int;
      
      private var var_3840:String;
      
      public function RoomWidgetFurniActionMessage(param1:String, param2:int, param3:int, param4:int = -1, param5:String = null)
      {
         super(param1);
         var_2536 = param2;
         var_4952 = param3;
         _offerId = param4;
         var_3840 = param5;
      }
      
      public function get furniId() : int
      {
         return var_2536;
      }
      
      public function get furniCategory() : int
      {
         return var_4952;
      }
      
      public function get objectData() : String
      {
         return var_3840;
      }
      
      public function get offerId() : int
      {
         return _offerId;
      }
   }
}

