package com.sulake.habbo.roomevents.wired_setup.variables
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.class_4050;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.ChooseVariableSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections.VariableNameSection;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_189.WiredVariable;
   import package_189.class_4013;
   
   public class class_3682 extends class_3681
   {
      
      private var _variableName:VariableNameSection;
      
      private var var_743:ChooseVariableSection;
      
      private var var_1516:WiredVariable;
      
      public function class_3682()
      {
         super();
      }
      
      private static function variableSelectionFilter(param1:WiredVariable) : Boolean
      {
         return param1.variableType != class_4013.var_5288;
      }
      
      override public function get code() : int
      {
         return class_4086.ECHO_VARIABLE;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _variableName = param1.createVariableNameSection();
         var_743 = param1.createChooseVariableSection(-1,[WiredInputSourcePicker.var_128,WiredInputSourcePicker.USER_SOURCE,class_4050.GLOBAL_SOURCE,class_4050.CONTEXT_SOURCE],variableSelectionFilter,onVariableSelected);
         param3.addElements(_variableName,var_743);
      }
      
      override public function readStringParamFromForm() : String
      {
         return _variableName.variableName;
      }
      
      override public function readVariableIdsFromForm() : Array
      {
         return [var_743.finalizeSelection];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc3_:String = param1.variableIds[0];
         var _loc4_:int = WiredInputSourcePicker.USER_SOURCE;
         var _loc2_:WiredVariable = Util.findVariableById(param1.wiredContext.roomVariablesList.variables,_loc3_);
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.variableTarget;
         }
         var_743.init(param1.wiredContext.roomVariablesList,_loc3_,_loc4_);
         var_1516 = var_743.selected;
         initialVariableName = param1.stringParam;
      }
      
      override public function onEditInitialized() : void
      {
         var_743.onEditInitialized();
      }
      
      private function onVariableSelected(param1:WiredVariable) : void
      {
         if(_variableName.variableName.length == 0 || var_1516 != null && defaultEchoVarName(var_1516) == _variableName.variableName)
         {
            _variableName.variableName = param1 == null ? "" : defaultEchoVarName(param1);
         }
         var_1516 = param1;
      }
      
      private function defaultEchoVarName(param1:WiredVariable) : String
      {
         return Util.flatVariableName(param1);
      }
      
      override protected function get variableNameSection() : VariableNameSection
      {
         return _variableName;
      }
      
      override public function variableType() : int
      {
         return var_743.target;
      }
   }
}

