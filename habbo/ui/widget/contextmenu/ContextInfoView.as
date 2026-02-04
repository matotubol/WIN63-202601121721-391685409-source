package com.sulake.habbo.ui.widget.contextmenu
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetUserActionMessage;
   import com.sulake.habbo.utils.FixedSizeStack;
   import flash.display.BitmapData;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   
   public class ContextInfoView implements class_13
   {
      
      protected static const CONTEXT_INFO_DELAY:uint = 3000;
      
      protected static const BUTTON_COLOR_DEFAULT:uint = 4281149991;
      
      protected static const BUTTON_COLOR_HOVER:uint = 4282950861;
      
      protected static const const_895:uint = 4288230144;
      
      protected static const LINK_COLOR_ACTIONS_DEFAULT:uint = 16777215;
      
      protected static const LINK_COLOR_ACTIONS_HOVER:uint = 9552639;
      
      protected static const const_981:uint = 16777215;
      
      protected static const const_279:uint = 5789011;
      
      protected static const ICON_COLOR_ENABLED:uint = 13947341;
      
      protected static const ICON_COLOR_DISABLED:uint = 5789011;
      
      private static const const_160:int = 25;
      
      public static const const_92:int = 3;
      
      protected static var var_530:Boolean = false;
      
      protected var _window:class_1812;
      
      protected var var_751:class_1812;
      
      protected var var_125:class_1812;
      
      private var _forcedPositionUpdate:Boolean;
      
      protected var var_16:class_1853;
      
      protected var var_200:Boolean;
      
      protected var var_2160:FixedSizeStack = new FixedSizeStack(25);
      
      protected var var_2383:int = -1000000;
      
      protected var _disposed:Boolean = false;
      
      private var _forceActivateOnUpdate:Boolean = true;
      
      protected var var_764:Timer;
      
      protected var var_3745:int = 3000;
      
      protected var var_2481:Boolean;
      
      protected var var_2207:Boolean;
      
      protected var var_916:Number;
      
      protected var _fadeTime:int;
      
      protected var _fadeLength:int = 500;
      
      protected var var_236:Boolean;
      
      public function ContextInfoView(param1:class_1853)
      {
         super();
         var_16 = param1;
         var_236 = true;
         var_2481 = false;
         var_2207 = false;
      }
      
      public static function setupContext(param1:ContextInfoView) : void
      {
         param1.var_2481 = false;
         param1._fadeLength = 500;
         param1.var_2207 = false;
         param1.var_916 = 1;
         param1.var_200 = false;
         if(param1.var_236)
         {
            if(!param1.var_764)
            {
               param1.var_764 = new Timer(param1.var_3745,1);
               param1.var_764.addEventListener("timerComplete",param1.onTimerComplete);
            }
            param1.var_764.reset();
            param1.var_764.start();
         }
         param1.updateWindow();
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get maximumBlend() : Number
      {
         return 1;
      }
      
      public function dispose() : void
      {
         var_16 = null;
         var_125 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
         if(var_751)
         {
            var_751.dispose();
            var_751 = null;
         }
         if(var_764)
         {
            var_764.removeEventListener("timerComplete",onTimerComplete);
            var_764.reset();
            var_764 = null;
         }
         _disposed = true;
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         var_2207 = true;
         _fadeTime = 0;
         hide(true);
      }
      
      protected function addMouseClickListener(param1:class_1741, param2:Function) : void
      {
         if(param1 != null)
         {
            param1.addEventListener("WME_CLICK",param2);
         }
      }
      
      protected function updateWindow() : void
      {
      }
      
      protected function clickHandler(param1:WindowMouseEvent) : void
      {
         var_16.messageListener.processWidgetMessage(new RoomWidgetUserActionMessage("RWUAM_START_NAME_CHANGE"));
         var_16.removeView(this,false);
      }
      
      public function setImageAsset(param1:class_2251, param2:String, param3:Boolean = false) : void
      {
         var _loc6_:Point = null;
         if(!param1 || !var_16 || !var_16.assets)
         {
            return;
         }
         var _loc5_:BitmapDataAsset = var_16.assets.getAssetByName(param2) as BitmapDataAsset;
         if(!_loc5_)
         {
            return;
         }
         var _loc4_:BitmapData = _loc5_.content as BitmapData;
         if(!_loc4_)
         {
            return;
         }
         if(param1.bitmap)
         {
            param1.bitmap.fillRect(param1.bitmap.rect,0);
         }
         else
         {
            param1.bitmap = new BitmapData(param1.width,param1.height,true,0);
         }
         if(param3)
         {
            _loc6_ = new Point((param1.bitmap.width - _loc4_.width) / 2,(param1.bitmap.height - _loc4_.height) / 2);
         }
         else
         {
            _loc6_ = new Point(0,0);
         }
         param1.bitmap.copyPixels(_loc4_,_loc4_.rect,_loc6_,null,null,true);
         param1.invalidate();
      }
      
      public function show() : void
      {
         if(var_125 != null)
         {
            var_125.visible = true;
            if(!(var_125.parent is class_2052))
            {
               var_16.windowManager.getDesktop(0).addChild(var_125);
            }
            if(_forceActivateOnUpdate)
            {
               var_125.activate();
            }
         }
      }
      
      public function hide(param1:Boolean) : void
      {
         if(var_125 != null)
         {
            if(!var_2481 && param1 && var_764 != null)
            {
               var_2481 = true;
               var_764.start();
            }
            else
            {
               var_125.visible = false;
               var_125.parent = null;
            }
         }
      }
      
      protected function getOffset(param1:Rectangle) : int
      {
         var _loc2_:int = -var_125.height;
         return int(_loc2_ - 4);
      }
      
      public function update(param1:Rectangle, param2:Point, param3:uint) : void
      {
         if(!param1)
         {
            return;
         }
         if(!var_125)
         {
            updateWindow();
         }
         if(var_2207)
         {
            _fadeTime += param3;
            var_916 = (1 - _fadeTime / _fadeLength) * maximumBlend;
         }
         else
         {
            var_916 = maximumBlend;
         }
         if(var_916 <= 0)
         {
            var_16.removeView(this,false);
            return;
         }
         if(!var_200 || _forcedPositionUpdate)
         {
            var _loc4_:int = getOffset(param1);
            var _loc5_:int = param2.y - param1.top;
            var_2160.addValue(0);
            var _loc6_:int = var_2160.getMax();
            if(_loc6_ < var_2383 - 3)
            {
               _loc6_ = var_2383 - 3;
            }
            var _loc7_:int = param2.y - 0;
            var_2383 = 0;
            var_125.x = param2.x - var_125.width / 2;
            var_125.y = 0 + 0;
            _forcedPositionUpdate = false;
         }
         var_125.blend = var_916;
         show();
      }
      
      protected function onMouseHoverEvent(param1:WindowMouseEvent) : void
      {
         if(param1.type == "WME_OVER")
         {
            var_200 = true;
         }
         else if(param1.type == "WME_OUT")
         {
            if(!param1.window.hitTestGlobalPoint(new Point(param1.stageX,param1.stageY)))
            {
               var_200 = false;
            }
         }
      }
      
      protected function setMinimized(param1:Boolean) : void
      {
         var_530 = param1;
         _forcedPositionUpdate = true;
         updateWindow();
      }
      
      protected function getMinimizedView() : class_1812
      {
         var _loc1_:XML = null;
         if(!var_751)
         {
            _loc1_ = XmlAsset(var_16.assets.getAssetByName("minimized_menu")).content as XML;
            var_751 = var_16.windowManager.buildFromXML(_loc1_,0) as class_1812;
            var_751.findChildByName("minimize").addEventListener("WME_CLICK",onMaximize);
            var_751.findChildByName("minimize").addEventListener("WME_OVER",onMinimizeHover);
            var_751.findChildByName("minimize").addEventListener("WME_OUT",onMinimizeHover);
            var_751.addEventListener("WME_OVER",onMouseHoverEvent);
            var_751.addEventListener("WME_OUT",onMouseHoverEvent);
         }
         return var_751;
      }
      
      private function onMaximize(param1:WindowMouseEvent) : void
      {
         setMinimized(false);
      }
      
      protected function set activeView(param1:class_1812) : void
      {
         if(!param1)
         {
            return;
         }
         if(var_125)
         {
            var_125.parent = null;
         }
         var_125 = param1;
      }
      
      protected function onMinimize(param1:WindowMouseEvent) : void
      {
         setMinimized(true);
      }
      
      protected function onMinimizeHover(param1:WindowMouseEvent) : void
      {
         var _loc3_:class_1741 = null;
         var _loc2_:class_1812 = param1.window as class_1812;
         if(_loc2_)
         {
            _loc3_ = _loc2_.findChildByName("icon");
            if(_loc3_)
            {
               if(param1.type == "WME_OVER")
               {
                  _loc3_.color = 4282950861;
               }
               else
               {
                  _loc3_.color = 16777215;
               }
            }
         }
      }
      
      public function set forceActivateOnUpdate(param1:Boolean) : void
      {
         _forceActivateOnUpdate = param1;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

