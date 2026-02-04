package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   
   public class class_3909 extends DefaultActionType
   {
      
      public function class_3909()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.MOVE_USER;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         var _loc5_:class_1812 = moveContainer;
         param3.refreshButton(_loc5_,"move_0",true,null,0);
         param3.refreshButton(_loc5_,"move_1",true,null,0);
         param3.refreshButton(_loc5_,"move_2",true,null,0);
         param3.refreshButton(_loc5_,"move_3",true,null,0);
         param3.refreshButton(_loc5_,"move_4",true,null,0);
         param3.refreshButton(_loc5_,"move_5",true,null,0);
         param3.refreshButton(_loc5_,"move_6",true,null,0);
         param3.refreshButton(_loc5_,"move_7",true,null,0);
         var _loc4_:class_1812 = rotateContainer;
         param3.refreshButton(_loc4_,"move_0",true,null,0);
         param3.refreshButton(_loc4_,"move_1",true,null,0);
         param3.refreshButton(_loc4_,"move_2",true,null,0);
         param3.refreshButton(_loc4_,"move_3",true,null,0);
         param3.refreshButton(_loc4_,"move_4",true,null,0);
         param3.refreshButton(_loc4_,"move_5",true,null,0);
         param3.refreshButton(_loc4_,"move_6",true,null,0);
         param3.refreshButton(_loc4_,"move_7",true,null,0);
         param3.refreshButton(_loc4_,"rotate_ccw",true,null,0);
         param3.refreshButton(_loc4_,"rotate_cw",true,null,0);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = int(param1.intParams[0]);
         var _loc3_:int = int(param1.intParams[1]);
         moveSelector.setSelected(getMoveRadio(_loc2_));
         rotateSelector.setSelected(getRotateRadio(_loc3_));
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:int = int(moveSelector.getSelected().id);
         var _loc2_:int = int(rotateSelector.getSelected().id);
         _loc1_.push(_loc3_);
         _loc1_.push(_loc2_);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getMoveRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(cont.findChildByName("move_" + param1 + "_radio"));
      }
      
      private function getRotateRadio(param1:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(cont.findChildByName("rotate_" + param1 + "_radio"));
      }
      
      private function get moveSelector() : ISelectorWindow
      {
         return ISelectorWindow(cont.findChildByName("move_selector"));
      }
      
      private function get rotateSelector() : ISelectorWindow
      {
         return ISelectorWindow(cont.findChildByName("rotate_selector"));
      }
      
      private function get moveContainer() : class_1812
      {
         return class_1812(cont.findChildByName("move_container"));
      }
      
      private function get rotateContainer() : class_1812
      {
         return class_1812(cont.findChildByName("rotate_container"));
      }
   }
}

