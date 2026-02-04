package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IInteractiveWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class MiniAssetIconButtonPreset extends WiredUIPreset
   {
      
      protected var _container:class_1741;
      
      protected var _selected:Boolean;
      
      protected var var_1919:Boolean;
      
      protected var _assetName:String;
      
      private var var_2263:Function;
      
      public function MiniAssetIconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3);
         _assetName = param4;
         _container = param3.createMiniButton();
         var_2263 = param6;
         iconWrapper.assetUri = getAssetFullName(param4);
         clickArea.addEventListener("WME_OVER",onHoverStart);
         clickArea.addEventListener("WME_OUT",onHoverEnd);
         clickArea.addEventListener("WME_CLICK",iconClicked);
         clickArea.toolTipCaption = param5;
         updateUI();
      }
      
      private function onHoverEnd(param1:WindowMouseEvent) : void
      {
         var_1919 = false;
         updateUI();
      }
      
      private function onHoverStart(param1:WindowMouseEvent) : void
      {
         var_1919 = true;
         updateUI();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         updateUI();
      }
      
      protected function updateUI() : void
      {
      }
      
      protected function iconClicked(param1:WindowMouseEvent) : void
      {
         if(var_2263 != null && !_selected)
         {
            var_2263();
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
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return _container.width;
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
         _assetName = null;
         var_2263 = null;
      }
      
      protected function get clickArea() : IInteractiveWindow
      {
         return _container.findChildByName("mini_button_click") as IInteractiveWindow;
      }
      
      private function get iconWrapper() : IStaticBitmapWrapperWindow
      {
         return _container.findChildByName("mini_button_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

