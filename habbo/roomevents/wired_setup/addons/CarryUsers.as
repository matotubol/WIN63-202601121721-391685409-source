package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.RadioButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.RadioGroupPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CarryUsers extends DefaultAddonType
   {
      
      private var carryUsersMode:RadioGroupPreset;
      
      public function CarryUsers()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.CARRY_USERS;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var _loc4_:Array = [new RadioButtonParam(0,loc("wiredfurni.params.carry_mode.0")),new RadioButtonParam(1,loc("wiredfurni.params.carry_mode.1"))];
         var _loc5_:RadioGroupPreset = param1.createRadioGroup(_loc4_);
         var _loc6_:SectionPreset = param1.createSection(loc("wiredfurni.params.carry_mode"),_loc5_);
         param3.addElements(_loc6_);
         carryUsersMode = _loc5_;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         return [carryUsersMode.selected];
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         carryUsersMode.selected = param1.intParams[0];
      }
      
      override public function userSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.users.title.carry";
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
   }
}

