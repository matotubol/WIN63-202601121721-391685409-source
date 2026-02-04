package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class CollapseExpandSectionButtonPreset extends WiredUIPreset
   {
      
      private var var_308:IRegionWindow;
      
      private var _callback:Function;
      
      public function CollapseExpandSectionButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:Function, param5:Boolean)
      {
         super(param1,param2,param3);
         _callback = param4;
         var_308 = param3.createExpandCollapseSectionRegion();
         upArrow.visible = param5;
         downArrow.visible = !param5;
         var_308.addEventListener("WME_CLICK",onButtonClicked);
      }
      
      override public function get window() : class_1741
      {
         return var_308;
      }
      
      override public function resizeToWidth(param1:int) : void
      {
         super.resizeToWidth(param1);
      }
      
      override public function hasStaticWidth() : Boolean
      {
         return true;
      }
      
      override public function get staticWidth() : int
      {
         return var_308.width;
      }
      
      public function get isExpanded() : Boolean
      {
         return upArrow.visible;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:* = !isExpanded;
         upArrow.visible = _loc2_;
         downArrow.visible = !_loc2_;
         if(_callback != null)
         {
            _callback(_loc2_);
         }
      }
      
      private function get upArrow() : IStaticBitmapWrapperWindow
      {
         return var_308.findChildByName("up_arrow") as IStaticBitmapWrapperWindow;
      }
      
      private function get downArrow() : IStaticBitmapWrapperWindow
      {
         return var_308.findChildByName("down_arrow") as IStaticBitmapWrapperWindow;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         super.dispose();
         var_308.dispose();
         var_308 = null;
         _callback = null;
      }
   }
}

