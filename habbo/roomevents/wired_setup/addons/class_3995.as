package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3995 extends DefaultAddonType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_2347:SliderWindowController;
      
      private var var_2312:SliderWindowController;
      
      public function class_3995()
      {
         super();
      }
      
      private static function getInputPicks(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container_picks") as class_1812;
      }
      
      private static function getInputSkips(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container_skips") as class_1812;
      }
      
      override public function get code() : int
      {
         return class_4074.var_5337;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2312.getValue());
         _loc1_.push(var_2347.getValue());
         return _loc1_;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_2347 = new SliderWindowController(param3,getInputPicks(param1),param3.assets,1,50,1);
         var_2347.setValue(0);
         var_2347.addEventListener("change",onSliderPicksChange);
         var_2312 = new SliderWindowController(param3,getInputSkips(param1),param3.assets,0,50,1);
         var_2312.setValue(0);
         var_2312.addEventListener("change",onSliderSkipsChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var_2312.setValue(_loc2_);
         var_2347.setValue(_loc3_);
      }
      
      private function onSliderPicksChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.pickamount","picks","" + _loc3_);
            }
         }
      }
      
      private function onSliderSkipsChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.skipactions","skips","" + _loc3_);
            }
         }
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
   }
}

