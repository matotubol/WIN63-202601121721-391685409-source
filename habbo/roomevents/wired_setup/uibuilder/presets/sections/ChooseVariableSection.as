package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.sections
{
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.class_2677;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SectionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.SourceTypeSelectorParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SourceTypeSelectorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.VariablePickerPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_188.class_3414;
   import package_189.WiredVariable;
   
   public class ChooseVariableSection extends AbstractSectionPreset implements class_2677
   {
      
      private var _picker:VariablePickerPreset;
      
      private var var_3579:int;
      
      private var var_1252:int;
      
      public function ChooseVariableSection(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int, param5:Array, param6:Function, param7:Function, param8:String = null)
      {
         super(param1,param2,param3);
         var_3579 = param4;
         var _loc9_:SectionParam = null;
         if(param5 != null)
         {
            _loc9_ = new SectionParam(new SourceTypeSelectorParam(param5,this));
         }
         _picker = param2.createVariablePicker(param6,param7);
         initializeSection(param8 == null ? l("variables.variable_selection") : param8,_picker,_loc9_);
      }
      
      public function init(param1:class_3414, param2:String, param3:int) : void
      {
         _picker.init(param1,param2,param3);
         var_1252 = param3;
      }
      
      public function onEditInitialized() : void
      {
         var _loc1_:SourceTypeSelectorPreset = var_785.getSourceTypeSelector();
         if(_loc1_ != null)
         {
            _loc1_.select(var_1252);
         }
      }
      
      public function set target(param1:int) : void
      {
         var_1252 = param1;
         _picker.variableTarget = var_1252;
      }
      
      public function get target() : int
      {
         return var_1252;
      }
      
      public function get finalizeSelection() : String
      {
         return _picker.finalizeSelection;
      }
      
      public function get selected() : WiredVariable
      {
         return _picker.selected;
      }
      
      public function set sourceType(param1:int) : void
      {
         if(var_3579 != -1)
         {
            _roomEvents.wiredCtrl.setMergedSourceType(var_3579,param1);
         }
         else
         {
            target = param1;
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _picker = null;
      }
   }
}

