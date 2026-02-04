package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxOptionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3992 extends DefaultSelectorType
   {
      
      private var _section1:SectionPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var _section2:SectionPreset;
      
      private var var_1310:CheckboxOptionPreset;
      
      private var _section3:SectionPreset;
      
      private var var_2903:RadioGroupPreset;
      
      private var _section4:ValueOrVariableSection;
      
      public function class_3992()
      {
         super();
      }
      
      private static function variableSelectionFilter1(param1:WiredVariable) : Boolean
      {
         return true;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_2903.selected);
         _loc1_.push(var_1310.selected ? _section4.option + 1 : 0);
         Util.pushIntAsLong(_loc1_,_section4.numberValue);
         _loc1_.push(_section4.target);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection,_section4.finalizeSelection];
      }
      
      protected function get variableSource() : int
      {
         return -1;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:Array = param1.intParams;
         var _loc6_:String = param1.variableIds[0];
         var _loc2_:String = param1.variableIds[1];
         var _loc3_:int = int(_loc4_[0]);
         var _loc5_:int = int(_loc4_[1]);
         var _loc7_:int = int(_loc4_[3]);
         var _loc8_:int = int(_loc4_[4]);
         _picker.init(param1.wiredContext.roomVariablesList,_loc6_,variableSource);
         var_2903.selected = _loc3_;
         if(_loc5_ == 0 || _picker.selected == null || !_picker.selected.hasValue)
         {
            _loc2_ = WiredVariable.var_636;
            _loc7_ = 0;
            _loc5_ = 0;
            var_1310.selected = false;
         }
         else if(_loc5_ == 1)
         {
            _loc2_ = WiredVariable.var_636;
            var_1310.selected = true;
         }
         else
         {
            _loc7_ = 0;
            var_1310.selected = true;
         }
         _section4.init(param1.wiredContext.roomVariablesList,_loc2_,_loc8_,_loc5_ - 1,_loc7_);
         setValueSelectionVisibility(_picker.selected != null && _picker.selected.hasValue && _loc5_ > 0);
         onVariableSelected(_picker.selected);
      }
      
      override public function onEditInitialized() : void
      {
         _section4.onEditInitialized();
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 0)
         {
            return _section2.disabled || !var_1310.selected || _section4.isSourcePickingDisabled();
         }
         return false;
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 != null && param1.hasValue;
         _section2.disabled = !_loc2_;
         setValueSelectionVisibility(_loc2_ && var_1310.selected);
      }
      
      private function setValueSelectionVisibility(param1:Boolean) : void
      {
         _section3.disabled = !param1;
         _section4.disabled = !param1;
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,0);
      }
      
      private function onSelectByValueChange(param1:int, param2:Boolean) : void
      {
         setValueSelectionVisibility(param2);
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _picker = param1.createVariablePicker(variableSelectionFilter1,onVariableSelected);
         _section1 = param1.createSection(l("variables.variable_selection"),_picker);
         var _loc4_:CheckboxGroupPreset = param1.createCheckboxGroup([new CheckboxOptionParam(l("variables.value_settings.select_by_value"))],onSelectByValueChange);
         var_1310 = _loc4_.method_20(0);
         _section2 = param1.createSection(l("choose_type"),var_1310);
         var_2903 = param1.createRadioGroup([new RadioButtonParam(2,">"),new RadioButtonParam(5,"≥"),new RadioButtonParam(1,"="),new RadioButtonParam(3,"≤"),new RadioButtonParam(0,"<"),new RadioButtonParam(4,"≠")],null,6);
         _section3 = param1.createSection(l("comparison_selection"),var_2903);
         _section4 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),l("variables.reference_value"),-2147483648,2147483647);
         param3.addElements(_section1,_section2,_section3,_section4);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         _section4.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return _section4.target;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [class_4050.GLOBAL_SOURCE,class_4050.CONTEXT_SOURCE];
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
   }
}

