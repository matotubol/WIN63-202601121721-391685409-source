package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   
   public class class_3993 extends class_3992
   {
      
      public function class_3993()
      {
         super();
      }
      
      override public function get code() : int
      {
         return SelectorCodes.var_5294;
      }
      
      override protected function get variableSource() : int
      {
         return WiredInputSourcePicker.var_128;
      }
   }
}

