package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AbstractSectionPreset extends WiredUIPreset
   {
      
      protected var var_785:SectionPreset;
      
      public function AbstractSectionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super(param1,param2,param3);
      }
      
      protected function initializeSection(param1:String, param2:WiredUIPreset, param3:SectionParam = null) : void
      {
         var_785 = var_182.createSection(param1,param2,param3);
      }
      
      override public function get window() : class_1741
      {
         return var_785.window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var_785.resizeToWidth(param1);
      }
      
      public function set splitterVisible(param1:Boolean) : void
      {
         var_785.splitterVisible = param1;
      }
      
      override protected function get childPresets() : Array
      {
         return [var_785];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_785 = null;
      }
   }
}

