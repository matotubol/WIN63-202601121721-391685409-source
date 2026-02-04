package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.triggerconfs.class_3897;
   import flash.events.Event;
   
   public class class_3717 extends DefaultConditionType
   {
      
      private var _cont:class_1812;
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2348:SliderWindowController;
      
      private var var_2220:SliderWindowController;
      
      public function class_3717()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.CLOCK_TIME_MATCHES;
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
         var_2348 = new SliderWindowController(param3,getInputSeconds(),param3.assets,0,119,1);
         var_2348.setValue(0);
         var_2348.addEventListener("change",onSliderSecondsChange);
         var_2220 = new SliderWindowController(param3,getInputMinutes(),param3.assets,0,99,1);
         var_2220.setValue(0);
         var_2220.addEventListener("change",onSliderMinutesChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         var _loc4_:int = int(param1.intParams[1]);
         var _loc5_:int = int(param1.intParams[2]);
         var_2348.setValue(_loc3_ * 2 + _loc5_);
         var_2220.setValue(_loc4_);
         var _loc2_:int = int(param1.intParams[3]);
         getComparisonSelector().setSelected(getComparisonRadio(_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc4_:Number = var_2348.getValue();
         var _loc2_:int = Math.floor(_loc4_ / 2);
         var _loc3_:int = _loc4_ % 2;
         _loc1_.push(_loc2_);
         _loc1_.push(var_2220.getValue());
         _loc1_.push(_loc3_);
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
      
      private function getInputSeconds() : class_1812
      {
         return _cont.findChildByName("slider_container_seconds") as class_1812;
      }
      
      private function getInputMinutes() : class_1812
      {
         return _cont.findChildByName("slider_container_minutes") as class_1812;
      }
      
      private function onSliderSecondsChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc5_:Number = NaN;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc5_ = _loc2_.getValue();
               _loc3_ = class_3897.getSecsFromPulses(_loc4_);
               _roomEvents.localization.registerParameter("wiredfurni.params.clock_seconds_elapsed","seconds","" + _loc3_);
            }
         }
      }
      
      private function onSliderMinutesChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:int = 0;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc3_ = _loc4_ = _loc2_.getValue();
               _roomEvents.localization.registerParameter("wiredfurni.params.clock_minutes_elapsed","minutes","" + _loc3_);
            }
         }
      }
   }
}

