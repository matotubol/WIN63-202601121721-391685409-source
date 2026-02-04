package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.NewVariablePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import package_188.class_3414;
   import package_189.WiredVariable;
   
   public class VariablePickerPreset extends WiredUIPreset
   {
      
      private var _picker:NewVariablePicker;
      
      public function VariablePickerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function = null, param5:Function = null)
      {
         super(param1,param2,param3);
         _picker = new NewVariablePicker(param1,param2.createLayout("search_tree_dropdown") as class_1812,param4,param5);
      }
      
      public function init(param1:class_3414, param2:String, param3:int) : void
      {
         _picker.init(param1,param2,param3);
      }
      
      public function set variableTarget(param1:int) : void
      {
         _picker.variableTarget = param1;
      }
      
      public function get selected() : WiredVariable
      {
         return _picker.selected;
      }
      
      public function get finalizeSelection() : String
      {
         var _loc1_:WiredVariable = selected;
         _picker.finalize();
         return _loc1_?.variableId;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _picker.width = param1;
      }
      
      override public function get window() : class_1741
      {
         return _picker.window;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _picker.dispose();
         _picker = null;
      }
   }
}

