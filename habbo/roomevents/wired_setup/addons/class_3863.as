package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.PlaceholderTypeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariablePlaceholderModeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3863 extends DefaultAddonType
   {
      
      private var var_1414:PlaceholderNameSection;
      
      private var var_743:ChooseVariableSection;
      
      private var var_2081:VariablePlaceholderModeSection;
      
      private var var_1165:PlaceholderTypeSection;
      
      private var var_1516:WiredVariable;
      
      public function class_3863()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.hasValue;
      }
      
      public static function prettifiedName(param1:WiredVariable) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return Util.flatVariableName(param1);
      }
      
      override public function get code() : int
      {
         return class_4074.VARIABLE_PLACEHOLDER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_1414 = param1.createPlaceholderNameSection(l("texts.placeholder_name"),"$");
         var_743 = param1.createChooseVariableSection(0,mergedSourceOptions(0),variableSelectionFilter,onChangeVariable);
         var_2081 = param1.createVariablePlaceholderModeSection(l("texts.variable_display_type"));
         var_1165 = param1.createPlaceholderTypeSection();
         param3.addElements(var_1414,var_743,var_2081,var_1165);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:Array = param1.stringParam.split("\t");
         var _loc5_:String = _loc3_[0];
         var _loc4_:String = _loc3_.length > 1 ? _loc3_[1] : "";
         var _loc7_:String = param1.variableIds[0];
         var _loc8_:Boolean = param1.getBoolean(0);
         var _loc2_:int = param1.getInt(1);
         var _loc6_:Boolean = param1.getBoolean(2);
         var_2081.isTextMode = _loc6_;
         var_1414.placeholderName = _loc5_;
         var_1165.isShowMultiple = _loc8_;
         var_1165.delimiter = _loc4_;
         var_743.init(param1.wiredContext.roomVariablesList,_loc7_,_loc2_);
         var_1516 = var_743.selected;
         onChangeVariable(var_743.selected);
         updateMultipleOptionVisibility();
      }
      
      override public function onEditInitialized() : void
      {
         var_743.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_1165.isShowMultiple ? 1 : 0,var_743.target,var_2081.isTextMode ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         if(!var_1165.isShowMultiple)
         {
            return var_1414.placeholderName;
         }
         return var_1414.placeholderName + "\t" + var_1165.delimiter;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_743.finalizeSelection];
      }
      
      private function onChangeVariable(param1:WiredVariable) : void
      {
         var _loc2_:Boolean = param1 == null || !param1.hasTextConnector;
         var_2081.method_20(1).disabled = _loc2_;
         if(_loc2_)
         {
            var_2081.isTextMode = false;
         }
         if(var_1414.placeholderName == "" || var_1516 != null && prettifiedName(var_1516) == var_1414.placeholderName)
         {
            var_1414.placeholderName = prettifiedName(param1);
         }
         var_1516 = param1;
      }
      
      private function updateMultipleOptionVisibility() : void
      {
         var _loc1_:Boolean = var_743.target == class_4050.CONTEXT_SOURCE || var_743.target == class_4050.GLOBAL_SOURCE;
         var_1165.method_20(1).disabled = _loc1_;
         if(_loc1_)
         {
            var_1165.isShowMultiple = false;
         }
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
         var_743.target = param2;
         updateMultipleOptionVisibility();
      }
      
      override public function getMergedType(param1:int) : int
      {
         return var_743.target;
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
      
      override public function hasCustomTypePicker(param1:int) : Boolean
      {
         return true;
      }
   }
}

