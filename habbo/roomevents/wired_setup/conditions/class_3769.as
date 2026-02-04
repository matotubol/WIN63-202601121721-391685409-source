package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3769 extends DefaultConditionType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:class_1812;
      
      private var var_1864:SliderWindowController;
      
      public function class_3769()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.FURNI_HAS_ALTITUDE;
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
         var_1864 = new SliderWindowController(param3,getAltitudeContainer(),param3.assets,0,8000,1);
         var_1864.setValue(0);
         var_1864.addEventListener("change",onAltitudeChange);
         getAltitudeInput().text = "0.00";
         getAltitudeInput().addEventListener("WE_CHANGE",onAltitudeTextFieldChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:Number = Number(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         var_1864.setValue(_loc2_);
         getAltitudeInput().text = (_loc2_ / 100).toFixed(2);
         getComparisonSelector().setSelected(getComparisonRadio(_loc3_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(int(var_1864.getValue()));
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
      
      private function getAltitudeInput() : ITextFieldWindow
      {
         return ITextFieldWindow(_cont.findChildByName("altitude_input"));
      }
      
      private function getAltitudeValueFromInput() : int
      {
         var _loc1_:String = getAltitudeInput().text;
         if(isNaN(Number(_loc1_)))
         {
            return -1;
         }
         return Math.round(Number(_loc1_) * 100);
      }
      
      private function getAltitudeContainer() : class_1812
      {
         return _cont.findChildByName("altitude_slider_cont") as class_1812;
      }
      
      private function onAltitudeTextFieldChange(param1:class_1758) : void
      {
         var _loc2_:int = getAltitudeValueFromInput();
         if(_loc2_ != -1)
         {
            var_1864.setValue(_loc2_,true,false);
         }
      }
      
      private function onAltitudeChange(param1:Event) : void
      {
         var _loc2_:SliderWindowController = null;
         var _loc4_:Number = NaN;
         var _loc3_:String = null;
         if(param1.type == "change")
         {
            _loc2_ = param1.target as SliderWindowController;
            if(_loc2_)
            {
               _loc4_ = _loc2_.getValue() / 100;
               _loc3_ = _loc4_.toFixed(2);
               getAltitudeInput().text = _loc3_;
            }
         }
      }
   }
}

