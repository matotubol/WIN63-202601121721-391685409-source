package com.sulake.habbo.avatar.wardrobe
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class OutfitView
   {
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var _window:class_1812;
      
      private var var_184:class_2251;
      
      private var var_2335:IStaticBitmapWrapperWindow;
      
      private var _button:class_1775;
      
      private var _bgColor:int;
      
      private var var_4618:int;
      
      private var _gradientColor:int;
      
      private var var_4186:int;
      
      private var _active:Boolean;
      
      public function OutfitView(param1:class_38, param2:class_40, param3:Boolean)
      {
         super();
         _windowManager = param1;
         var_909 = param2;
         var _loc4_:XmlAsset = var_909.getAssetByName("Outfit") as XmlAsset;
         _window = class_1812(_windowManager.buildFromXML(_loc4_.content as XML));
         if(_window != null)
         {
            var_184 = _window.findChildByName("bitmap") as class_2251;
            var_2335 = _window.findChildByName("outfit_gradient") as IStaticBitmapWrapperWindow;
            var_2335.visible = false;
            _button = _window.findChildByName("button") as class_1775;
            if(!param3)
            {
               _button.disable();
            }
         }
      }
      
      public function dispose() : void
      {
         _windowManager = null;
         var_909 = null;
         if(_window)
         {
            _window.dispose();
         }
         _window = null;
         if(var_184)
         {
            var_184.dispose();
         }
         var_184 = null;
      }
      
      public function update(param1:BitmapData) : void
      {
         var_184.bitmap = new BitmapData(var_184.width,var_184.height,true,16777215);
         var _loc2_:int = (var_184.width - param1.width) / 2;
         var _loc3_:int = var_184.height - param1.height;
         var_184.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_));
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function windowEventProc(param1:class_1758, param2:class_1741 = null) : void
      {
         if(param1.type != "WME_CLICK")
         {
            if(param1.type == "WME_OVER")
            {
               _window.color = 13421772;
            }
            else if(param1.type == "WME_OUT")
            {
               _window.color = 6710886;
            }
         }
      }
      
      private function updateBackgroundColors() : void
      {
         _button.color = _active ? var_4618 : _bgColor;
         if(_gradientColor == -1)
         {
            var_2335.visible = false;
         }
         else
         {
            var_2335.color = _active ? var_4186 : _gradientColor;
            var_2335.visible = true;
         }
      }
      
      public function setColors(param1:int, param2:int, param3:int, param4:int) : void
      {
         _bgColor = param1;
         var_4618 = param2;
         _gradientColor = param3;
         var_4186 = param4;
         updateBackgroundColors();
      }
      
      public function toggleActive(param1:Boolean) : void
      {
         _active = param1;
         updateBackgroundColors();
      }
   }
}

