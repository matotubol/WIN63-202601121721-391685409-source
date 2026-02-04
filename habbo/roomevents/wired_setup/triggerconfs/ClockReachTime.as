package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class ClockReachTime extends DefaultTriggerConf
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2348:SliderWindowController;
      
      private var var_2220:SliderWindowController;
      
      public function ClockReachTime()
      {
         super();
      }
      
      private static function getInputSeconds(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container_seconds") as class_1812;
      }
      
      private static function getInputMinutes(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container_minutes") as class_1812;
      }
      
      override public function get code() : int
      {
         return class_4093.CLOCK_REACH_TIME;
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
         return _loc1_;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2348 = new SliderWindowController(param3,getInputSeconds(param1),param3.assets,0,119,1);
         var_2348.setValue(0);
         var_2348.addEventListener("change",onSliderSecondsChange);
         var_2220 = new SliderWindowController(param3,getInputMinutes(param1),param3.assets,0,99,1);
         var_2220.setValue(0);
         var_2220.addEventListener("change",onSliderMinutesChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc4_:int = int(param1.intParams[2]);
         var_2348.setValue(_loc2_ * 2 + _loc4_);
         var_2220.setValue(_loc3_);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
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

