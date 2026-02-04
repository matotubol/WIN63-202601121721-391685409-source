package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class StaticHeightPreset extends WiredUIPreset
   {
      
      private var _window:class_1812;
      
      private var _subPreset:WiredUIPreset;
      
      public function StaticHeightPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset, param5:int)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("container_view") as class_1812;
         _subPreset = param4;
         _window.addChild(_subPreset.window);
         _window.height = param5;
      }
      
      override public function get window() : class_1741
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _window.width = param1;
         _subPreset.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [_subPreset];
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         _window.dispose();
         _window = null;
         _subPreset = null;
      }
   }
}

