package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3768 extends DefaultActionType
   {
      
      private var _picker:VariablePickerPreset;
      
      private var var_1921:DropdownPreset;
      
      private var _section1:SectionPreset;
      
      private var _section2:SectionPreset;
      
      private var _section3:ValueOrVariableSection;
      
      private var var_1252:int = 0;
      
      public function class_3768()
      {
         super();
      }
      
      private static function operatorOptions(param1:class_27) : Vector.<ExpandableDropdownOption>
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _loc3_.push(new ExpandableDropdownOption(_loc4_,param1.getLocalization("wiredfurni.params.variables.operation." + _loc4_),false));
            _loc4_++;
         }
         _loc3_.push(new ExpandableDropdownOption(40,param1.getLocalization("wiredfurni.params.variables.operation.40"),true));
         _loc3_.push(new ExpandableDropdownOption(41,param1.getLocalization("wiredfurni.params.variables.operation.41"),true));
         _loc3_.push(new ExpandableDropdownOption(50,param1.getLocalization("wiredfurni.params.variables.operation.50"),true));
         _loc3_.push(new ExpandableDropdownOption(60,param1.getLocalization("wiredfurni.params.variables.operation.60"),true));
         _loc2_ = 100;
         while(_loc2_ < 106)
         {
            _loc3_.push(new ExpandableDropdownOption(_loc2_,param1.getLocalization("wiredfurni.params.variables.operation." + _loc2_),true));
            _loc2_++;
         }
         return _loc3_;
      }
      
      private static function variableSelectionFilter1(param1:WiredVariable) : Boolean
      {
         return param1.canWriteValue;
      }
      
      override public function get code() : int
      {
         return class_4061.CHANGE_VARIABLE;
      }
      
      public function requiresOperand() : Boolean
      {
         return var_1921.selectedId != 103 && var_1921.selectedId != 60;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(var_1252);
         _loc1_.push(var_1921.selectedId);
         _loc1_.push(requiresOperand() ? _section3.option : 0);
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
         var _loc3_:Array = param1.intParams;
         var _loc5_:String = param1.variableIds[0];
         var _loc2_:String = param1.variableIds[1];
         var_1252 = _loc3_[0];
         var _loc6_:int = int(_loc3_[1]);
         var _loc4_:int = int(_loc3_[2]);
         var _loc7_:int = int(_loc3_[4]);
         var _loc8_:int = int(_loc3_[5]);
         _picker.init(param1.wiredContext.roomVariablesList,_loc5_,var_1252);
         if(_loc4_ == 0)
         {
            _loc2_ = WiredVariable.var_636;
         }
         else
         {
            _loc7_ = 0;
         }
         _section3.init(param1.wiredContext.roomVariablesList,_loc2_,_loc8_,_loc4_,_loc7_);
         var_1921.selectedId = _loc6_;
      }
      
      override public function onEditInitialized() : void
      {
         _section1.getSourceTypeSelector().select(var_1252);
         _section3.onEditInitialized();
      }
      
      public function onChangeOperator(param1:ExpandableDropdownOption) : void
      {
         var _loc2_:* = !requiresOperand();
         _section3.disabled = _loc2_;
         roomEvents.wiredCtrl.updateSourceContainer(WiredInputSourcePicker.MERGED_SOURCE,1);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE && param1 == 1)
         {
            return _section3.isSourcePickingDisabled() || !requiresOperand();
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
         var_1921 = param1.createDropdown(new DropdownParam(l("variables.operation.tooltip"),operatorOptions(roomEvents.localization),onChangeOperator,l("variables.operation.advanced")));
         _section2 = param1.createSection(l("variables.operation"),var_1921);
         _section3 = param1.createValueOrVariableSection(1,mergedSourceOptions(1),l("variables.reference_value"),-2147483648,2147483647);
         param3.addElements(_section1,_section2,_section3);
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         if(param1 == 0)
         {
            return "wiredfurni.params.sources.merged.title.variables_destination";
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

