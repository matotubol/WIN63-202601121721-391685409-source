package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class PaddedContainerPreset extends WiredUIPreset
   {
      
      private var _window:class_1812;
      
      private var var_906:WiredUIPreset;
      
      private var var_1335:int;
      
      private var _top:int;
      
      private var var_1467:int;
      
      private var var_1300:int;
      
      private var _ignoreListeners:Boolean = false;
      
      public function PaddedContainerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:int, param6:int, param7:int, param8:int, param9:class_1812 = null)
      {
         super(param1,param2,param3);
         var_1335 = param5;
         _top = param6;
         var_1467 = param7;
         var_1300 = param8;
         _window = param9;
         if(_window == null)
         {
            _window = param2.createLayout("growing_container_view") as class_1812;
         }
         _window.addChild(param4.window);
         var_906 = param4;
         var_906.window.x = var_1335;
         var_906.window.y = _top;
         var_906.window.addEventListener("WE_RESIZED",onResizeListener);
      }
      
      private function onResizeListener(param1:class_1758) : void
      {
         if(_ignoreListeners)
         {
            return;
         }
         resizeToWidth(_window.width);
      }
      
      override public function get window() : class_1741
      {
         return _window;
      }
      
      override protected function get childPresets() : Array
      {
         return [var_906];
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         _ignoreListeners = true;
         super.resizeToWidth(param1);
         _window.width = param1;
         var_906.resizeToWidth(param1 - var_1335 - var_1467);
         _window.height = var_906.window.height + _top + var_1300;
         _ignoreListeners = false;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_906.window.removeEventListener("WE_RESIZED",onResizeListener);
         super.dispose();
         _window.dispose();
         _window = null;
         var_906 = null;
      }
   }
}

