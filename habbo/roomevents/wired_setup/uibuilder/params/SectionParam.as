package com.sulake.habbo.roomevents.wired_setup.uibuilder.params
{
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   
   public class SectionParam
   {
      
      public static var var_5299:int = 0;
      
      public static var var_5352:int = 1;
      
      public static var var_5298:int = 2;
      
      public static var DEFAULT:SectionParam = new SectionParam(null,0);
      
      public static var COLLAPSED:SectionParam = new SectionParam(null,1);
      
      public static var var_2495:SectionParam = new SectionParam(null,2);
      
      private var var_3777:Array = [];
      
      private var var_3076:int;
      
      private var var_2784:SourceTypeSelectorParam;
      
      private var _headerOptionLeft:WiredUIPreset;
      
      public function SectionParam(param1:SourceTypeSelectorParam = null, param2:int = 0, param3:WiredUIPreset = null)
      {
         super();
         var_3076 = param2;
         var_2784 = param1;
         _headerOptionLeft = param3;
      }
      
      public function get expandMode() : int
      {
         return var_3076;
      }
      
      public function get sourceTypeSelectorParam() : SourceTypeSelectorParam
      {
         return var_2784;
      }
      
      public function set expandMode(param1:int) : void
      {
         var_3076 = param1;
      }
      
      public function set sourceTypeSelectorParam(param1:SourceTypeSelectorParam) : void
      {
         var_2784 = param1;
      }
      
      public function addHeaderOption(param1:WiredUIPreset) : void
      {
         var_3777.push(param1);
      }
      
      public function get miscHeaderOptions() : Array
      {
         return var_3777;
      }
      
      public function get headerOptionLeft() : WiredUIPreset
      {
         return _headerOptionLeft;
      }
   }
}

