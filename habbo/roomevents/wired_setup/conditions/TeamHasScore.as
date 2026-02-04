package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class TeamHasScore extends DefaultConditionType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:class_1812;
      
      private var var_2389:SliderWindowController;
      
      public function TeamHasScore()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.TEAM_HAS_SCORE;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
         _roomEvents = param3;
         var_2389 = new SliderWindowController(param3,getScoreContainer(),param3.assets,0,1000,1);
         var_2389.setValue(1);
         var_2389.addEventListener("change",onScoreChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:int = int(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         var _loc3_:int = int(param1.intParams[2]);
         getTeamSelector().setSelected(getTeamRadio(_loc4_));
         var_2389.setValue(_loc2_);
         getComparisonSelector().setSelected(getComparisonRadio(_loc3_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getTeamSelector().getSelected().id);
         _loc1_.push(var_2389.getValue());
         _loc1_.push(getComparisonSelector().getSelected().id);
         return _loc1_;
      }
      
      private function getComparisonRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("comp_" + param1 + "_radio"));
      }
      
      private function getComparisonSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("comp_selector"));
      }
      
      private function getTeamRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("team_" + param1 + "_radio"));
      }
      
      private function getTeamSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("team_selector"));
      }
      
      private function getScoreContainer() : class_1812
      {
         return _cont.findChildByName("score_slider_cont") as class_1812;
      }
      
      private function onScoreChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _loc4_ = _loc3_;
               _roomEvents.localization.registerParameter("wiredfurni.params.setscore","points","" + _loc4_);
            }
         }
      }
   }
}

