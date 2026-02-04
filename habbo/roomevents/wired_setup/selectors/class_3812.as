package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3812 extends DefaultSelectorType
   {
      
      public function class_3812()
      {
         super();
      }
      
      private static function getTeamRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("team_" + param2 + "_radio"));
      }
      
      private static function getTeamSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("team_selector"));
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_IN_TEAM;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         getTeamSelector(cont).setSelected(getTeamRadio(cont,_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getTeamSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

