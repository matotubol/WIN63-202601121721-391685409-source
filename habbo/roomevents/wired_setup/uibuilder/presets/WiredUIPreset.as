package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class WiredUIPreset implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      protected var _roomEvents:HabboUserDefinedRoomEvents;
      
      protected var var_182:PresetManager;
      
      protected var var_64:WiredStyle;
      
      private var var_1872:SpacerPreset;
      
      private var _blendingBackgroundColor:int = 0;
      
      private var var_2482:Boolean;
      
      public function WiredUIPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle)
      {
         super();
         _roomEvents = param1;
         var_182 = param2;
         var_64 = param3;
      }
      
      protected static function toArray(param1:*) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function get window() : class_1741
      {
         return null;
      }
      
      public function resizeToWidth(param1:int) : void
      {
      }
      
      public function hasStaticWidth() : Boolean
      {
         return false;
      }
      
      public function get staticWidth() : int
      {
         return -1;
      }
      
      public function alignRight() : WiredUIPreset
      {
         return new AlignRightWrapperPreset(_roomEvents,var_182,var_64,this);
      }
      
      public function alignCenter() : WiredUIPreset
      {
         return new AlignCenterWrapperPreset(_roomEvents,var_182,var_64,this);
      }
      
      public function staticHeight(param1:int) : WiredUIPreset
      {
         return new StaticHeightPreset(_roomEvents,var_182,var_64,this,param1);
      }
      
      public function wrapWindow(param1:class_1741) : WiredUIPreset
      {
         return new WindowWrapperPreset(_roomEvents,var_182,var_64,param1);
      }
      
      public function noDisable() : WiredUIPreset
      {
         window.tags.push("DO_NOT_DISABLE");
         return this;
      }
      
      public function halfBlend() : WiredUIPreset
      {
         window.blend = 0.5;
         window.tags.push("HALF_BLEND");
         return this;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         if(var_2482 == param1)
         {
            return;
         }
         var_2482 = param1;
         updateDisabledState();
      }
      
      protected function updateDisabledState() : void
      {
         Util.disableSection(window,var_2482);
         if(!var_2482)
         {
            for each(var _loc1_ in childPresets)
            {
               _loc1_.updateDisabledState();
            }
         }
      }
      
      protected function get childPresets() : Array
      {
         return [];
      }
      
      public function get disabled() : Boolean
      {
         return var_2482;
      }
      
      public function set visible(param1:Boolean) : void
      {
         window.visible = param1;
      }
      
      public function get visible() : Boolean
      {
         return window.visible;
      }
      
      protected function loc(param1:String) : String
      {
         return _roomEvents.localization.getLocalization(param1,param1);
      }
      
      protected function l(param1:String) : String
      {
         return _roomEvents.localization.getLocalization("wiredfurni.params." + param1,param1);
      }
      
      protected function get localizations() : class_27
      {
         return _roomEvents.localization;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         var_1872 = null;
         _roomEvents = null;
         var_64 = null;
         var_182 = null;
         for each(var _loc1_ in childPresets)
         {
            _loc1_.dispose();
         }
         _disposed = true;
      }
      
      public function set blendSpacer(param1:SpacerPreset) : void
      {
         var_1872 = param1;
         updateBackgroundColorBlending();
      }
      
      protected function set blendingBackgroundColor(param1:int) : void
      {
         _blendingBackgroundColor = param1;
         updateBackgroundColorBlending();
      }
      
      private function updateBackgroundColorBlending() : void
      {
         var _loc1_:* = false;
         if(var_1872 != null)
         {
            _loc1_ = _blendingBackgroundColor != 0;
            var_1872.backgroundEnabled = _loc1_;
            if(_loc1_)
            {
               var_1872.backgroundColor = _blendingBackgroundColor;
            }
         }
      }
      
      protected function getAssetFullName(param1:String) : String
      {
         return "wired_styles_" + var_64.name + "_" + param1;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

