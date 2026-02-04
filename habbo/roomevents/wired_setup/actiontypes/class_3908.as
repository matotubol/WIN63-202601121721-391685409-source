package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRadioButtonWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   
   public class class_3908 extends DefaultActionType
   {
      
      public function class_3908()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.MOVE_TO_DIRECTION;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         param3.refreshButton(param1,"move_0",true,null,0);
         param3.refreshButton(param1,"move_1",true,null,0);
         param3.refreshButton(param1,"move_2",true,null,0);
         param3.refreshButton(param1,"move_3",true,null,0);
         param3.refreshButton(param1,"move_4",true,null,0);
         param3.refreshButton(param1,"move_5",true,null,0);
         param3.refreshButton(param1,"move_6",true,null,0);
         param3.refreshButton(param1,"move_7",true,null,0);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:int = int(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         getStartDirSelector(cont).setSelected(getStartDirRadio(cont,_loc4_));
         getTurnSelector(cont).setSelected(getTurnRadio(cont,_loc2_));
         var _loc3_:* = param1.intParams[2] != 0;
         Util.select(blockOnCollideCheckbox,_loc3_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(getStartDirSelector(cont).getSelected().id);
         _loc1_.push(getTurnSelector(cont).getSelected().id);
         _loc1_.push(blockOnCollideCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function getStartDirRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("startdir_" + param2 + "_radio"));
      }
      
      private function getTurnRadio(param1:class_1812, param2:int) : IRadioButtonWindow
      {
         return IRadioButtonWindow(param1.findChildByName("turn_" + param2 + "_radio"));
      }
      
      private function getStartDirSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("startdir_selector"));
      }
      
      private function getTurnSelector(param1:class_1812) : ISelectorWindow
      {
         return ISelectorWindow(param1.findChildByName("turn_selector"));
      }
      
      private function get blockOnCollideCheckbox() : class_1885
      {
         return class_1885(cont.findChildByName("block_on_collide_checkbox"));
      }
   }
}

