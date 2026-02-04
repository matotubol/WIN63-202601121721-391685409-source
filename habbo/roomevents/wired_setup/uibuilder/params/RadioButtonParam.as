package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class RadioButtonParam
   {
      
      private var var_197:int;
      
      private var _text:String;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      public function RadioButtonParam(param1:int, param2:String, param3:WiredUIPreset = null, param4:WiredUIPreset = null)
      {
         super();
         this.var_197 = param1;
         this._text = param2;
         _extra1 = param3;
         _extra2 = param4;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get extra1() : WiredUIPreset
      {
         return _extra1;
      }
      
      public function set extra1(param1:WiredUIPreset) : void
      {
         _extra1 = param1;
      }
      
      public function get extra2() : WiredUIPreset
      {
         return _extra2;
      }
      
      public function set extra2(param1:WiredUIPreset) : void
      {
         _extra2 = param1;
      }
   }
}

