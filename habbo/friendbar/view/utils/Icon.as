package com.sulake.habbo.friendbar.view.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2251;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class Icon implements class_13
   {
      
      protected static const ALIGN_LEFT:int = 0;
      
      protected static const ALIGN_CENTER:int = 1;
      
      protected static const ALIGN_RIGHT:int = 2;
      
      protected static const MASK_HORIZONTAL:int = 3;
      
      protected static const ALIGN_TOP:int = 4;
      
      protected static const ALIGN_MIDDLE:int = 8;
      
      protected static const ALIGN_BOTTOM:int = 18;
      
      protected static const MASK_VERTICAL:int = 18;
      
      private var _disposed:Boolean = false;
      
      private var var_2482:Boolean = false;
      
      protected var var_48:BitmapDataAsset;
      
      protected var var_110:class_2251;
      
      private var var_2733:uint = 9;
      
      protected var var_323:Timer;
      
      protected var _frame:int = 0;
      
      private var _point:Point = new Point();
      
      protected var var_1721:Boolean = false;
      
      protected var _hover:Boolean = false;
      
      public function Icon()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get disabled() : Boolean
      {
         return var_2482;
      }
      
      protected function set image(param1:BitmapDataAsset) : void
      {
         var_48 = param1;
         redraw();
      }
      
      protected function get image() : BitmapDataAsset
      {
         return var_48;
      }
      
      protected function set canvas(param1:class_2251) : void
      {
         var_110 = param1;
         redraw();
      }
      
      protected function get canvas() : class_2251
      {
         return var_110;
      }
      
      protected function set alignment(param1:uint) : void
      {
         var_2733 = param1;
         redraw();
      }
      
      protected function get alignment() : uint
      {
         return var_2733;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            toggleTimer(false,0);
            image = null;
            canvas = null;
            _disposed = true;
         }
      }
      
      public function notify(param1:Boolean) : void
      {
         var_1721 = param1;
         if(var_1721 && var_2482)
         {
            enable(true);
         }
      }
      
      public function hover(param1:Boolean) : void
      {
         _hover = param1;
      }
      
      public function enable(param1:Boolean) : void
      {
         var_2482 = !param1;
      }
      
      protected function redraw() : void
      {
         if(var_110 && !var_110.disposed)
         {
            if(!var_110.bitmap)
            {
               var_110.bitmap = new BitmapData(var_110.width,var_110.height,true,0);
            }
            else
            {
               var_110.bitmap.fillRect(var_110.bitmap.rect,0);
            }
            if(var_48 && !var_48.disposed)
            {
               var _temp_3:* = _point;
               _point.y = 0;
               _temp_3.x = 0;
               var _loc1_:BitmapData = var_48.content as BitmapData;
               switch((var_2733 & 3) - 1)
               {
                  case 0:
                     _point.x = var_110.bitmap.width / 2 - null.width / 2;
                     break;
                  case 1:
                     _point.x = var_110.bitmap.width - null.width;
               }
               switch((var_2733 & 0x12) - 8)
               {
                  case 0:
                     _point.y = var_110.bitmap.height / 2 - null.height / 2;
                     break;
                  case 10:
                     _point.y = var_110.bitmap.height - null.height;
               }
               var_110.bitmap.copyPixels(null,null.rect,_point);
               var_110.invalidate();
            }
         }
      }
      
      protected function toggleTimer(param1:Boolean, param2:int) : void
      {
         if(param1)
         {
            if(!var_323)
            {
               var_323 = new Timer(param2,0);
               var_323.addEventListener("timer",onTimerEvent);
               var_323.start();
               onTimerEvent(null);
            }
            var_323.delay = param2;
         }
         else
         {
            _frame = 0;
            if(var_323)
            {
               var_323.reset();
               var_323.removeEventListener("timer",onTimerEvent);
               var_323 = null;
            }
         }
      }
      
      protected function onTimerEvent(param1:TimerEvent) : void
      {
      }
   }
}

