package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3845 extends DefaultConditionType
   {
      
      public function class_3845()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_ACTOR_IS_WEARING_EFFECT;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(int(getInput(cont).text));
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         getInput(cont).text = param1.intParams[0];
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812) : ITextFieldWindow
      {
         return ITextFieldWindow(param1.findChildByName("effect_id"));
      }
   }
}

