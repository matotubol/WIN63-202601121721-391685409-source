package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class GiveScore extends DefaultActionType
   {
      
      private static var var_5327:Number = 10;
      
      private static var var_2634:Number = var_5327 + 1;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1174:SliderWindowController;
      
      private var var_1815:SliderWindowController;
      
      private var _cont:class_1812;
      
      public function GiveScore()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.GIVE_SCORE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getScore());
         _loc1_.push(var_1815.getValue() == var_2634 ? 0 : var_1815.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         _cont = param1;
         getTypeSelector().setSelected(getTypeRadio(0));
         var_1174 = new SliderWindowController(param3,getInput(),param3.assets,1,1000,1);
         var_1174.addEventListener("change",onSliderChange);
         var_1174.setValue(1);
         getTypeRadio(0).addEventListener("WE_SELECT",onTypeChange);
         getTypeRadio(1).addEventListener("WE_SELECT",onTypeChange);
         var_1815 = new SliderWindowController(param3,getCounterInput(),param3.assets,1,var_2634,1);
         var_1815.addEventListener("change",onCounterSliderChange);
         var_1815.setValue(1);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = 0;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
            _loc4_ = 1;
         }
         getTypeSelector().setSelected(getTypeRadio(_loc4_));
         var_1174.setValue(_loc2_);
         var_1815.setValue(_loc3_ == 0 ? var_2634 : _loc3_);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput() : class_1812
      {
         return _cont.findChildByName("slider_container") as class_1812;
      }
      
      private function getCounterInput() : class_1812
      {
         return _cont.findChildByName("counter_slider_container") as class_1812;
      }
      
      private function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               updateSliderText();
            }
         }
      }
      
      private function onTypeChange(param1:class_1758) : void
      {
         updateSliderText();
      }
      
      private function updateSliderText() : void
      {
         var _loc1_:int = getScore();
         _roomEvents.localization.registerParameter("wiredfurni.params.setpoints","points","" + _loc1_);
      }
      
      private function getScore() : int
      {
         var _loc1_:int = var_1174.getValue();
         if(getTypeSelector().getSelected().id == 1)
         {
            _loc1_ = -_loc1_;
         }
         return _loc1_;
      }
      
      private function onCounterSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc3_:Number = NaN;
         var _loc4_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc2_.getValue();
               _loc4_ = int(_loc3_) == var_2634 ? "∞" : "" + int(_loc3_);
               _roomEvents.localization.registerParameter("wiredfurni.params.settimesingame","times",_loc4_);
            }
         }
      }
      
      private function getTypeRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(_cont.findChildByName("type_" + param1 + "_radio"));
      }
      
      private function getTypeSelector() : ISelectorWindow
      {
         return ISelectorWindow(_cont.findChildByName("type_selector"));
      }
   }
}

