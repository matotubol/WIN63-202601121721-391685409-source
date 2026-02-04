package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class ButtonPreset extends WiredUIPreset
   {
      
      public static const MODE_SCALE:int = 0;
      
      public static const MODE_STRETCH:int = 1;
      
      private var _container:class_1775;
      
      private var var_261:int;
      
      private var var_2263:Function;
      
      public function ButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function, param6:int = 0)
      {
         super(param1,param2,param3);
         var_2263 = param5;
         _container = param3.createButton();
         _container.caption = param4;
         var_261 = param6;
         _container.addEventListener("WME_CLICK",buttonClicked);
      }
      
      private function buttonClicked(param1:WindowMouseEvent) : void
      {
         if(var_2263 != null)
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
         if(var_261 == 0)
         {
            _container.limits.minWidth = param1;
            _container.limits.maxWidth = param1;
            _container.width = param1;
         }
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return var_261 == 1;
      }
      
      override public function get staticWidth() : int
      {
         if(var_261 == 1)
         {
            return _container.width;
         }
         return -1;
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
         var_2263 = null;
      }
   }
}

