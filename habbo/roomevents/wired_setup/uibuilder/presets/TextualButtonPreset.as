package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextualButtonPreset extends WiredUIPreset
   {
      
      private var _container:class_1812;
      
      private var _textPreset:TextPreset;
      
      private var var_254:Function;
      
      public function TextualButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:Function)
      {
         super(param1,param2,param3);
         var_254 = param5;
         _container = param2.createLayout("growing_container_view") as class_1812;
         _textPreset = param2.createText(param4,new TextParam(0,false,0,true));
         _container.addChild(_textPreset.window);
         _container.addEventListener("WME_CLICK",onClick);
         _container.mouseThreshold = 0;
      }
      
      public function set text(param1:String) : void
      {
         _textPreset.text = param1;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
         var_254();
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
      
      override protected function get childPresets() : Array
      {
         return [_textPreset];
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
         _textPreset = null;
         var_254 = null;
      }
   }
}

