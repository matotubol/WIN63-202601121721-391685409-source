package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3680 extends class_3679
   {
      
      public function class_3680()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.BOT_FOLLOW_AVATAR;
      }
      
      override public function readStringParamFromForm() : String
      {
         return getInput(cont,"bot_name").text;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [getSelector(cont,"type_selector").getSelected().id];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         getInput(cont,"bot_name").text = param1.stringParam;
         getSelector(cont,"type_selector").setSelected(getRadio(cont,"radio_" + param1.intParams[0]));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812, param2:String) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName(param2));
      }
      
      private function getSelector(param1:class_1812, param2:String) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName(param2));
      }
      
      private function getRadio(param1:class_1812, param2:String) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName(param2));
      }
   }
}

