package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3753 extends DefaultConditionType
   {
      
      public function class_3753()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.ACTOR_IS_WEARING_BADGE;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_ACTOR_IS_WEARING_BADGE;
      }
      
      override public function readStringParamFromForm() : String
      {
         return getInput(cont).text;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         getInput(cont).text = param1.stringParam;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("badge_code"));
      }
   }
}

