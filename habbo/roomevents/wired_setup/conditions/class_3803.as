package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.SliderWindowController;
   import flash.events.Event;
   
   public class class_3803 extends DefaultConditionType
   {
      
      private var _roomEvents:HabboUserDefinedRoomEvents;
      
      private var var_1174:SliderWindowController;
      
      public function class_3803()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4100.STUFFS_IN_FORMATION;
      }
      
      override public function get negativeCode() : int
      {
         return class_4100.NOT_STUFFS_IN_FORMATION;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(int(var_1174.getValue()));
         _loc1_.push(getFormationSelector(cont).getSelected().id);
         return _loc1_;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _roomEvents = param3;
         var_1174 = new SliderWindowController(param3,getInput(param1),param3.assets,2,10,1);
         var_1174.setValue(3);
         var_1174.addEventListener("change",onSliderChange);
         param3.refreshButton(param1,"move_diag",true,null,0);
         param3.refreshButton(param1,"move_vrt",true,null,0);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_1174.setValue(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         getFormationSelector(cont).setSelected(getFormationRadio(cont,_loc2_));
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getInput(param1:class_1812) : class_1812
      {
         return param1.findChildByName("slider_container") as class_1812;
      }
      
      private function onSliderChange(param1:Event) : void
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
               _roomEvents.localization.registerParameter("wiredfurni.params.requiredformationsize","furnis","" + _loc3_);
            }
         }
      }
      
      private function getFormationRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("formation_" + param2 + "_radio"));
      }
      
      private function getFormationSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("formation_selector"));
      }
   }
}

