package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetStickieSendUpdateMessage extends RoomWidgetMessage
   {
      
      public static const const_232:String = "RWSUM_STICKIE_SEND_UPDATE";
      
      public static const const_791:String = "RWSUM_STICKIE_SEND_DELETE";
      
      private var var_315:int;
      
      private var _text:String;
      
      private var var_628:String;
      
      public function RoomWidgetStickieSendUpdateMessage(param1:String, param2:int, param3:String = "", param4:String = "")
      {
         super(param1);
         var_315 = param2;
         _text = param3;
         var_628 = param4;
      }
      
      public function get objectId() : int
      {
         return var_315;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get colorHex() : String
      {
         return var_628;
      }
   }
}

