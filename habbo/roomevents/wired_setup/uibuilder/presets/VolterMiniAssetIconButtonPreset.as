package com.sulake.habbo.roomevents.wired_setup.uibuilder.presets
{
   import com.sulake.core.runtime.exceptions.Exception;
   import com.sulake.core.window.components.class_2060;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   
   public class VolterMiniAssetIconButtonPreset extends MiniAssetIconButtonPreset
   {
      
      private static const COLOR_INACTIVE:uint = 2236962;
      
      private static const COLOR_YELLOW_HOVERED:uint = 5527335;
      
      private static const COLOR_YELLOW_CLICKED:uint = 6975025;
      
      private static const COLOR_BLUE_HOVERED:uint = 3356769;
      
      private static const COLOR_BLUE_CLICKED:uint = 4409728;
      
      private static const YELLOW_ASSETS:Array = ["furni_picks_1"];
      
      private static const BLUE_ASSETS:Array = ["furni_picks_2"];
      
      public function VolterMiniAssetIconButtonPreset(param1:HabboUserDefinedRoomEvents, param2:PresetManager, param3:WiredStyle, param4:String, param5:String, param6:Function)
      {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      private function get hoverColor() : uint
      {
         if(YELLOW_ASSETS.indexOf(_assetName) != -1)
         {
            return 5527335;
         }
         if(BLUE_ASSETS.indexOf(_assetName) != -1)
         {
            return 3356769;
         }
         throw new Exception("Color for asset not configured");
      }
      
      private function get clickColor() : uint
      {
         if(YELLOW_ASSETS.indexOf(_assetName) != -1)
         {
            return 6975025;
         }
         if(BLUE_ASSETS.indexOf(_assetName) != -1)
         {
            return 4409728;
         }
         throw new Exception("Color for asset not configured");
      }
      
      override protected function updateUI() : void
      {
         var _loc1_:* = 2236962;
         if(var_1919)
         {
            _loc1_ = hoverColor;
         }
         else if(_selected)
         {
            _loc1_ = clickColor;
         }
         _loc1_ |= 4278190080;
         clickArea.color = _loc1_;
         marginLeftBg.color = _loc1_;
         marginRightBg.color = _loc1_;
      }
      
      private function get marginLeftBg() : class_2060
      {
         return _container.findChildByName("margin_item_color_left") as class_2060;
      }
      
      private function get marginRightBg() : class_2060
      {
         return _container.findChildByName("margin_item_color_right") as class_2060;
      }
   }
}

