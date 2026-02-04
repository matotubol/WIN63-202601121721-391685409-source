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
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariablePlaceholderModeSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   
   public class class_3739 extends DefaultAddonType
   {
      
      private var var_1414:PlaceholderNameSection;
      
      private var var_743:ChooseVariableSection;
      
      private var var_2081:VariablePlaceholderModeSection;
      
      private var var_1516:WiredVariable;
      
      public function class_3739()
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
         return class_4074.VARIABLE_CAPTURER;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var_1414 = param1.createPlaceholderNameSection(l("texts.capturer_name"),"#");
         var_743 = param1.createChooseVariableSection(0,null,variableSelectionFilter,onChangeVariable);
         var_2081 = param1.createVariablePlaceholderModeSection(l("texts.variable_input_type"));
         param3.addElements(var_1414,var_743,var_2081);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:Array = param1.stringParam.split("\t");
         var _loc3_:String = _loc2_[0];
         var _loc5_:String = param1.variableIds[0];
         var _loc4_:Boolean = param1.getBoolean(0);
         var_2081.isTextMode = _loc4_;
         var_1414.placeholderName = _loc3_;
         var_743.init(param1.wiredContext.roomVariablesList,_loc5_,class_4050.CONTEXT_SOURCE);
         var_1516 = var_743.selected;
         onChangeVariable(var_743.selected);
      }
      
      override public function onEditInitialized() : void
      {
         var_743.onEditInitialized();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_2081.isTextMode ? 1 : 0];
      }
      
      override public function readStringParamFromForm() : String
      {
         return var_1414.placeholderName;
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
   }
}

