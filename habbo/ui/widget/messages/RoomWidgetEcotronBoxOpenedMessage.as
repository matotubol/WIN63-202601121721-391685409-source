package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetEcotronBoxOpenedMessage extends RoomWidgetMessage
   {
      
      public static const const_1024:String = "RWEBOM_ECOTRONBOX_OPENED";
      
      private var var_757:String;
      
      private var var_1015:int;
      
      public function RoomWidgetEcotronBoxOpenedMessage(param1:String, param2:String, param3:int)
      {
         super(param1);
         var_757 = param2;
         var_1015 = param3;
      }
      
      public function get itemType() : String
      {
         return var_757;
      }
      
      public function get classId() : int
      {
         return var_1015;
      }
   }
}

