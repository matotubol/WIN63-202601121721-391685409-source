package com.sulake.room.utils
{
   public class ColorTransitioner
   {
      
      private var _color:uint = 16777215;
      
      private var var_1711:int = 255;
      
      private var _originalColor:uint = 16777215;
      
      private var var_2527:int = 255;
      
      private var _targetColor:uint = 16777215;
      
      private var var_2284:int = 255;
      
      private var _colorChangedTime:int = 0;
      
      private var _colorTransitionLength:int = 0;
      
      public function ColorTransitioner(param1:uint = 16777215, param2:int = 255)
      {
         super();
         _color = param1;
         var_1711 = param2;
         _originalColor = param1;
         var_2527 = param2;
         _targetColor = param1;
         var_2284 = param2;
      }
      
      public function startTransition(param1:int, param2:int, param3:int, param4:int = 1500) : void
      {
         _originalColor = _color;
         var_2527 = var_1711;
         _targetColor = param1;
         var_2284 = param2;
         _colorChangedTime = param3;
         _colorTransitionLength = param4;
      }
      
      public function updateColor(param1:int) : Boolean
      {
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc7_:* = 0;
         var _loc4_:* = 0;
         var _loc10_:* = 0;
         var _loc5_:* = 0;
         var _loc11_:Number = NaN;
         if(!_colorChangedTime)
         {
            return false;
         }
         var _loc9_:int = param1;
         if(_loc9_ - _colorChangedTime >= _colorTransitionLength)
         {
            _color = _targetColor;
            var_1711 = var_2284;
            _colorChangedTime = 0;
         }
         else
         {
            _loc2_ = _originalColor >> 16 & 0xFF;
            _loc3_ = _originalColor >> 8 & 0xFF;
            _loc7_ = _originalColor & 0xFF;
            _loc4_ = _targetColor >> 16 & 0xFF;
            _loc10_ = _targetColor >> 8 & 0xFF;
            _loc5_ = _targetColor & 0xFF;
            _loc11_ = (_loc9_ - _colorChangedTime) / _colorTransitionLength;
            _loc2_ += (_loc4_ - _loc2_) * _loc11_;
            _loc3_ += (_loc10_ - _loc3_) * _loc11_;
            _loc7_ += (_loc5_ - _loc7_) * _loc11_;
            _loc6_ = (_loc2_ << 16) + (_loc3_ << 8) + _loc7_;
            _loc8_ = var_2527 + (var_2284 - var_2527) * _loc11_;
            _color = _loc6_;
            var_1711 = _loc8_;
         }
         return true;
      }
      
      public function get color() : int
      {
         var _loc1_:int = ColorConverter.rgbToHSL(_color);
         _loc1_ = (_loc1_ & 0xFFFF00) + var_1711;
         return ColorConverter.hslToRGB(_loc1_);
      }
   }
}

