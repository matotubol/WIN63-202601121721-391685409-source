package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdown;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class DropdownPreset extends WiredUIPreset
   {
      
      private var _container:class_2261;
      
      private var var_55:ExpandableDropdown;
      
      public function DropdownPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:DropdownParam)
      {
         super(param1,param2,param3);
         _container = param3.createDropdown();
         _container.caption = param4.caption;
         var_55 = new ExpandableDropdown(_container,param4.showMoreLocalization,param4.onChangeCallback);
         var_55.init(param4.options == null ? Vector.<ExpandableDropdownOption>([]) : param4.options,-1);
      }
      
      public function get selectedId() : int
      {
         return var_55.selectedOptionId;
      }
      
      public function get selected() : ExpandableDropdownOption
      {
         return var_55.selectedOption;
      }
      
      public function set selectedId(param1:int) : void
      {
         var_55.selectedOptionId = param1;
      }
      
      public function reinit(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         var_55.init(param1,param2);
      }
      
      public function reset() : void
      {
         reinit(Vector.<ExpandableDropdownOption>([]),-1);
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _container.dispose();
         _container = null;
         var_55.dispose();
      }
   }
}

