package com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown
{
   public class ExpandableDropdownOption
   {
      
      private var var_197:int;
      
      private var _displayString:String;
      
      private var var_4155:Boolean;
      
      public function ExpandableDropdownOption(param1:int, param2:String, param3:Boolean = false)
      {
         super();
         var_197 = param1;
         _displayString = param2;
         var_4155 = param3;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get displayString() : String
      {
         return _displayString;
      }
      
      public function get isAdvanced() : Boolean
      {
         return var_4155;
      }
   }
}

