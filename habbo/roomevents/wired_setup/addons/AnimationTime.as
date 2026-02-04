package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class AnimationTime extends DefaultAddonType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1174:SliderWindowController;
      
      public function AnimationTime()
      {
         super();
      }
      
      private static function getInput(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container") as class_1812;
      }
      
      override public function get code() : int
      {
         return class_4074.ANIMATION_TIME;
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
         var_1174 = new SliderWindowController(param3,getInput(param1),param3.assets,50,2000,50);
         var_1174.setValue(500);
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
      
      protected function onSliderChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc2_.getValue();
               _loc3_ = (int(_loc4_)) + "";
               _roomEvents.localization.registerParameter("wiredfurni.params.setanimationtime","ms",_loc3_);
            }
         }
      }
      
      public function get slider() : SliderWindowController
      {
         return var_1174;
      }
   }
}

