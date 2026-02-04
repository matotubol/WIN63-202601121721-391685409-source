package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.class_2677;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_188.class_3414;
   import package_189.WiredVariable;
   
   public class ValueOrVariableSection extends AbstractSectionPreset implements class_2677
   {
      
      private var var_1580:RadioGroupPreset;
      
      private var var_1186:NumberInputPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var _sourcePreset:SourceTypeSelectorPreset;
      
      private var var_3579:int;
      
      private var var_1252:int;
      
      public function ValueOrVariableSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int, param5:Array, param6:String, param7:int, param8:int)
      {
         super(param1,param2,param3);
         var_3579 = param4;
         var_1186 = param2.createNumberInput(new NumberInputParam(0,param7,param8,45,0,false,true));
         _sourcePreset = param2.createSourceTypeSelector(new SourceTypeSelectorParam(param5,this));
         _picker = param2.createVariablePicker(variableSelectionFilter);
         var_1580 = param2.createRadioGroup([new RadioButtonParam(0,l("variables.reference_value.set_value"),var_1186),new RadioButtonParam(1,l("variables.reference_value.from_variable"),_sourcePreset.alignRight(),_picker)],onChangeRadioOption);
         initializeSection(param6,var_1580);
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      public function init(param1:class_3414, param2:String, param3:int, param4:int, param5:int) : void
      {
         _picker.init(param1,param2,param3);
         var_1252 = param3;
         var_1580.selected = param4;
         var_1186.value = param5;
      }
      
      public function onEditInitialized() : void
      {
         _sourcePreset.select(var_1252);
      }
      
      public function set target(param1:int) : void
      {
         var_1252 = param1;
         _picker.variableTarget = var_1252;
      }
      
      public function get target() : int
      {
         return var_1252;
      }
      
      public function get option() : int
      {
         return var_1580.selected;
      }
      
      public function get numberValue() : int
      {
         return var_1186.value;
      }
      
      public function get finalizeSelection() : String
      {
         return _picker.finalizeSelection;
      }
      
      private function onChangeRadioOption(param1:int) : void
      {
         _roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,var_3579);
      }
      
      public function isSourcePickingDisabled() : Boolean
      {
         return var_1580.selected == 0;
      }
      
      public function set sourceType(param1:int) : void
      {
         _roomEvents.wiredCtrl.setMergedSourceType(var_3579,param1);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_1580 = null;
         var_1186 = null;
         _picker = null;
         _sourcePreset = null;
      }
   }
}

