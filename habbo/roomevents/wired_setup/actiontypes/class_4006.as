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
   
   public class class_4006 extends DefaultActionType
   {
      
      private var var_3747:CheckboxGroupPreset;
      
      public function class_4006()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4061.var_5358;
      }
      
      override public function get hasStateSnapshot() : Boolean
      {
         return true;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc6_:Array = [new CheckboxOptionParam(loc("wiredfurni.params.condition.state")),new CheckboxOptionParam(loc("wiredfurni.params.condition.direction")),new CheckboxOptionParam(loc("wiredfurni.params.condition.position")),new CheckboxOptionParam(loc("wiredfurni.params.condition.altitude"))];
         var _loc4_:CheckboxGroupPreset = param1.createCheckboxGroup(_loc6_);
         var _loc5_:SectionPreset = param1.createSection(loc("wiredfurni.params.conditions"),_loc4_);
         param3.addElements(_loc5_);
         var_3747 = _loc4_;
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            var_3747.method_20(_loc2_).selected = param1.getBoolean(_loc2_);
            _loc2_ += 1;
         }
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_.push(var_3747.method_20(_loc2_).selected ? 1 : 0);
            _loc2_ += 1;
         }
         return _loc1_;
      }
   }
}

