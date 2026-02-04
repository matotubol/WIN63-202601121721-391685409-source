package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1899;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.HtmlTextParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class HtmlPreset extends TextPreset
   {
      
      private var var_925:HtmlTextParam;
      
      public function HtmlPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:HtmlTextParam)
      {
         super(param1,param2,param3,param4,param5);
         var_925 = param5;
         (window as class_1899).selectable = var_925.selectable;
      }
      
      override protected function createView() : ITextWindow
      {
         return var_64.createHtmlView();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_925 = null;
      }
   }
}

