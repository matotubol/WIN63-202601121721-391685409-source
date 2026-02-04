package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class FurnisHaveAvatars extends DefaultConditionType
   {
      
      public function FurnisHaveAvatars()
      {
         super();
      }
      
      private static function getEvalRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("eval_" + param2 + "_radio"));
      }
      
      private static function getEvalSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("eval_selector"));
      }
      
      override public function get code() : int
      {
         return class_4100.FURNIS_HAVE_AVATARS;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getEvalSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getEvalSelector(cont).setSelected(getEvalRadio(cont,_loc2_));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

