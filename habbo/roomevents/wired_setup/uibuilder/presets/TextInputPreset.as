package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextInputPreset extends WiredUIPreset implements class_31
   {
      
      private var _container:class_1812;
      
      private var var_1102:class_1741;
      
      private var var_76:ITextFieldWindow;
      
      private var var_563:TextPreset;
      
      private var var_44:TextInputParam;
      
      private var var_3331:String;
      
      private var var_2252:Array = null;
      
      private var var_1914:int;
      
      public function TextInputPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:TextInputParam)
      {
         super(param1,param2,param3);
         _container = param2.createLayout("growing_container_view") as class_1812;
         var_1102 = param3.createTextInputView();
         var_76 = var_1102.findChildByName("field") as ITextFieldWindow;
         var_1914 = var_1102.width - var_76.width;
         var_44 = param4;
         if(param4.maxCharacters > 0)
         {
            var_76.maxChars = param4.maxCharacters;
         }
         var_76.text = var_44.initialText;
         if(param4.placeholder != null)
         {
            var_563 = param2.createText(param4.placeholder,new TextParam(2));
            var_563.window.blend = 0.5;
            var_563.window.tags.push("HALF_BLEND");
            _container.addChild(var_563.window);
            var_563.window.x = var_1914 / 2;
            var_76.addEventListener("WE_CHANGE",updatePlaceholderVisibility);
            updatePlaceholderVisibility(null);
         }
         if(param4.width >= 0)
         {
            var_1102.width = param4.width + var_1914;
         }
         var_76.editable = param4.editable;
         var_76.restrict = param4.restrict;
         _container.addChild(var_1102);
      }
      
      private function updatePlaceholderVisibility(param1:class_1758) : void
      {
         var_563.window.visible = var_76.text.length == 0;
      }
      
      public function get text() : String
      {
         return var_76.text;
      }
      
      public function set text(param1:String) : void
      {
         var_76.text = param1;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
         var _loc2_:int = int(var_44.width >= 0 ? var_44.width + var_1914 : param1);
         var_1102.width = _loc2_;
         if(var_563 != null)
         {
            var_563.resizeToWidth(_loc2_ - var_1914);
         }
      }
      
      override public function get window() : class_1741
      {
         return _container;
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return var_44.width >= 0;
      }
      
      override public function get staticWidth() : int
      {
         return var_44.width + var_1914;
      }
      
      override protected function get childPresets() : Array
      {
         return var_563 == null ? [] : [var_563];
      }
      
      public function addListener(param1:Function) : void
      {
         if(var_2252 == null)
         {
            var_2252 = [];
            var_3331 = var_76.text;
            _roomEvents.context.registerUpdateReceiver(this,0);
         }
         var_2252.push(param1);
      }
      
      public function update(param1:uint) : void
      {
         if(var_76.text != var_3331)
         {
            for each(var _loc2_ in var_2252)
            {
               _loc2_(var_76.text);
            }
            var_3331 = var_76.text;
         }
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
         var_1102 = null;
         var_563 = null;
         var_44 = null;
      }
   }
}

