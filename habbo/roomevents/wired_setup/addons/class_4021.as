package com.sulake.habbo.roomevents.wired_setup.addons
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_2397;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.applications.SubVariableParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.SubVariableCreatorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_188.VariableList;
   import package_189.WiredVariable;
   
   public class class_4021 extends DefaultAddonType
   {
      
      private static var var_5140:int = 0;
      
      private static var TYPE_CREATION_TIME:int = 1;
      
      private static var TYPE_LAST_UPDATE_TIME:int = 2;
      
      private var _modeDropdown:DropdownPreset;
      
      private var _subVariableCreatorPreset:SubVariableCreatorPreset;
      
      private var _advancedSubVariableCreatorPreset:SubVariableCreatorPreset;
      
      public function class_4021()
      {
         super();
      }
      
      override public function get code() : int
      {
         return class_4074.VARIABLE_TIME_UTIL;
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         _modeDropdown = param1.createDropdown(new DropdownParam(l("choose_type"),Vector.<ExpandableDropdownOption>([new ExpandableDropdownOption(var_5140,l("time_util.mode.0")),new ExpandableDropdownOption(TYPE_CREATION_TIME,l("time_util.mode.1")),new ExpandableDropdownOption(TYPE_LAST_UPDATE_TIME,l("time_util.mode.2"))])));
         var _loc5_:SectionPreset = param1.createSection(l("choose_type"),_modeDropdown);
         var _loc4_:Array = [new SubVariableParam(1,"milliseconds_of_seconds"),new SubVariableParam(2,"seconds_of_minute"),new SubVariableParam(3,"minute_of_hour"),new SubVariableParam(4,"hour_of_day"),new SubVariableParam(5,"day_of_week"),new SubVariableParam(6,"day_of_month"),new SubVariableParam(7,"day_of_year"),new SubVariableParam(8,"week_of_year"),new SubVariableParam(9,"month_of_year"),new SubVariableParam(10,"year")];
         _subVariableCreatorPreset = param1.createSubVariableCreator("wiredfurni.params.time_util.subvariable.",_loc4_);
         var _loc7_:SectionPreset = param1.createSection(loc("wiredfurni.params.create_subvariables"),_subVariableCreatorPreset,SectionParam.var_2495);
         var _loc6_:Array = [new SubVariableParam(20,"millisecond"),new SubVariableParam(21,"second"),new SubVariableParam(22,"minute"),new SubVariableParam(23,"hour"),new SubVariableParam(24,"day"),new SubVariableParam(25,"week"),new SubVariableParam(26,"month")];
         _advancedSubVariableCreatorPreset = param1.createSubVariableCreator("wiredfurni.params.time_util.subvariable.",_loc6_);
         var _loc8_:SectionPreset = param1.createSection(l("create_subvariables.advanced"),param1.createSimpleListView(true,[param1.createText(l("time_util.advanced_info")),_advancedSubVariableCreatorPreset]),SectionParam.COLLAPSED);
         param3.addElements(_loc5_,_loc7_,_loc8_);
      }
      
      override public function onEditStart(param1:class_2397) : void
      {
         var _loc2_:int = param1.getInt(0);
         var _loc5_:int = param1.getInt(1);
         _subVariableCreatorPreset.mask = _loc2_ & 0xFFFF;
         _advancedSubVariableCreatorPreset.mask = _loc2_ & 0xFFFF0000;
         var _loc4_:VariableList = param1.wiredContext.rulesetVariables;
         var _loc3_:Vector.<ExpandableDropdownOption> = new Vector.<ExpandableDropdownOption>();
         if(showValue(_loc4_.variables,_loc5_))
         {
            _loc3_.push(new ExpandableDropdownOption(var_5140,l("time_util.mode.0")));
         }
         if(showCreationTime(_loc4_.variables,_loc5_))
         {
            _loc3_.push(new ExpandableDropdownOption(TYPE_CREATION_TIME,l("time_util.mode.1")));
         }
         if(showLastUpdateTime(_loc4_.variables,_loc5_))
         {
            _loc3_.push(new ExpandableDropdownOption(TYPE_LAST_UPDATE_TIME,l("time_util.mode.2")));
         }
         _modeDropdown.reinit(_loc3_,_loc5_);
      }
      
      public function showCreationTime(param1:Array, param2:int) : Boolean
      {
         if(param2 == TYPE_CREATION_TIME || param1.length == 0)
         {
            return true;
         }
         for each(var _loc3_ in param1)
         {
            if(_loc3_.canReadCreationTime)
            {
               return true;
            }
         }
         return false;
      }
      
      public function showLastUpdateTime(param1:Array, param2:int) : Boolean
      {
         if(param2 == TYPE_LAST_UPDATE_TIME || param1.length == 0)
         {
            return true;
         }
         for each(var _loc3_ in param1)
         {
            if(_loc3_.canReadLastUpdateTime)
            {
               return true;
            }
         }
         return false;
      }
      
      public function showValue(param1:Array, param2:int) : Boolean
      {
         if(param2 == var_5140 || param1.length == 0)
         {
            return true;
         }
         for each(var _loc3_ in param1)
         {
            if(_loc3_.hasValue)
            {
               return true;
            }
         }
         return false;
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(_subVariableCreatorPreset.mask | _advancedSubVariableCreatorPreset.mask);
         _loc1_.push(_modeDropdown.selectedId);
         return _loc1_;
      }
   }
}

