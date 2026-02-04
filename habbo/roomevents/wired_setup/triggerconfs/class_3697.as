package com.sulake.habbo.roomevents.wired_setup.triggerconfs
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3697 extends DefaultTriggerConf
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1174:SliderWindowController;
      
      public function class_3697()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4093.TRIGGER_PERIODICALLY;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1174.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_1174 = new SliderWindowController(param3,getInput(param1),param3.assets,1,120,1);
         var_1174.setValue(1);
         var_1174.addEventListener("change",onSliderChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var_1174.setValue(_loc2_);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container") as class_1812;
      }
      
      protected function onSliderChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.settime","seconds",_loc3_);
            }
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_1174;
      }
   }
}

