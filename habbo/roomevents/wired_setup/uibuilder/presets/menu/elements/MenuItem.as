package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements
{
   public class MenuItem implements class_4008
   {
      
      private var _name:String;
      
      private var var_2263:Function;
      
      private var var_5104:String;
      
      private var _hasCheckbox:Boolean;
      
      private var var_5164:Function;
      
      public function MenuItem(param1:String, param2:Function, param3:String = "", param4:Boolean = false, param5:Function = null)
      {
         super();
         _name = param1;
         var_2263 = param2;
         var_5104 = param3;
         _hasCheckbox = param4;
         var_5164 = param5;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get onClick() : Function
      {
         return var_2263;
      }
      
      public function get tooltip() : String
      {
         return var_5104;
      }
      
      public function get hasCheckbox() : Boolean
      {
         return _hasCheckbox;
      }
      
      public function get selectedChange() : Function
      {
         return var_5164;
      }
   }
}

