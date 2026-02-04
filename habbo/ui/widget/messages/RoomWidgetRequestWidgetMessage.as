package com.sulake.habbo.ui.widget.messages
{
   public class RoomWidgetRequestWidgetMessage extends RoomWidgetMessage
   {
      
      public static const REQUEST_USER_CHOOSER:String = "RWRWM_USER_CHOOSER";
      
      public static const REQUEST_FURNI_CHOOSER:String = "RWRWM_FURNI_CHOOSER";
      
      public static const REQUEST_FURNI_CHOOSER_ADD:String = "RWRWM_FURNI_CHOOSER_ADD";
      
      public static const REQUEST_ME_MENU:String = "RWRWM_ME_MENU";
      
      public static const REQUEST_EFFECTS:String = "RWRWM_EFFECTS";
      
      private var var_197:int;
      
      private var var_191:int;
      
      public function RoomWidgetRequestWidgetMessage(param1:String, param2:int = 0, param3:int = 0)
      {
         super(param1);
         var_197 = param2;
         var_191 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get category() : int
      {
         return var_191;
      }
   }
}

