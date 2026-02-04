package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.main_layout
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextualButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AdvancedSettingsWrapperPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var _button:TextualButtonPreset = null;
      
      private var var_1390:WiredUIPreset = null;
      
      private var _subsectionsPreset:SimpleListViewPreset;
      
      private var _isExpanded:Boolean = false;
      
      private var _alwaysExpanded:Boolean = false;
      
      public function AdvancedSettingsWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array, param5:Boolean)
      {
         super(param1,param2,param3);
         _alwaysExpanded = param5;
         _container = param2.createLayout("vertical_list_view") as IItemListWindow;
         _container.spacing = param3.sectionSpacing;
         _subsectionsPreset = var_182.createSimpleListView(true,param4);
         _subsectionsPreset.spacing = param3.sectionSpacing;
         _subsectionsPreset.backgroundColor = param3.advancedBackgroundColor;
         blendingBackgroundColor = param3.backgroundColor;
         if(!param5)
         {
            _button = var_182.createTextualButtonPreset("${wiredfurni.params.sources.expand}",expandOrCollapse);
            var_1390 = _button.alignCenter();
            _container.addListItem(_button.window);
         }
         else
         {
            expanded = true;
         }
      }
      
      public function set expanded(param1:Boolean) : void
      {
         if(_isExpanded != param1 && !(_alwaysExpanded && _isExpanded))
         {
            expandOrCollapse();
         }
      }
      
      private function expandOrCollapse() : void
      {
         if(_isExpanded)
         {
            _container.removeListItem(_subsectionsPreset.window);
            _isExpanded = false;
            blendingBackgroundColor = var_64.backgroundColor;
         }
         else
         {
            _container.addListItem(_subsectionsPreset.window);
            _isExpanded = true;
            blendingBackgroundColor = var_64.advancedBackgroundColor;
         }
         if(_button != null)
         {
            _button.text = _isExpanded ? "${wiredfurni.params.sources.collapse}" : "${wiredfurni.params.sources.expand}";
            var_1390.resizeToWidth(_container.width);
         }
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         if(var_1390 != null)
         {
            var_1390.resizeToWidth(param1);
         }
         _subsectionsPreset.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         if(var_1390 == null)
         {
            return [_subsectionsPreset];
         }
         return [var_1390,_subsectionsPreset];
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
         _button = null;
         var_1390 = null;
         _subsectionsPreset = null;
      }
   }
}

