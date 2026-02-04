package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextAreaParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.TextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class TextAreaPreset extends WiredUIPreset
   {
      
      private var _container:class_1812;
      
      private var var_1102:class_1741;
      
      private var var_76:ITextFieldWindow;
      
      private var var_563:TextPreset;
      
      private var var_44:TextAreaParam;
      
      private var var_1914:int;
      
      public function TextAreaPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:TextAreaParam)
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
            var_563 = param2.createText(param4.placeholder,new TextParam(1));
            var_563.window.blend = 0.5;
            var_563.window.tags.push("HALF_BLEND");
            var_563.window.x = var_1914 / 2;
            _container.addChild(var_563.window);
         }
         var_76.addEventListener("WE_CHANGE",textHasChanged);
         textHasChanged(null);
         var_76.multiline = true;
         var_76.wordWrap = false;
         if(param4.width >= 0)
         {
            var_1102.width = param4.width + var_1914;
         }
         var_1102.height = param4.height;
         if(param4.maxLines >= 0)
         {
            var_76.maxLines = param4.maxLines;
         }
         var_76.editable = param4.editable;
         var_76.restrict = param4.restrict;
         _container.addChild(var_1102);
      }
      
      private function textHasChanged(param1:class_1758) : void
      {
         if(var_563)
         {
            var_563.window.visible = var_76.length == 0;
         }
      }
      
      public function get text() : String
      {
         return var_76.text.replace(/\n\r/g,"\n").replace(/\r/g,"\n");
      }
      
      public function set text(param1:String) : void
      {
         var_76.text = param1.replace(/\n/g,"\r");
         textHasChanged(null);
      }
      
      public function reset() : void
      {
         var_76.text = "";
         textHasChanged(null);
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
      
      override protected function get childPresets() : Array
      {
         return var_563 == null ? [] : [var_563];
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
         var_563 = null;
         var_44 = null;
      }
   }
}

