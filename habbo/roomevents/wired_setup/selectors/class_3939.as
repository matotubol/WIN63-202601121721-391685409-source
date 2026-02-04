package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class class_3939 extends DefaultSelectorType
   {
      
      private var _cont:class_1812;
      
      public function class_3939()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.REMOTE_SELECTOR;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         getRandomRadio(1).addEventListener("WE_SELECTED",onRandomSelectionSelect);
         getRandomRadio(1).addEventListener("WE_UNSELECTED",onRandomSelectionUnselect);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         typeSelector.setSelected(getTypeRadio(_loc3_));
         var _loc2_:int = int(param1.intParams[1]);
         valueInput.text = _loc2_ + "";
         randomSelector.setSelected(getRandomRadio(_loc2_ > 0 ? 1 : 0));
         setRandomPicksActive(_loc2_ > 0);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(typeSelector.getSelected().id);
         _loc1_.push(getRandomRadio(1).isSelected ? Util.getIntFromInput(valueInput,0) : 0);
         return _loc1_;
      }
      
      private function setRandomPicksActive(param1:Boolean) : void
      {
         Util.disableSection(valueInput,!param1);
      }
      
      private function onRandomSelectionSelect(param1:class_1758) : void
      {
         setRandomPicksActive(true);
      }
      
      private function onRandomSelectionUnselect(param1:class_1758) : void
      {
         setRandomPicksActive(false);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("type_" + param1 + "_radio"));
      }
      
      private function get typeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("type_selector"));
      }
      
      private function getRandomRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("random_" + param1 + "_radio"));
      }
      
      private function get randomSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("random_selector"));
      }
      
      private function get valueInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("value_input"));
      }
   }
}

