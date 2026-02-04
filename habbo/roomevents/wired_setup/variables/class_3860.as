package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import package_189.class_4094;
   
   public class class_3860 extends DefaultVariableType
   {
      
      private var _cont:class_1812;
      
      public function class_3860()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4086.CONTEXT_VARIABLE;
      }
      
      override public function onInit(param1:class_1812, param2:class_1812, param3:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1,param2,param3);
         _cont = param1;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(hasValueCheckbox.isSelected ? 1 : 0);
         return _loc1_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         super.onEditStart(param1);
         var _loc2_:* = param1.intParams[0] != 0;
         Util.select(hasValueCheckbox,_loc2_);
         initialVariableName = param1.stringParam;
      }
      
      override public function readStringParamFromForm() : String
      {
         return variableNameTxt.text;
      }
      
      override public function get legacyInputMode() : Boolean
      {
         return true;
      }
      
      private function get hasValueCheckbox() : class_1885
      {
         return class_1885(_cont.findChildByName("has_value_checkbox"));
      }
      
      override public function variableType() : int
      {
         return class_4094.var_5336;
      }
   }
}

