package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3778 extends DefaultConditionType
   {
      
      private var _cont:class_1812;
      
      public function class_3778()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.TRIGGERER_MATCHES;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_TRIGGERER_MATCHES;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         getCertainAvatarRadio().addEventListener("WE_SELECT",onCertainAvatarSelect);
         getCertainAvatarRadio().addEventListener("WE_UNSELECT",onCertainAvatarUnselect);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getUserTypeSelector().setSelected(getUserTypeRadio(_loc2_));
         if(param1.stringParam != "")
         {
            getUserNameSelector().setSelected(getCertainAvatarRadio());
            getUserNameInput().text = param1.stringParam;
            getUserNameInput().visible = true;
         }
         else
         {
            getUserNameSelector().setSelected(getAnyAvatarRadio());
            getUserNameInput().text = "";
            getUserNameInput().visible = false;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getUserTypeSelector().getSelected().id);
         return _loc1_;
      }
      
      override public function readStringParamFromForm() : String
      {
         var _loc1_:String = getUserNameInput().text;
         return getCertainAvatarRadio().isSelected ? _loc1_ : "";
      }
      
      private function getUserTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("usertype_" + param1 + "_radio"));
      }
      
      private function getUserTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("usertype_selector"));
      }
      
      private function getUserNameInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("avatar_name_txt"));
      }
      
      private function getCertainAvatarRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("certain_avatar_radio"));
      }
      
      private function getAnyAvatarRadio() : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("any_avatar_radio"));
      }
      
      private function getUserNameSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("avatar_radio"));
      }
      
      private function onCertainAvatarSelect(param1:class_1758) : void
      {
         getUserNameInput().visible = true;
      }
      
      private function onCertainAvatarUnselect(param1:class_1758) : void
      {
         getUserNameInput().text = "";
         getUserNameInput().visible = false;
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.match." + param1;
      }
   }
}

