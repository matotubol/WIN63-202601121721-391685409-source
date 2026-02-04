package com.sulake.habbo.toolbar.extensions.purse
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.utils.class_2724;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class CurrencyIndicatorBase implements class_2162
   {
      
      protected static const const_748:int = 0;
      
      protected static const const_494:int = 1;
      
      private static const const_628:Number = 0.025;
      
      protected var _window:class_1812;
      
      protected var _windowManager:class_38;
      
      protected var _assets:class_40;
      
      private var _disposed:Boolean = false;
      
      private var var_2350:IStaticBitmapWrapperWindow;
      
      private var var_5033:uint;
      
      private var var_4440:uint;
      
      private var _textElementName:String;
      
      private var var_518:Vector.<String> = new Vector.<String>();
      
      private var var_4444:uint;
      
      private var var_3974:String = null;
      
      private var var_3806:uint = 0;
      
      private var _animOffset:int;
      
      private var var_902:Timer;
      
      private var _overlayTimer:Timer;
      
      private var _overlayPhase:Number;
      
      private var _overlayStartValue:int;
      
      private var _overlayEndValue:int;
      
      public function CurrencyIndicatorBase(param1:class_38, param2:class_40)
      {
         super();
         _window = null;
         _windowManager = param1;
         _assets = param2;
         var_902 = null;
         _overlayTimer = new Timer(40);
         _overlayTimer.addEventListener("timer",onOverlayTimer);
      }
      
      protected function set bgColorLight(param1:uint) : void
      {
         var_5033 = param1;
      }
      
      protected function set bgColorDark(param1:uint) : void
      {
         var_4440 = param1;
      }
      
      protected function set textElementName(param1:String) : void
      {
         _textElementName = param1;
      }
      
      protected function set iconAnimationDelay(param1:uint) : void
      {
         var_4444 = param1;
      }
      
      protected function set amountZeroText(param1:String) : void
      {
         var_3974 = param1;
      }
      
      protected function get amountZeroText() : String
      {
         return var_3974;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         if(_overlayTimer != null)
         {
            _overlayTimer.stop();
            _overlayTimer = null;
         }
         if(var_902)
         {
            var_902.stop();
            var_902 = null;
         }
         if(var_518)
         {
            var_518 = null;
         }
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         _disposed = true;
      }
      
      public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
      }
      
      protected function onContainerClick(param1:WindowMouseEvent) : void
      {
      }
      
      protected function createWindow(param1:String, param2:String) : void
      {
         var _loc3_:XmlAsset = _assets.getAssetByName(param1) as XmlAsset;
         if(_loc3_)
         {
            _window = _windowManager.buildFromXML(_loc3_.content as XML,1) as class_1812;
            if(_window)
            {
               _window.addEventListener("WME_CLICK",onContainerClick);
               _window.addEventListener("WME_OVER",onContainerMouseOver);
               _window.addEventListener("WME_OUT",onContainerMouseOut);
               var _loc4_:Array = [];
               if(_window.groupChildrenWithTag("ICON",null,-1) == 1)
               {
                  var_2350 = null[0] as IStaticBitmapWrapperWindow;
                  setIconBitmap(param2);
               }
            }
         }
      }
      
      protected function animateIcon(param1:int) : void
      {
         var_3806 = param1;
         if(var_2350 && var_518.length > 0)
         {
            if(var_3806 == 0)
            {
               _animOffset = 0;
            }
            else
            {
               _animOffset = var_518.length - 1;
            }
            var_902 = new Timer(var_4444,var_518.length);
            var_902.addEventListener("timer",onAnimationTimer);
            var_902.addEventListener("timerComplete",onAnimationTimerComplete);
            var_902.start();
            onAnimationTimer(null);
         }
      }
      
      protected function setAmount(param1:int, param2:int = -1) : void
      {
         setText(param1.toString());
      }
      
      protected function setText(param1:String) : void
      {
         if(_window)
         {
            _window.findChildByName(_textElementName).caption = param1;
         }
      }
      
      protected function setTextUnderline(param1:Boolean) : void
      {
         if(_window)
         {
            ITextWindow(_window.findChildByName(_textElementName)).underline = param1;
         }
      }
      
      protected function set iconAnimationSequence(param1:Array) : void
      {
         var _loc2_:* = null;
         for each(_loc2_ in param1)
         {
            var_518.push(_loc2_);
         }
      }
      
      private function onAnimationTimer(param1:TimerEvent) : void
      {
         if(var_2350 && var_518.length > 0)
         {
            setIconBitmap(var_518[_animOffset]);
            if(var_3806 == 0)
            {
               _animOffset = _animOffset + 1;
               _animOffset = _animOffset < var_518.length ? _animOffset : var_518.length - 1;
            }
            else
            {
               _animOffset = _animOffset - 1;
               _animOffset = _animOffset >= 0 ? _animOffset : 0;
            }
         }
      }
      
      private function onAnimationTimerComplete(param1:TimerEvent) : void
      {
         if(var_518.length > 0)
         {
            setIconBitmap(var_518[0]);
         }
      }
      
      private function setIconBitmap(param1:String) : void
      {
         if(var_2350)
         {
            var_2350.assetUri = param1;
         }
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = var_5033;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         _window.findChildByTag("BGCOLOR").color = var_4440;
      }
      
      protected function animateChange(param1:int, param2:int) : void
      {
         _overlayPhase = 0;
         _overlayStartValue = param1;
         _overlayEndValue = param2;
         if(_window != null)
         {
            var _loc3_:class_1741 = _window.findChildByName("change");
         }
         _overlayTimer.start();
         onOverlayTimer(null);
      }
      
      private function onOverlayTimer(param1:TimerEvent) : void
      {
         var _loc3_:Number = Math.pow(_overlayPhase - 0.5,3) * 4 + 0.5;
         setAmount(int(class_2724.lerp(Math.max(0,_overlayPhase * 2 - 1),_overlayStartValue,_overlayEndValue)));
         var _loc2_:class_1812 = _window.findChildByName("change_overlay") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.visible = true;
         _loc2_.blend = 1 - Math.abs(0.5 - _loc3_) * 2;
         _loc2_.x = class_2724.lerp(_loc3_,0,_window.width - _loc2_.width);
         _overlayPhase += 0.025;
         if(_overlayPhase >= 1)
         {
            _loc2_.visible = false;
            _overlayTimer.stop();
            setAmount(_overlayEndValue);
         }
      }
   }
}

