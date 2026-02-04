package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_4051 extends DefaultTriggerConf
   {
      
      public function class_4051()
      {
         super();
      }
      
      private static function getModeRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("mode_" + param2 + "_radio"));
      }
      
      private static function getModeSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("mode_selector"));
      }
      
      override public function get code() : int
      {
         return class_4093.STATE_CHANGE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getModeSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function get hasStateSnapshot() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getModeSelector(cont).setSelected(getModeRadio(cont,_loc2_));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

