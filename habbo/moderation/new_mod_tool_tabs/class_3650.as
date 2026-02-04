package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.moderation.class_1852;
   
   [SecureSWF(rename="true")]
   public class class_3650 extends class_2613
   {
      
      public function class_3650(param1:class_1852, param2:class_1812)
      {
         super(param1,param2);
         getBanRadio.select();
         performBanAction.addEventListener("WME_CLICK",onBanClick);
      }
      
      private function onBanClick(param1:WindowMouseEvent) : void
      {
         usernameInput.text = tool.sessionDataManager.userName;
         getBanRadio.select();
         getDurationSelector.selection = getDurationSelector.numMenuItems - 1;
         tool.windowManager.confirm("${moderation.ban_management.do.title}",tool.localizationManager.getLocalizationWithParams("moderation.ban_management.do.desc","","action",getBanRadio.isSelected ? "BAN" : "UNBAN","user",usernameInput.text,"duration",getDurationSelector.enumerateSelection()[getDurationSelector.selection]),0,onConfirmClicked);
      }
      
      private function onConfirmClicked(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         tool.setToolCompletion(0);
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("ban_username_input") as ITextFieldWindow;
      }
      
      private function get getBanRadio() : IRadioButtonWindow
      {
         return window.findChildByName("ban_radio") as IRadioButtonWindow;
      }
      
      private function get getUnbanRadio() : IRadioButtonWindow
      {
         return window.findChildByName("unban_radio") as IRadioButtonWindow;
      }
      
      private function get getDurationSelector() : class_2261
      {
         return window.findChildByName("duration_selector") as class_2261;
      }
      
      private function get performBanAction() : class_1775
      {
         return window.findChildByName("ban_btn") as class_1775;
      }
   }
}

