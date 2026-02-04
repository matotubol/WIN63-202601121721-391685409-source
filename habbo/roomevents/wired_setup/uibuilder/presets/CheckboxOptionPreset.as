package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.CheckboxOptionParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CheckboxOptionPreset extends WiredUIPreset
   {
      
      private var _container:class_1812;
      
      private var var_1059:IItemListWindow;
      
      private var var_926:IItemListWindow;
      
      private var _checkbox:class_1885;
      
      private var _textPreset:TextPreset;
      
      private var _extra1:WiredUIPreset;
      
      private var _extra2:WiredUIPreset;
      
      public function CheckboxOptionPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:CheckboxOptionParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as class_1812;
         var_1059 = param2.createLayout("vertical_list_view") as IItemListWindow;
         var_926 = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _checkbox = param3.createCheckboxView();
         _checkbox.id = param4.id;
         _textPreset = param2.createText(param4.text,new TextParam(param4.extra1 != null ? 0 : 1));
         _textPreset.window.y = param3.checkboxYOffset;
         var_926.addListItem(_checkbox);
         var_926.addListItem(_textPreset.window);
         var_926.spacing = param3.checkboxSpacing;
         if(param4.extra1 != null)
         {
            _extra1 = param4.extra1;
            var_926.addListItem(_extra1.window);
         }
         var_1059.addListItem(var_926);
         var_1059.spacing = param3.optionExtraUnderSpacing;
         if(param4.extra2 != null)
         {
            _extra2 = param4.extra2;
            var_1059.addListItem(_extra2.window);
            _extra2.window.x = param3.optionExtraUnderLeftMargin;
         }
         if(_extra1 != null || _extra2 != null)
         {
            _checkbox.addEventListener("WE_SELECTED",onSelect);
            _checkbox.addEventListener("WE_UNSELECTED",onUnSelect);
            onUnSelect(null);
         }
         _container.addChild(var_1059);
      }
      
      private function onSelect(param1:class_1758) : void
      {
         if(_extra1 != null)
         {
            _extra1.disabled = false;
         }
         if(_extra2 != null)
         {
            _extra2.disabled = false;
         }
      }
      
      private function onUnSelect(param1:class_1758) : void
      {
         if(_extra1 != null)
         {
            _extra1.disabled = true;
         }
         if(_extra2 != null)
         {
            _extra2.disabled = true;
         }
      }
      
      override public function set disabled(param1:Boolean) : void
      {
         super.disabled = param1;
         if(!param1 && !selected)
         {
            onUnSelect(null);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         Util.select(_checkbox,param1);
      }
      
      public function get selected() : Boolean
      {
         return _checkbox.isSelected;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _container.width = param1;
         var_1059.width = param1;
         var_926.width = param1;
         if(!_textPreset.canStretch && _extra1 != null)
         {
            throw new Error("Illegal UI combination: could not determine width of text");
         }
         if(_extra1 == null)
         {
            _textPreset.resizeToWidth(param1 - _textPreset.window.x);
         }
         else
         {
            _textPreset.resizeToWidth(_textPreset.width);
            _extra1.resizeToWidth(param1 - _extra1.window.x);
         }
         if(_extra2 != null)
         {
            _extra2.resizeToWidth(param1 - _extra2.window.x);
         }
         var_926.height = Math.max(_textPreset.window.height,_extra1 == null ? 0 : _extra1.window.height,_checkbox.height);
         _container.height = Math.max(var_1059.height + var_64.minimumOptionSpacing,var_64.minimumOptionHeight);
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      public function get checkbox() : class_1885
      {
         return _checkbox;
      }
      
      override protected function get childPresets() : Array
      {
         var _loc1_:Array = [_textPreset];
         if(_extra1 != null)
         {
            _loc1_.push(_extra1);
         }
         if(_extra2 != null)
         {
            _loc1_.push(_extra2);
         }
         return _loc1_;
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
         var_1059 = null;
         var_926 = null;
         _textPreset = null;
         _checkbox = null;
         _extra1 = null;
         _extra2 = null;
      }
   }
}

