package com.sulake.habbo.avatar.animation
{
   import com.sulake.core.utils.class_55;
   import flash.geom.ColorTransform;
   
   public class AvatarDataContainer implements class_2792
   {
      
      private var var_3689:int;
      
      private var var_4761:uint;
      
      private var var_4263:uint;
      
      private var var_859:ColorTransform;
      
      private var var_2398:uint;
      
      private var _r:uint;
      
      private var _g:uint;
      
      private var _b:uint;
      
      private var var_3753:Number = 1;
      
      private var var_3780:Number = 1;
      
      private var var_3460:Number = 1;
      
      private var var_1756:Number = 1;
      
      private var var_2378:class_55;
      
      private var var_4960:Boolean = true;
      
      public function AvatarDataContainer(param1:XML)
      {
         super();
         var_3689 = parseInt(param1.@ink);
         var _loc2_:String = String(param1.@foreground);
         _loc2_ = _loc2_.replace("#","");
         var _loc3_:String = String(param1.@background);
         _loc3_ = _loc3_.replace("#","");
         var_4761 = parseInt(_loc2_,16);
         var_4263 = parseInt(_loc3_,16);
         var_2398 = parseInt(_loc2_,16);
         _r = var_2398 >> 16 & 0xFF;
         _g = var_2398 >> 8 & 0xFF;
         _b = var_2398 >> 0 & 0xFF;
         var_3753 = _r / 255 * 1;
         var_3780 = _g / 255 * 1;
         var_3460 = _b / 255 * 1;
         if(var_3689 == 37)
         {
            var_1756 = 0.5;
            var_4960 = false;
         }
         var_859 = new ColorTransform(var_3753,var_3780,var_3460,var_1756);
         var_2378 = generatePaletteMapForGrayscale(var_4263,var_4761);
      }
      
      public function get ink() : int
      {
         return var_3689;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return var_859;
      }
      
      public function get reds() : Array
      {
         return var_2378.getValue("reds") as Array;
      }
      
      public function get greens() : Array
      {
         return var_2378.getValue("greens") as Array;
      }
      
      public function get blues() : Array
      {
         return var_2378.getValue("blues") as Array;
      }
      
      public function get alphas() : Array
      {
         return var_2378.getValue("alphas") as Array;
      }
      
      public function get paletteIsGrayscale() : Boolean
      {
         return var_4960;
      }
      
      private function generatePaletteMapForGrayscale(param1:uint, param2:uint) : class_55
      {
         var _loc9_:int = 0;
         var _loc15_:* = param1 >> 24 & 0xFF;
         var _loc24_:* = param1 >> 16 & 0xFF;
         var _loc10_:* = param1 >> 8 & 0xFF;
         var _loc14_:* = param1 >> 0 & 0xFF;
         var _loc17_:* = param2 >> 24 & 0xFF;
         var _loc3_:* = param2 >> 16 & 0xFF;
         var _loc11_:* = param2 >> 8 & 0xFF;
         var _loc16_:* = param2 >> 0 & 0xFF;
         var _loc21_:Number = (_loc17_ - _loc15_) / 255;
         var _loc12_:Number = (_loc3_ - _loc24_) / 255;
         var _loc6_:Number = (_loc11_ - _loc10_) / 255;
         var _loc23_:Number = (_loc16_ - _loc14_) / 255;
         var _loc22_:class_55 = new class_55();
         var _loc19_:Array = [];
         var _loc8_:Array = [];
         var _loc13_:Array = [];
         var _loc20_:Array = [];
         var _loc4_:Number = _loc15_;
         var _loc18_:Number = _loc24_;
         var _loc7_:Number = _loc10_;
         var _loc5_:Number = _loc14_;
         _loc9_ = 0;
         while(_loc9_ < 256)
         {
            if(_loc18_ == _loc24_ && _loc7_ == _loc10_ && _loc5_ == _loc14_)
            {
               _loc4_ = 0;
            }
            _loc4_ += _loc21_;
            _loc18_ += _loc12_;
            _loc7_ += _loc6_;
            _loc5_ += _loc23_;
            _loc20_.push(_loc4_ << 24);
            _loc19_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc8_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc13_.push(_loc4_ << 24 | _loc18_ << 16 | _loc7_ << 8 | _loc5_);
            _loc9_++;
         }
         _loc22_.add("alphas",_loc19_);
         _loc22_.add("reds",_loc19_);
         _loc22_.add("greens",_loc8_);
         _loc22_.add("blues",_loc13_);
         return _loc22_;
      }
   }
}

