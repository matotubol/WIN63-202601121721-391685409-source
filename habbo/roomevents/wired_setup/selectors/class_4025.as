package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   
   public class class_4025 extends class_3992
   {
      
      public function class_4025()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.USERS_WITH_VARIABLE;
      }
      
      override protected function get variableSource() : int
      {
         return WiredInputSourcePicker.USER_SOURCE;
      }
   }
}

