package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.tabbuttons
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.newvariablepicker.ExpandedVariablePickerView;
   
   public class TabButtonView implements class_13
   {
      
      private static var SELECTED_BG:uint = 14737632;
      
      private static var var_5363:uint = 4289374890;
      
      private static var HOVER_BG:uint = 15724527;
      
      private static var var_5349:uint = 4291611852;
      
      private static var NONE_BG:uint = 16448250;
      
      private static var NONE_SHADOW:uint = 4292730333;
      
      private var _parent:ExpandedVariablePickerView;
      
      private var _window:IRegionWindow;
      
      private var _tabConfig:TabButtonConfig;
      
      private var _disposed:Boolean = false;
      
      private var _active:Boolean = false;
      
      private var var_1919:Boolean = false;
      
      public function TabButtonView(param1:ExpandedVariablePickerView, param2:TabButtonConfig, param3:int)
      {
         super();
         _parent = param1;
         _tabConfig = param2;
         _window = param1.tabButtonTemplate.clone() as IRegionWindow;
         _window.width = param3;
         _window.toolTipCaption = _parent.roomEvents.localization.getLocalization(param2.tooltipCaption);
         image.assetUri = param2.assetUri;
         _window.addEventListener("WME_CLICK",onClick);
         _window.addEventListener("WME_OVER",onOver);
         _window.addEventListener("WME_OUT",onOut);
         updateColoring();
      }
      
      public function set active(param1:Boolean) : void
      {
         _active = param1;
         updateColoring();
      }
      
      protected function onClick(param1:WindowMouseEvent) : void
      {
         _parent.selectTab(this);
      }
      
      private function onOut(param1:WindowMouseEvent) : void
      {
         var_1919 = false;
         updateColoring();
      }
      
      private function onOver(param1:WindowMouseEvent) : void
      {
         var_1919 = true;
         updateColoring();
      }
      
      private function updateColoring() : void
      {
         if(_active)
         {
            buttonBorder.color = SELECTED_BG;
            buttonShadow.color = var_5363;
         }
         else if(var_1919)
         {
            buttonBorder.color = HOVER_BG;
            buttonShadow.color = var_5349;
         }
         else
         {
            buttonBorder.color = NONE_BG;
            buttonShadow.color = NONE_SHADOW;
         }
         image.blend = _active ? 0.6 : (var_1919 ? 0.5 : 0.4);
      }
      
      public function get tabConfig() : TabButtonConfig
      {
         return _tabConfig;
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
         _parent = null;
         _window.dispose();
         _window = null;
         _tabConfig = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get buttonBorder() : class_1993
      {
         return _window.findChildByName("button_border") as class_1993;
      }
      
      private function get buttonShadow() : class_1812
      {
         return _window.findChildByName("button_shadow") as class_1812;
      }
      
      private function get image() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("button_img") as IStaticBitmapWrapperWindow;
      }
   }
}

