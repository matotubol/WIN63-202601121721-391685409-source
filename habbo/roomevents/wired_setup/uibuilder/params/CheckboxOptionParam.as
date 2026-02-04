package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class CheckboxOptionParam
   {
      
      private var _text:String;
      
      private var var_197:int = -1;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      public function CheckboxOptionParam(param1:String, param2:int = -1)
      {
         super();
         this._text = param1;
         this.var_197 = param2;
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
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function set id(param1:int) : void
      {
         var_197 = param1;
      }
   }
}

