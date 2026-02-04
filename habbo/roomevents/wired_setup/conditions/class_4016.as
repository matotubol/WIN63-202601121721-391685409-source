package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import flash.events.Event;
   
   public class class_4016 extends DefaultConditionType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var _cont:class_1812;
      
      private var var_2327:SliderWindowController;
      
      private var var_2419:Boolean;
      
      public function class_4016()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.INPUT_SOURCE_QUANTITY;
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
         var_2327 = new SliderWindowController(param3,getAmountContainer(),param3.assets,0,100,1);
         var_2327.setValue(5);
         var_2327.addEventListener("change",onAmountChange);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_2419 = param1.getBoolean(0);
         var _loc3_:int = int(param1.intParams[1]);
         var _loc2_:int = int(param1.intParams[2]);
         var_2327.setValue(_loc3_);
         getComparisonSelector().setSelected(getComparisonRadio(_loc2_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2419 ? 1 : 0);
         _loc1_.push(var_2327.getValue());
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
      
      private function getAmountContainer() : class_1812
      {
         return _cont.findChildByName("amount_slider_cont") as class_1812;
      }
      
      private function onAmountChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.setamount","amount","" + _loc3_);
            }
         }
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         var_2419 = param2 == WiredInputSourcePicker.USER_SOURCE;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_2419 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.var_128;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

