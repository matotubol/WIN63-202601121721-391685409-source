package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.moderation.class_1852;
   
   [SecureSWF(rename="true")]
   public class class_3382 extends class_2613
   {
      
      public function class_3382(param1:class_1852, param2:class_1812)
      {
         super(param1,param2);
         sendHotelAlertButton.addEventListener("WME_CLICK",onSendClicked);
      }
      
      private function onSendClicked(param1:WindowMouseEvent) : void
      {
         tool.windowManager.simpleAlert("${notifications.broadcast.title}","",hotelAlertInput.text,"","",null,"illumina_alert_illustrations_frank_neutral_png");
         hotelAlertInput.text = "";
         tool.setToolCompletion(1);
      }
      
      private function get hotelAlertInput() : ITextFieldWindow
      {
         return window.findChildByName("hotel_alert_input") as ITextFieldWindow;
      }
      
      private function get sendHotelAlertButton() : class_1775
      {
         return window.findChildByName("send_hotel_alert_btn") as class_1775;
      }
   }
}

