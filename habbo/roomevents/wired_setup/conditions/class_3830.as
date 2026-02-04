package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3830 extends DefaultConditionType
   {
      
      private var _picker:VariablePickerPreset;
      
      private var var_2903:RadioGroupPreset;
      
      private var _section1:SectionPreset;
      
      private var _section2:SectionPreset;
      
      private var _section3:ValueOrVariableSection;
      
      private var var_1252:int = 0;
      
      public function class_3830()
      {
         super();
      }
      
      private static function variableSelectionFilter1(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      override public function get code() : int
      {
         return class_4100.VARIABLE_VALUE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1252);
         _loc1_.push(var_2903.selected);
         _loc1_.push(_section3.option);
         Util.pushIntAsLong(_loc1_,_section3.numberValue);
         _loc1_.push(_section3.target);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection,_section3.finalizeSelection];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:Array = param1.intParams;
         var _loc6_:String = param1.variableIds[0];
         var _loc2_:String = param1.variableIds[1];
         var_1252 = _loc4_[0];
         var _loc3_:int = int(_loc4_[1]);
         var _loc5_:int = int(_loc4_[2]);
         var _loc7_:int = int(_loc4_[4]);
         var _loc8_:int = int(_loc4_[5]);
         _picker.init(param1.wiredContext.roomVariablesList,_loc6_,var_1252);
         var_2903.selected = _loc3_;
         if(_loc5_ == 0)
         {
            _loc2_ = WiredVariable.var_636;
         }
         else
         {
            _loc7_ = 0;
         }
         _section3.init(param1.wiredContext.roomVariablesList,_loc2_,_loc8_,_loc5_,_loc7_);
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(var_1252);
         _section3.onEditInitialized();
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 1)
         {
            return _section3.isSourcePickingDisabled();
         }
         return false;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:SourceTypeSelectorParam = new SourceTypeSelectorParam(mergedSourceOptions(0),createSourceTypeListener(0));
         _picker = param1.createVariablePicker(variableSelectionFilter1);
         _section1 = param1.createSection(l("variables.variable_selection"),_picker,new SectionParam(_loc4_));
         var_2903 = param1.createRadioGroup([new RadioButtonParam(2,">"),new RadioButtonParam(5,"≥"),new RadioButtonParam(1,"="),new RadioButtonParam(3,"≤"),new RadioButtonParam(0,"<"),new RadioButtonParam(4,"≠")],null,6);
         _section2 = param1.createSection(l("comparison_selection"),var_2903);
         _section3 = param1.createValueOrVariableSection(1,mergedSourceOptions(1),l("variables.reference_value"),-2147483648,2147483647);
         param3.addElements(_section1,_section2,_section3);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.variables";
         }
         return "wiredfurni.params.sources.merged.title.variables_reference";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0],[1,1]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         if(param1 == 0)
         {
            var_1252 = param2;
            _picker.variableTarget = var_1252;
         }
         else
         {
            _section3.target = param2;
         }
      }
      
      override public function getMergedType(param1:int) : int
      {
         if(param1 == 0)
         {
            return var_1252;
         }
         return _section3.target;
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

