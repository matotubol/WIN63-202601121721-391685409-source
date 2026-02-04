package com.sulake.habbo.catalog.viewer.widgets.franksemotions
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class FrankRecyclerEmotion
   {
      
      private static var var_3141:Array = [];
      
      private var _bitmap:IStaticBitmapWrapperWindow;
      
      private var var_323:Timer;
      
      private var _startTime:int;
      
      private var var_3408:Number;
      
      private var var_4009:Number;
      
      public function FrankRecyclerEmotion(param1:IStaticBitmapWrapperWindow)
      {
         super();
         if(var_3141.length > 0)
         {
            _bitmap = var_3141.pop() as IStaticBitmapWrapperWindow;
            _bitmap.y = param1.y;
         }
         else
         {
            _bitmap = param1.clone() as IStaticBitmapWrapperWindow;
         }
         var _loc3_:Array = ["franks_emotions_blush","franks_emotions_heart"];
         var _loc4_:int = Math.floor(Math.random() * _loc3_.length);
         var _loc2_:String = _loc3_[_loc4_];
         _bitmap.assetUri = _loc2_;
         _bitmap.x += Math.floor(Math.random() * 70) - 20;
         var_4009 = -(Math.random() * 80 + 30);
         _bitmap.blend = 0;
      }
      
      public function start(param1:class_1812) : void
      {
         param1.addChild(_bitmap);
         _startTime = getTimer();
         var_3408 = _bitmap.y;
         var_323 = new Timer(16.666666666666668);
         var_323.addEventListener("timer",onTick);
         var_323.start();
      }
      
      private function onTick(param1:TimerEvent) : void
      {
         if(_bitmap.disposed)
         {
            var_323.stop();
            var_323.removeEventListener("timer",onTick);
            var_323 = null;
            _bitmap = null;
         }
         var _loc2_:Number = (getTimer() - _startTime) / 1000;
         var _loc3_:Number = Math.min(1,_loc2_ * 1.25);
         if(_loc3_ > _bitmap.blend + 0.1 || _bitmap.blend < 1 && _loc3_ == 1)
         {
            _bitmap.blend = _loc3_;
         }
         _bitmap.y = var_3408 + var_4009 * _loc2_;
         if(_bitmap.y < -50)
         {
            var_323.stop();
            var_323.removeEventListener("timer",onTick);
            var_323 = null;
            if(_bitmap.parent)
            {
               _bitmap.parent = null;
            }
            var_3141.push(_bitmap);
         }
      }
   }
}

