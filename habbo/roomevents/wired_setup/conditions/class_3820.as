package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   
   public class class_3820 extends DefaultConditionType
   {
      
      public function class_3820()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.ACTOR_IS_IN_TEAM;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_ACTOR_IS_IN_TEAM;
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
      
      private function getTeamRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("team_" + param2 + "_radio"));
      }
      
      private function getTeamSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("team_selector"));
      }
   }
}

