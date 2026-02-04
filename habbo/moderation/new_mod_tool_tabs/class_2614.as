package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.moderation.class_1852;
   
   [SecureSWF(rename="true")]
   public class class_2614 extends class_2613
   {
      
      private static var A:int = 50;
      
      private static var B:int = 40;
      
      private var var_4586:Boolean = false;
      
      private var var_4080:Boolean = false;
      
      public function class_2614(param1:class_1852, param2:class_1812)
      {
         super(param1,param2);
         sendWarningButton.addEventListener("WME_CLICK",onSendWarningClick);
      }
      
      private function onSendWarningClick(param1:WindowMouseEvent) : void
      {
         if(warningInput.length < A)
         {
            tool.windowManager.alert("${moderation.warning.send.warn_title}",tool.localizationManager.getLocalizationWithParams("moderation.warning.send.validation_short","","x",A),0,onAlertConfirm);
            var_4586 = true;
         }
         else if(warningInput.length > B)
         {
            tool.windowManager.alert("${moderation.warning.send.warn_title}",tool.localizationManager.getLocalizationWithParams("moderation.warning.send.validation_long","","x",B),0,onAlertConfirm);
            var_4080 = true;
         }
      }
      
      private function onAlertConfirm(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         if(var_4586 && var_4080)
         {
            tool.setToolCompletion(2);
         }
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("warning_username_input") as ITextFieldWindow;
      }
      
      private function get warningInput() : ITextFieldWindow
      {
         return window.findChildByName("warning_input") as ITextFieldWindow;
      }
      
      private function get sendWarningButton() : class_1775
      {
         return window.findChildByName("send_warning_btn") as class_1775;
      }
   }
}

