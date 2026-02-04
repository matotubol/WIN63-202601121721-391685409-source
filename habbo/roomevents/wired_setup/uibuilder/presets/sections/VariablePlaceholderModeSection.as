package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VariablePlaceholderModeSection extends AbstractSectionPreset
   {
      
      private var var_852:RadioGroupPreset;
      
      public function VariablePlaceholderModeSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String)
      {
         super(param1,param2,param3);
         var_852 = param2.createRadioGroup([new RadioButtonParam(0,l("texts.variable_display_type.1")),new RadioButtonParam(1,l("texts.variable_display_type.2"),null,param2.createText(l("texts.variable_display_type.2.info")).halfBlend().noDisable())]);
         initializeSection(param4,var_852);
      }
      
      public function get isTextMode() : Boolean
      {
         return var_852.selected == 1;
      }
      
      public function set isTextMode(param1:Boolean) : void
      {
         var_852.selected = param1 ? 1 : 0;
      }
      
      public function method_20(param1:int) : RadioButtonPreset
      {
         return var_852.method_20(param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_852 = null;
      }
   }
}

