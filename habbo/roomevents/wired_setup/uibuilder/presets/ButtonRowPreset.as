package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ButtonRowPreset extends WiredUIPreset
   {
      
      private var _container:class_1812;
      
      private var var_121:SimpleListViewPreset;
      
      public function ButtonRowPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Array)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as class_1812;
         var_121 = param2.createSimpleListView(false,param4);
         var_121.spacing = param3.buttonRowSpacing;
         _container.addChild(var_121.window);
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var_121.resizeToWidth(param1);
      }
      
      override protected function get childPresets() : Array
      {
         return [var_121];
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
         var_121 = null;
      }
   }
}

