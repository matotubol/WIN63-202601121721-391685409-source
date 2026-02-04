package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class SpacerPreset extends WiredUIPreset
   {
      
      private var _container:class_1741;
      
      public function SpacerPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:int)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("container_view");
         _container.height = param4;
      }
      
      public function set backgroundEnabled(param1:Boolean) : void
      {
         _container.background = param1;
      }
      
      public function set backgroundColor(param1:int) : void
      {
         _container.color = 0xFF000000 | param1;
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
      }
   }
}

