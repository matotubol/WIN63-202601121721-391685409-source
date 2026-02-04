package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3788 extends DefaultActionType
   {
      
      public function class_3788()
      {
         super();
      }
      
      private static function getClockControlRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("clock_control_" + param2 + "_radio"));
      }
      
      private static function getClockControlSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("clock_control_selector"));
      }
      
      override public function get code() : int
      {
         return class_4061.CONTROL_CLOCK;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getClockControlSelector(cont).setSelected(getClockControlRadio(cont,_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getClockControlSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

