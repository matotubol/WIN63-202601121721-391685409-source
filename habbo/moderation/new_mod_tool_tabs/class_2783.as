package com.sulake.habbo.moderation.new_mod_tool_tabs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconButtonWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.moderation.class_1852;
   
   [SecureSWF(rename="true")]
   public class class_2783 extends class_2613
   {
      
      public function class_2783(param1:class_1852, param2:class_1812)
      {
         super(param1,param2);
         plusButton.addEventListener("WME_CLICK",onPlusButtonClick);
         minusButton.addEventListener("WME_CLICK",onMinusButtonClick);
         donateFurniButton.addEventListener("WME_CLICK",onDonateClick);
      }
      
      private function onDonateClick(param1:WindowMouseEvent) : void
      {
         tool.windowManager.alert("${error.title}","${moderation.give_furni.too_many_requests}",0,onAlertConfirm);
      }
      
      private function onAlertConfirm(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
         tool.setToolCompletion(4);
      }
      
      override public function onOpen() : void
      {
         super.onOpen();
         usernameInput.text = tool.sessionDataManager.userName;
      }
      
      private function onPlusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount < 100)
         {
            amount += 1;
         }
      }
      
      private function onMinusButtonClick(param1:WindowMouseEvent) : void
      {
         if(amount > 1)
         {
            amount -= 1;
         }
      }
      
      private function get amount() : int
      {
         return parseInt(amountFurniInput.text);
      }
      
      private function set amount(param1:int) : void
      {
         amountFurniInput.text = "" + param1;
      }
      
      private function get usernameInput() : ITextFieldWindow
      {
         return window.findChildByName("give_furni_username_input") as ITextFieldWindow;
      }
      
      private function get productNameInput() : ITextFieldWindow
      {
         return window.findChildByName("product_name_input") as ITextFieldWindow;
      }
      
      private function get amountFurniInput() : ITextFieldWindow
      {
         return window.findChildByName("amount_furni_input") as ITextFieldWindow;
      }
      
      private function get plusButton() : IIconButtonWindow
      {
         return window.findChildByName("plus_btn_furni") as IIconButtonWindow;
      }
      
      private function get minusButton() : IIconButtonWindow
      {
         return window.findChildByName("minus_btn_furni") as IIconButtonWindow;
      }
      
      private function get donateFurniButton() : class_1775
      {
         return window.findChildByName("add_furni_btn") as class_1775;
      }
   }
}

