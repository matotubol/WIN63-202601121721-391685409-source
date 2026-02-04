package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetChangeMottoMessage extends RoomWidgetMessage
   {
      
      public static const CHANGE_MOTTO:String = "RWVM_CHANGE_MOTTO_MESSAGE";
      
      private var var_3144:String;
      
      public function RoomWidgetChangeMottoMessage(param1:String)
      {
         super("RWVM_CHANGE_MOTTO_MESSAGE");
         var_3144 = param1;
      }
      
      public function get motto() : String
      {
         return var_3144;
      }
   }
}

