package com.sulake.habbo.friendbar.landingview.layout.backgroundobjects
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.layout.backgroundobjects.events.PathResetEvent;
   import flash.events.EventDispatcher;
   
   public class SpiralMovingBackgroundObject extends BackgroundObject
   {
      
      private var _startRadius:int;
      
      private var var_5138:int;
      
      private var _posRadius:Number;
      
      private var var_729:Number;
      
      private var _speedRadius:Number;
      
      private var var_4727:Number;
      
      private var var_3875:Number;
      
      private var var_4107:Number;
      
      public function SpiralMovingBackgroundObject(param1:int, param2:class_1812, param3:EventDispatcher, param4:HabboLandingView, param5:String)
      {
         super(param1,param2,param3,param4,param5);
         var _loc7_:Array = param5.split(";");
         var _loc6_:String = _loc7_[0];
         _startRadius = int(_loc7_[2]);
         var_5138 = int(_loc7_[3]);
         _speedRadius = Number(_loc7_[4]);
         var_4727 = Number(_loc7_[5]);
         var_3875 = Number(_loc7_[6]);
         var_4107 = Number(_loc7_[7]);
         _posRadius = _startRadius;
         var_729 = var_5138;
         sprite.assetUri = "${image.library.url}reception/" + _loc6_ + ".png";
      }
      
      override public function update(param1:uint) : void
      {
         super.update(param1);
         var _loc2_:Number = _startRadius / _posRadius;
         var _loc3_:Number = 1 + _startRadius / _posRadius / 8;
         _posRadius += param1 * _speedRadius;
         var_729 += param1 * var_4727 * _loc2_;
         if(sprite.bitmapData)
         {
            if(_posRadius <= 0)
            {
               _posRadius = _startRadius;
               sprite.width = sprite.bitmapData.width;
               sprite.height = sprite.bitmapData.height;
               events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
            }
         }
         if(_posRadius > _startRadius)
         {
            _posRadius = 0;
            sprite.width = 0;
            sprite.height = 0;
            events.dispatchEvent(new PathResetEvent("LWMOPRE_MOVING_OBJECT_PATH_RESET",id));
         }
         if(var_729 < 0)
         {
            var_729 = 3.141592653589793 * 2;
         }
         if(var_729 > 3.141592653589793 * 2)
         {
            var_729 = 0;
         }
         sprite.x = var_3875 + Math.sin(var_729) * _posRadius;
         sprite.y = var_4107 + Math.cos(var_729) * _posRadius;
         if(sprite.bitmapData)
         {
            sprite.pivotPoint = 4;
            sprite.stretchedX = true;
            sprite.stretchedY = true;
            sprite.width = sprite.bitmapData.width / _loc3_;
            sprite.height = sprite.bitmapData.height / _loc3_;
         }
      }
   }
}

