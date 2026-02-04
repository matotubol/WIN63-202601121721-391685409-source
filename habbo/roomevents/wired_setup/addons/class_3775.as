package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ValueOrVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3775 extends DefaultAddonType
   {
      
      private var _section1:SectionPreset;
      
      private var var_2444:VariablePickerPreset;
      
      private var _section2:SectionPreset;
      
      private var var_2204:DropdownPreset;
      
      private var _section3:ValueOrVariableSection;
      
      public function class_3775()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue || param1.canReadCreationTime || param1.canReadLastUpdateTime;
      }
      
      protected function get variableType() : int
      {
         return -1;
      }
      
      override public function get isFilter() : Boolean
      {
         return true;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_section3.numberValue);
         _loc1_.push(var_2204.selectedId);
         _loc1_.push(_section3.option);
         _loc1_.push(_section3.target);
         return _loc1_;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_2444.finalizeSelection,_section3.finalizeSelection];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc4_:Array = param1.intParams;
         var _loc7_:String = param1.variableIds[0];
         var _loc5_:String = param1.variableIds[1];
         var _loc3_:int = int(_loc4_[0]);
         var _loc2_:int = int(_loc4_[1]);
         var _loc8_:int = int(_loc4_[2]);
         var _loc6_:int = int(_loc4_[3]);
         var_2444.init(param1.wiredContext.roomVariablesList,_loc7_,variableType);
         if(_loc8_ == 0)
         {
            _loc5_ = WiredVariable.var_636;
         }
         else
         {
            _loc3_ = 1;
         }
         _section3.init(param1.wiredContext.roomVariablesList,_loc5_,_loc6_,_loc8_,_loc3_);
         initSortingDropdown(var_2444.selected,_loc2_);
      }
      
      override public function onEditInitialized() : void
      {
         _section3.onEditInitialized();
      }
      
      private function initSortingDropdown(param1:WiredVariable, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            param2 = var_2204.selectedId;
         }
         var _loc4_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         if(param1 == null || param1.hasValue)
         {
            _loc4_.push(new ExpandableDropdownOption(0,l("variables.sort_by." + "0")));
            _loc4_.push(new ExpandableDropdownOption(1,l("variables.sort_by." + "1")));
         }
         if(param1 == null || param1.canReadCreationTime)
         {
            _loc4_.push(new ExpandableDropdownOption(2,l("variables.sort_by." + "2")));
            _loc4_.push(new ExpandableDropdownOption(3,l("variables.sort_by." + "3")));
         }
         if(param1 == null || param1.canReadLastUpdateTime)
         {
            _loc4_.push(new ExpandableDropdownOption(4,l("variables.sort_by." + "4")));
            _loc4_.push(new ExpandableDropdownOption(5,l("variables.sort_by." + "5")));
         }
         var_2204.reinit(_loc4_,param2);
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_2444 = param1.createVariablePicker(variableSelectionFilter,initSortingDropdown);
         _section1 = param1.createSection(loc("wiredfurni.params.variables.variable_selection"),var_2444);
         var_2204 = param1.createDropdown(new DropdownParam(l("variables.sort_by.caption"),Vector.<ExpandableDropdownOption>([])));
         _section2 = param1.createSection(l("variables.sort_by"),var_2204);
         _section3 = param1.createValueOrVariableSection(0,mergedSourceOptions(0),l("setfilter"),1,1000);
         param3.addElements(_section1,_section2,_section3);
      }
      
      override public function isInputSourceDisabled(param1:int, param2:int) : Boolean
      {
         if(param2 == WiredInputSourcePicker.MERGED_SOURCE)
         {
            return _section3.isSourcePickingDisabled();
         }
         return false;
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
         _section3.target = param2;
      }
      
      override public function getMergedType(param1:int) : int
      {
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

