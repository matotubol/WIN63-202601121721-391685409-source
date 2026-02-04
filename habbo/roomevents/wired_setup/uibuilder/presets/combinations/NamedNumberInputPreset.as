package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.NumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.TextPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.WiredUIPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class NamedNumberInputPreset extends WiredUIPreset
   {
      
      private var _container:IItemListWindow;
      
      private var _textPreset:TextPreset;
      
      private var _numberInputPreset:NumberInputPreset;
      
      public function NamedNumberInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:NumberInputParam, param5:String, param6:Boolean = false)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("horizontal_list_view") as IItemListWindow;
         _textPreset = param2.createText(param5,new TextParam(0,param6));
         _numberInputPreset = param2.createNumberInput(param4);
         _container.spacing = param3.genericHorizontalSpacing;
         _container.addListItem(_textPreset.window);
         _container.addListItem(_numberInputPreset.window);
         _container.height = Math.max(_textPreset.window.height,_numberInputPreset.window.height);
      }
      
      public function get value() : int
      {
         return _numberInputPreset.value;
      }
      
      public function set value(param1:int) : void
      {
         _numberInputPreset.value = param1;
      }
      
      public function get number() : Number
      {
         return _numberInputPreset.number;
      }
      
      public function reset() : void
      {
         _numberInputPreset.reset();
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return _numberInputPreset.hasStaticWidth();
      }
      
      override public function get staticWidth() : int
      {
         if(hasStaticWidth())
         {
            return _container.width;
         }
         throw new Exception("Named number input has no static width");
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         _textPreset.resizeToWidth(_textPreset.width);
         _numberInputPreset.resizeToWidth(param1 - _numberInputPreset.window.x);
      }
      
      override protected function get childPresets() : Array
      {
         return [_textPreset,_numberInputPreset];
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
         _numberInputPreset = null;
      }
   }
}

