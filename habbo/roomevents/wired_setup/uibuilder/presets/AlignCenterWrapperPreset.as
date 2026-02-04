package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class AlignCenterWrapperPreset extends WiredUIPreset
   {
      
      private var _window:class_1812;
      
      private var _subPreset:WiredUIPreset;
      
      public function AlignCenterWrapperPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:WiredUIPreset)
      {
         super(param1,param2,param3);
         _window = param2.createLayout("container_view") as class_1812;
         _subPreset = param4;
         _window.addChild(_subPreset.window);
      }
      
      override public function get window() : class_1741
      {
         return _window;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.resizeToWidth(param1);
         _window.width = param1;
         if(_subPreset.hasStaticWidth())
         {
            _loc2_ = _subPreset.staticWidth;
            _loc3_ = Math.max(0,param1 / 2 - _loc2_ / 2);
            _subPreset.window.x = _loc3_;
            _window.height = _subPreset.window.height;
            return;
         }
         throw new Error("Attempting to align UI preset to the center is only possible if a static width is given");
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

