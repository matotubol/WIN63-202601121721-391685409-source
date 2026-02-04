package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3877 extends DefaultAddonType
   {
      
      private var _cont:class_1812;
      
      public function class_3877()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.VARIABLE_TEXT_CONVERTER;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         textInput.addEventListener("WKE_KEY_DOWN",onTextChange);
         textInput.addEventListener("WKE_KEY_UP",onTextChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         textInput.text = param1.stringParam.replace(/\n/g,"\r");
         onTextChange(null);
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc2_:String = textInput.text;
         return _loc2_.replace(/\n\r/g,"\n").replace(/\r/g,"\n");
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function onTextChange(param1:class_1758) : void
      {
         textInputHint.visible = textInput.text.length == 0;
      }
      
      protected function get textInput() : ITextFieldWindow
      {
         return _cont.findChildByName("text_input") as ITextFieldWindow;
      }
      
      protected function get textInputHint() : ITextWindow
      {
         return _cont.findChildByName("text_input_hint") as ITextWindow;
      }
   }
}

