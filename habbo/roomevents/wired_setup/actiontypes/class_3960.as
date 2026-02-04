package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.RelativeMoveAxis;
   
   public class class_3960 extends DefaultActionType
   {
      
      private var xAxis:RelativeMoveAxis;
      
      private var yAxis:RelativeMoveAxis;
      
      public function class_3960()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.RELATIVE_FURNI_MOVE;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         param3.refreshButton(param1,"move_0",true,null,0);
         param3.refreshButton(param1,"move_2",true,null,0);
         param3.refreshButton(param1,"move_4",true,null,0);
         param3.refreshButton(param1,"move_6",true,null,0);
         xAxis = new RelativeMoveAxis("horizontal",param1,param3);
         yAxis = new RelativeMoveAxis("vertical",param1,param3);
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:int = int(param1.intParams[0]);
         var _loc2_:int = int(param1.intParams[1]);
         xAxis.setValue(_loc3_);
         yAxis.setValue(_loc2_);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(xAxis.getValue());
         _loc1_.push(yAxis.getValue());
         return _loc1_;
      }
   }
}

