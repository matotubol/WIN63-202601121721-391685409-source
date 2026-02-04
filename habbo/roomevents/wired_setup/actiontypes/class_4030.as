package com.sulake.habbo.roomevents.wired_setup.actiontypes
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.CheckboxGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class class_4030 extends DefaultActionType
   {
      
      private var var_3654:CheckboxGroupPreset;
      
      public function class_4030()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.var_5340;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:Array = [new CheckboxOptionParam(loc("wiredfurni.params.teleport.options.0"))];
         var _loc4_:CheckboxGroupPreset = param1.createCheckboxGroup(_loc6_);
         var _loc5_:SectionPreset = param1.createSection(loc("wiredfurni.params.teleport.options"),_loc4_);
         param3.addElements(_loc5_);
         var_3654 = _loc4_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var_3654.method_20(0).selected = param1.getBoolean(0);
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [var_3654.method_20(0).selected ? 1 : 0];
      }
   }
}

