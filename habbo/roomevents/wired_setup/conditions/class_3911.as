package com.sulake.habbo.roomevents.wired_setup.conditions
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SpacingPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3911 extends DefaultConditionType
   {
      
      private var _section1:SectionPreset;
      
      private var _picker:VariablePickerPreset;
      
      private var var_2946:RadioGroupPreset;
      
      private var var_1018:RadioGroupPreset;
      
      private var var_2710:NamedNumberInputPreset;
      
      private var var_2925:DropdownPreset;
      
      private var var_1252:int = 0;
      
      public function class_3911()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.canReadCreationTime || param1.canReadLastUpdateTime;
      }
      
      override public function get code() : int
      {
         return class_4100.VARIABLE_AGE;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1252);
         _loc1_.push(var_2946.selected);
         _loc1_.push(var_1018.selected);
         Util.pushIntAsLong(_loc1_,var_2710.value);
         _loc1_.push(var_2925.selectedId);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [_picker.finalizeSelection];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:Array = param1.intParams;
         var _loc5_:String = param1.variableIds[0];
         var_1252 = _loc3_[0];
         _picker.init(param1.wiredContext.roomVariablesList,_loc5_,var_1252);
         var _loc2_:int = int(_loc3_[1]);
         var _loc6_:int = int(_loc3_[2]);
         var _loc7_:int = int(_loc3_[4]);
         var _loc4_:int = int(_loc3_[5]);
         var_2946.selected = _loc2_;
         var_1018.selected = _loc6_;
         var_2710.value = _loc7_;
         var_2925.selectedId = _loc4_;
         updateAgeOptions(_picker.selected);
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(var_1252);
      }
      
      private function updateAgeOptions(param1:WiredVariable) : void
      {
         var_1018.setOptionDisabled(0,false);
         var_1018.setOptionDisabled(1,false);
         if(param1 == null)
         {
            return;
         }
         if(!param1.canReadCreationTime)
         {
            var_1018.setOptionDisabled(0,true);
            var_1018.selected = 1;
         }
         else if(!param1.canReadLastUpdateTime)
         {
            var_1018.setOptionDisabled(1,true);
            var_1018.selected = 0;
         }
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:SourceTypeSelectorParam = new SourceTypeSelectorParam(mergedSourceOptions(0),createSourceTypeListener(0));
         _picker = param1.createVariablePicker(variableSelectionFilter,updateAgeOptions);
         var _loc4_:SectionParam = new SectionParam(_loc6_);
         _section1 = param1.createSection(l("variables.variable_selection"),_picker,_loc4_);
         var_1018 = param1.createRadioGroup([new RadioButtonParam(0,l("variables.compare_value.0")),new RadioButtonParam(1,l("variables.compare_value.1"))]);
         var _loc8_:SectionPreset = param1.createSection(l("variables.compare_value"),var_1018);
         var_2946 = param1.createRadioGroup([new RadioButtonParam(0,l("comparison.0")),new RadioButtonParam(2,l("comparison.2"))]);
         var _loc9_:SectionPreset = param1.createSection(l("comparison_selection"),var_2946);
         var_2710 = param1.createNamedNumberInput(new NumberInputParam(0,-2147483648,2147483647),l("variables.duration"));
         var_2925 = param1.createDropdown(new DropdownParam("",Vector.<ExpandableDropdownOption>([new ExpandableDropdownOption(0,l("variables.duration.0")),new ExpandableDropdownOption(1,l("variables.duration.1")),new ExpandableDropdownOption(2,l("variables.duration.2")),new ExpandableDropdownOption(3,l("variables.duration.3")),new ExpandableDropdownOption(4,l("variables.duration.4")),new ExpandableDropdownOption(5,l("variables.duration.5")),new ExpandableDropdownOption(6,l("variables.duration.6")),new ExpandableDropdownOption(7,l("variables.duration.7"))])));
         var _loc5_:SpacingPreset = param1.createSpacing(false,5);
         var _loc7_:SimpleListViewPreset = param1.createSimpleListView(false,[var_2710,_loc5_,var_2925],true);
         var _loc10_:SectionPreset = param1.createSection(l("variables.time_selection"),_loc7_);
         param3.addElements(_section1,_loc8_,_loc9_,_loc10_);
      }
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.variables";
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         var_1252 = param2;
         _picker.variableTarget = var_1252;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_1252;
      }
      
      override public function getCustomSourcesForMergedType(param1:int) : Array
      {
         return [class_4050.GLOBAL_SOURCE,class_4050.CONTEXT_SOURCE];
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

