package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.common.advanced_dropdown.ExpandableDropdownOption;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.DropdownParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.DropdownPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NamedDropdownPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var _textPreset:TextPreset;
      
      private var _dropdownPreset:DropdownPreset;
      
      public function NamedDropdownPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:DropdownParam, param5:String, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _textPreset = param2.createText(param5,new TextParam(0,param6));
         _dropdownPreset = param2.createDropdown(param4);
         _container.spacing = param3.genericHorizontalSpacing;
         _container.addListItem(_textPreset.window);
         _container.addListItem(_dropdownPreset.window);
         _container.height = Math.max(_textPreset.window.height,_dropdownPreset.window.height);
      }
      
      public function get selectedId() : int
      {
         return _dropdownPreset.selectedId;
      }
      
      public function set selectedId(param1:int) : void
      {
         _dropdownPreset.selectedId = param1;
      }
      
      public function get selected() : ExpandableDropdownOption
      {
         return _dropdownPreset.selected;
      }
      
      public function reinit(param1:Vector.<ExpandableDropdownOption>, param2:int) : void
      {
         _dropdownPreset.reinit(param1,param2);
      }
      
      public function reset() : void
      {
         _dropdownPreset.reset();
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _dropdownPreset.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         if(hasStaticWidth())
         {
            return _container.width;
         }
         throw new Exception("Text input has no static width");
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _textPreset.resizeToWidth(_textPreset.width);
         _dropdownPreset.resizeToWidth(param1 - _dropdownPreset.window.x);
      }
      
      override protected function get childPresets() : Array
      {
         return [_textPreset,_dropdownPreset];
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
         _textPreset = null;
         _dropdownPreset = null;
      }
   }
}

