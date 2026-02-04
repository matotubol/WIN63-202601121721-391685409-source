package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.views
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.MenuPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.menu.elements.MenuItem;
   
   public class MenuItemView implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var _window:IRegionWindow;
      
      private var _preset:MenuPreset;
      
      private var var_391:MenuItem;
      
      private var var_1919:Boolean = false;
      
      private var var_3198:Boolean = false;
      
      private var var_2482:Boolean = false;
      
      private var _ignoreEvents:Boolean = false;
      
      public function MenuItemView(param1:MenuPreset, param2:MenuItem)
      {
         super();
         _preset = param1;
         var_391 = param2;
         _window = param1.menuItemTemplate.clone() as IRegionWindow;
         textWindow.text = param2.name;
         checkboxWindow.visible = param2.hasCheckbox;
         if(param2.tooltip != null && param2.tooltip.length > 0)
         {
            _window.toolTipCaption = param2.tooltip;
         }
         _window.addEventListener("WME_OVER",onHover);
         _window.addEventListener("WME_OUT",onHoverEnd);
         _window.addEventListener("WME_CLICK",onClick);
         checkboxWindow.addEventListener("WME_OVER",onCheckboxHover);
         checkboxWindow.addEventListener("WME_OUT",onCheckboxHoverEnd);
         checkboxWindow.addEventListener("WE_SELECTED",onSelectedChange);
         checkboxWindow.addEventListener("WE_UNSELECTED",onSelectedChange);
         updateUI();
      }
      
      private function onSelectedChange(param1:class_1758) : void
      {
         if(_ignoreEvents)
         {
            return;
         }
         if(var_391.selectedChange != null)
         {
            var_391.selectedChange(checkboxWindow.isSelected);
         }
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         if(var_2482)
         {
            return;
         }
         if(var_391.hasCheckbox)
         {
            selected = !selected;
         }
         if(var_391.onClick != null)
         {
            var_391.onClick();
         }
         if(!var_391.hasCheckbox)
         {
            _preset.requestClose();
         }
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         var_1919 = false;
         updateUI();
      }
      
      private function onHover(param1:WindowMouseEvent) : void
      {
         var_1919 = true;
         updateUI();
      }
      
      private function onCheckboxHoverEnd(param1:WindowMouseEvent) : void
      {
         var_3198 = false;
         updateUI();
      }
      
      private function onCheckboxHover(param1:WindowMouseEvent) : void
      {
         var_3198 = true;
         updateUI();
      }
      
      private function updateUI() : void
      {
         _window.background = (var_1919 || var_3198) && !var_2482;
         Util.disableSection(_window,var_2482);
      }
      
      public function get selected() : Boolean
      {
         if(var_391.hasCheckbox)
         {
            return checkboxWindow.isSelected;
         }
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _ignoreEvents = true;
         if(var_391.hasCheckbox)
         {
            if(param1)
            {
               checkboxWindow.select();
            }
            else
            {
               checkboxWindow.unselect();
            }
            if(var_391.selectedChange != null)
            {
               var_391.selectedChange(checkboxWindow.isSelected);
            }
            if(var_391.onClick != null)
            {
               var_391.onClick();
            }
         }
         _ignoreEvents = false;
      }
      
      public function get disabled() : Boolean
      {
         return var_2482;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         var_2482 = param1;
         updateUI();
      }
      
      public function get requestedMinWidth() : int
      {
         return textWindow.x + textWindow.width;
      }
      
      public function get menuItem() : MenuItem
      {
         return var_391;
      }
      
      public function get window() : IRegionWindow
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _window = null;
         _preset = null;
         var_391 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get textWindow() : ITextWindow
      {
         return _window.findChildByName("text") as ITextWindow;
      }
      
      private function get checkboxWindow() : class_1885
      {
         return _window.findChildByName("checkbox") as class_1885;
      }
   }
}

