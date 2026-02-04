package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2251;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class SnowWarAnimatedWindowElement implements class_13
   {
      
      private var var_848:int;
      
      private var var_1703:String;
      
      private var var_353:Array = [];
      
      private var _currentFrame:int;
      
      private var var_286:class_2251;
      
      private var var_323:Timer;
      
      private var _disposed:Boolean = false;
      
      public function SnowWarAnimatedWindowElement(param1:class_40, param2:class_2251, param3:String, param4:int, param5:int = 100, param6:Boolean = false)
      {
         super();
         var_286 = param2;
         var_1703 = param3;
         var_848 = param4;
         var _loc7_:int = 1;
         while(0 <= var_848)
         {
            if(param1.hasAsset(var_1703 + 0))
            {
               var_353.push(param1.getAssetByName(var_1703 + 0).content as BitmapData);
            }
            else
            {
               var_353.push(new BitmapData(1,1));
               class_21.log("Missing asset for Snow War: " + var_1703 + 0);
            }
            _loc7_++;
         }
         if(param6)
         {
            var_848 += param4 - 2;
            _loc7_ = param4 - 1;
         }
         update();
         var_323 = new Timer(param5);
         var_323.addEventListener("timer",onTimer);
         var_323.start();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_323.removeEventListener("timer",onTimer);
            var_323.stop();
            var_323 = null;
            if(var_286 && var_286.bitmap)
            {
               var_286.bitmap.fillRect(var_286.bitmap.rect,0);
               var_286.invalidate();
            }
            var_286 = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onTimer(param1:TimerEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         _currentFrame = ++_currentFrame % var_848;
         if(!var_286.bitmap)
         {
            var_286.bitmap = new BitmapData(var_286.width,var_286.height);
         }
         var_286.bitmap.fillRect(var_286.bitmap.rect,0);
         var _loc2_:BitmapData = var_353[_currentFrame];
         var _loc1_:Point = new Point((var_286.width - _loc2_.width) / 2,(var_286.height - _loc2_.height) / 2);
         var_286.bitmap.copyPixels(_loc2_,_loc2_.rect,_loc1_);
         var_286.invalidate();
      }
   }
}

