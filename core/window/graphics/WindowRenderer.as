package com.sulake.core.window.graphics
{
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1892;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.WindowDisposeEvent;
   import com.sulake.core.window.utils.class_1897;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class WindowRenderer implements class_1770
   {
      
      protected static const MAX_DIRTY_REGIONS_PER_WINDOW:int = 3;
      
      protected static const MAX_DISTANCE_BEFORE_COMBINE:int = 10;
      
      protected static const RECT:Rectangle = new Rectangle();
      
      private static const POINT_ZERO:Point = new Point();
      
      protected var var_1649:Boolean = false;
      
      protected var _disposed:Boolean;
      
      protected var var_779:ISkinContainer;
      
      protected var var_442:Dictionary;
      
      protected var var_942:Vector.<class_1741>;
      
      protected var var_1168:Vector.<Array>;
      
      protected var var_2289:Point;
      
      protected var var_3378:Rectangle;
      
      protected var var_100:Rectangle;
      
      protected var var_2038:Rectangle;
      
      public function WindowRenderer(param1:ISkinContainer)
      {
         super();
         _disposed = false;
         var_779 = param1;
         var_442 = new Dictionary(false);
         var_942 = new Vector.<class_1741>();
         var_1168 = new Vector.<Array>();
         var_2289 = new Point();
         var_3378 = new Rectangle();
         var_100 = new Rectangle();
         var_2038 = new Rectangle();
      }
      
      private static function areRectanglesCloseEnough(param1:Rectangle, param2:Rectangle, param3:uint) : Boolean
      {
         if(param1.intersects(param2))
         {
            return true;
         }
         return (param1.left > param2.left ? param1.left - param2.right : param2.left - param1.right) <= param3 && (param1.top > param2.top ? param1.top - param2.bottom : param2.top - param1.bottom) <= param3;
      }
      
      private static function getDrawLocationAndClipRegion(param1:class_1741, param2:Rectangle, param3:Point, param4:Rectangle) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:Boolean = true;
         param4.x = 0;
         param4.y = 0;
         param4.width = param1.renderingWidth;
         param4.height = param1.renderingHeight;
         if(!param1.testParamFlag(16))
         {
            if(param1.parent && param1.testParamFlag(1073741824))
            {
               _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
               param3.x = param4.x;
               param3.y = param4.y;
            }
            else
            {
               param3.x = 0;
               param3.y = 0;
            }
         }
         else if(param1.parent)
         {
            _loc5_ = childRectToClippedDrawRegion(param1.parent,param3,param4);
         }
         else
         {
            param3.x = 0;
            param3.y = 0;
         }
         if(param2.x > param4.x)
         {
            _loc6_ = param2.x - param4.x;
            param3.x += _loc6_;
            param4.x += _loc6_;
            param4.width -= _loc6_;
         }
         if(param2.y > param4.y)
         {
            _loc6_ = param2.y - param4.y;
            param3.y += _loc6_;
            param4.y += _loc6_;
            param4.height -= _loc6_;
         }
         if(param2.right < param4.right)
         {
            _loc6_ = param4.right - param2.right;
            param4.width -= _loc6_;
         }
         if(param2.bottom < param4.bottom)
         {
            _loc6_ = param4.bottom - param2.bottom;
            param4.height -= _loc6_;
         }
         return _loc5_ && param4.width > 0 && param4.height > 0;
      }
      
      private static function childRectToClippedDrawRegion(param1:class_1741, param2:Point, param3:Rectangle) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.testParamFlag(16))
         {
            _loc5_ = param1.renderingX;
            _loc6_ = param1.renderingY;
            param2.offset(_loc5_,_loc6_);
            if(param1.clipping)
            {
               if(param2.x < _loc5_)
               {
                  _loc4_ = _loc5_ - param2.x;
                  param3.x += _loc4_;
                  param3.width -= _loc4_;
                  param2.x = _loc5_;
               }
               if(param2.x < 0)
               {
                  param3.x -= param2.x;
                  param3.width += param2.x;
                  param2.x = 0;
               }
               if(param2.y < _loc6_)
               {
                  _loc4_ = _loc6_ - param2.y;
                  param3.y += _loc4_;
                  param3.height -= _loc4_;
                  param2.y = _loc6_;
               }
               if(param2.y < 0)
               {
                  param3.y -= param2.y;
                  param3.height += param2.y;
                  param2.y = 0;
               }
               if(param2.x + param3.width > _loc5_ + param1.renderingWidth)
               {
                  param3.width -= param2.x + param3.width - (_loc5_ + param1.renderingWidth);
               }
               if(param2.y + param3.height > _loc6_ + param1.renderingHeight)
               {
                  param3.height -= param2.y + param3.height - (_loc6_ + param1.renderingHeight);
               }
            }
            if(param1.parent)
            {
               childRectToClippedDrawRegion(param1.parent,param2,param3);
            }
         }
         else if(param1.clipping)
         {
            if(param2.x < 0)
            {
               _loc4_ = param2.x;
               param3.x -= _loc4_;
               param3.width += _loc4_;
               param2.x = 0;
            }
            if(param2.y < 0)
            {
               _loc4_ = param2.y;
               param3.y -= _loc4_;
               param3.height += _loc4_;
               param2.y = 0;
            }
         }
         return param3.width > 0 && param3.height > 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set debug(param1:Boolean) : void
      {
         var_1649 = param1;
      }
      
      public function get debug() : Boolean
      {
         return var_1649;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            for(var _loc2_ in var_442)
            {
               var _loc1_:WindowRendererItem = var_442[_loc2_] as WindowRendererItem;
               null.dispose();
               delete var_442[_loc2_];
            }
            var_442 = null;
            var_942 = null;
            var_1168 = null;
         }
      }
      
      public function purge(param1:class_1741 = null, param2:Boolean = true) : void
      {
         var _loc3_:WindowRendererItem = null;
         var _loc5_:class_1897 = null;
         var _loc4_:* = undefined;
         if(param1)
         {
            if(!param1.visible || !param2)
            {
               _loc3_ = var_442[param1];
               if(_loc3_)
               {
                  _loc3_.dispose();
                  delete var_442[param1];
               }
               param2 = false;
            }
            _loc5_ = param1 as class_1897;
            if(_loc5_)
            {
               for each(param1 in _loc5_.children)
               {
                  purge(param1,param2);
               }
            }
         }
         else
         {
            _loc4_ = new Vector.<class_1741>();
            for(var _loc6_ in var_442)
            {
               param1 = _loc6_ as class_1741;
               if(!param1.visible || !param2 || param1.parent == null && !(param1 is class_2052))
               {
                  _loc4_.push(param1);
               }
            }
            while(_loc4_.length)
            {
               purge(_loc4_.pop(),param2);
            }
         }
      }
      
      public function addToRenderQueue(param1:class_1741, param2:Rectangle, param3:uint) : void
      {
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         var _loc4_:class_1741 = null;
         var _loc5_:Array = null;
         var _loc10_:int = 0;
         var _loc6_:Rectangle = null;
         var _loc11_:Rectangle = null;
         if(!param2)
         {
            param2 = var_100;
            var_100.x = 0;
            var_100.y = 0;
            var_100.width = param1.renderingWidth;
            var_100.height = param1.renderingHeight;
         }
         else
         {
            var_100.x = param2.x;
            var_100.y = param2.y;
            var_100.width = param2.width;
            var_100.height = param2.height;
         }
         if(param2.isEmpty())
         {
            return;
         }
         if(getWindowRendererItem(param1).invalidate(param1,param3))
         {
            if(param1.testParamFlag(16) || param1.testParamFlag(1073741824))
            {
               var _loc7_:class_2052 = param1.context.getDesktopWindow();
               do
               {
                  _loc4_ = param1.parent;
                  if(_loc4_ == null)
                  {
                     return;
                  }
                  if(_loc4_ == _loc7_)
                  {
                     break;
                  }
                  if(!_loc4_.visible)
                  {
                     return;
                  }
                  _loc8_ = _loc4_.renderingWidth;
                  _loc12_ = _loc4_.renderingHeight;
                  var_100.offset(param1.renderingX,param1.renderingY);
                  if(_loc4_.clipping)
                  {
                     if(var_100.x > _loc8_ || var_100.y > _loc12_ || var_100.right < 0 || var_100.bottom < 0)
                     {
                        return;
                     }
                     if(var_100.x < 0)
                     {
                        var_100.width += var_100.x;
                        var_100.x = 0;
                     }
                     if(var_100.y < 0)
                     {
                        var_100.height += var_100.y;
                        var_100.y = 0;
                     }
                     if(var_100.right > _loc8_)
                     {
                        var_100.right = _loc8_;
                     }
                     if(var_100.bottom > _loc12_)
                     {
                        var_100.bottom = _loc12_;
                     }
                  }
                  if(var_100.isEmpty())
                  {
                     return;
                  }
                  param1 = _loc4_;
               }
               while(!(!param1.testParamFlag(16) && !param1.testParamFlag(1073741824)));
               
            }
            getWindowRendererItem(param1).invalidate(param1,32);
            _loc10_ = int(var_942.indexOf(param1));
            if(_loc10_ > -1)
            {
               _loc5_ = var_1168[_loc10_];
               _loc11_ = var_100;
               var _loc9_:int = int(_loc5_.length);
               if(_loc9_ > 3)
               {
                  _loc11_ = _loc11_.union(_loc5_.pop());
                  _loc9_--;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc6_ = _loc5_[_loc10_++];
                  if((_loc6_.left > _loc11_.left ? _loc6_.left - _loc11_.right : _loc11_.left - _loc6_.right) <= 10 && (_loc6_.top > _loc11_.top ? _loc6_.top - _loc11_.bottom : _loc11_.top - _loc6_.bottom) <= 10)
                  {
                     _loc5_.splice(_loc10_ - 1,1);
                     _loc11_ = _loc11_.union(_loc6_);
                     _loc9_--;
                     _loc10_ = 0;
                  }
               }
               _loc5_.push(_loc11_ == var_100 ? _loc11_.clone() : _loc11_);
            }
            else
            {
               var_942.push(param1);
               var_1168.push([var_100.clone()]);
            }
         }
      }
      
      public function flushRenderQueue() : void
      {
         if(var_942.length || var_1168.length)
         {
            var_942.splice(0,var_942.length);
            var_1168.splice(0,var_1168.length);
         }
      }
      
      public function invalidate(param1:class_1892, param2:Rectangle) : void
      {
         var _loc5_:class_1741 = null;
         var _loc4_:class_2052 = null;
         _loc4_ = param1.getDesktopWindow();
         var _loc3_:uint = uint(_loc4_.numChildren);
         while(_loc3_-- > 0)
         {
            _loc5_ = _loc4_.getChildAt(_loc3_);
            addToRenderQueue(_loc5_,null,1);
         }
      }
      
      protected function getWindowRendererItem(param1:class_1741) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = var_442[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = registerRenderable(param1);
         }
         return _loc2_;
      }
      
      public function registerRenderable(param1:class_1741) : WindowRendererItem
      {
         var _loc2_:WindowRendererItem = var_442[param1] as WindowRendererItem;
         if(_loc2_ == null)
         {
            _loc2_ = new WindowRendererItem(var_779);
            var_442[param1] = _loc2_;
            _loc2_.invalidate(param1,8);
         }
         if(!param1.hasEventListener("WINDOW_DISPOSE_EVENT"))
         {
            param1.addEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         }
         return _loc2_;
      }
      
      public function removeRenderable(param1:class_1741) : void
      {
         param1.removeEventListener("WINDOW_DISPOSE_EVENT",windowDisposedCallback);
         var _loc2_:WindowRendererItem = var_442[param1] as WindowRendererItem;
         if(_loc2_ != null)
         {
            _loc2_.dispose();
            delete var_442[param1];
         }
      }
      
      protected function windowDisposedCallback(param1:WindowDisposeEvent) : void
      {
         removeRenderable(param1.window);
      }
      
      public function getDrawBufferForRenderable(param1:class_1741) : BitmapData
      {
         var _loc3_:WindowRendererItem = var_442[param1] as WindowRendererItem;
         if(!_loc3_)
         {
            var _loc2_:Rectangle = new Rectangle(0,0,param1.renderingWidth,param1.renderingHeight);
            var _loc4_:TrackedBitmapData = new TrackedBitmapData(this,param1.renderingWidth,param1.renderingHeight);
            _loc3_ = registerRenderable(param1);
            _loc3_.invalidate(param1,1);
            _loc3_.render(param1,POINT_ZERO,null,param1.renderingRectangle,null);
            null.dispose();
         }
         return _loc3_ != null ? _loc3_.buffer : null;
      }
      
      public function render() : void
      {
         var _loc1_:* = null;
         var _loc2_:Array = null;
         var _loc4_:BitmapData = null;
         var _loc5_:class_1741 = null;
         var _loc3_:uint = var_942.length;
         while(_loc3_-- > 0)
         {
            _loc5_ = var_942.pop();
            _loc2_ = var_1168.pop();
            if(!_loc5_.disposed)
            {
               _loc4_ = _loc5_.fetchDrawBuffer() as BitmapData;
               for each(_loc1_ in _loc2_)
               {
                  var_2038.x = _loc5_.renderingX;
                  var_2038.y = _loc5_.renderingY;
                  var_2038.width = _loc5_.renderingWidth;
                  var_2038.height = _loc5_.renderingHeight;
                  renderWindowBranch(_loc5_,_loc1_,var_2038,_loc4_);
               }
            }
         }
      }
      
      private function renderWindowBranch(param1:class_1741, param2:Rectangle, param3:Rectangle, param4:BitmapData) : void
      {
         var _loc7_:IGraphicContext = IGraphicContextHost(param1).getGraphicContext(false);
         if(_loc7_)
         {
            _loc7_.visible = param1.visible;
         }
         if(param1.visible)
         {
            var_2289.x = param1.renderingX;
            var_2289.y = param1.renderingY;
            if(getDrawLocationAndClipRegion(param1,param2,var_2289,var_3378))
            {
               if(param1.clipping)
               {
                  param3 = param3.intersection(param1.renderingRectangle);
               }
               param3.offset(-param1.x,-param1.y);
               param4 = getWindowRendererItem(param1).render(param1,var_2289,var_3378,param3,param4);
               if(!(param1 is class_1897))
               {
                  return;
               }
               var _loc5_:Vector.<class_1741> = class_1897(param1).children;
               if(!_loc5_)
               {
                  return;
               }
               if(param1.clipping)
               {
                  param2 = param2.clone();
                  if(param2.x < 0)
                  {
                     param2.width += param2.x;
                     param2.x = 0;
                  }
                  if(param2.y < 0)
                  {
                     param2.height += param2.y;
                     param2.y = 0;
                  }
                  if(param2.width > param1.width)
                  {
                     param2.width = param1.renderingWidth;
                  }
                  if(param2.height > param1.height)
                  {
                     param2.height = param1.renderingHeight;
                  }
               }
               for each(var _loc8_ in undefined)
               {
                  RECT.x = null.x;
                  RECT.y = null.y;
                  RECT.width = null.width;
                  RECT.height = null.height;
                  if(RECT.intersects(param2))
                  {
                     if(null.testParamFlag(16))
                     {
                        param2.offset(-null.x,-null.y);
                        renderWindowBranch(null,param2,param3,param4);
                        param2.offset(null.x,null.y);
                     }
                     else if(null.testParamFlag(1073741824))
                     {
                        param2.offset(-null.x,-null.y);
                        renderWindowBranch(null,param2,param3,null.fetchDrawBuffer() as BitmapData);
                        param2.offset(null.x,null.y);
                     }
                     else if(null.visible)
                     {
                        var _loc6_:IGraphicContextHost = IGraphicContextHost(null);
                        if(_loc6_.hasGraphicsContext())
                        {
                           null.getGraphicContext(true).visible = true;
                        }
                     }
                  }
                  else if(!RECT.intersects(param3))
                  {
                     _loc6_ = IGraphicContextHost(null);
                     if(_loc6_.hasGraphicsContext())
                     {
                        null.getGraphicContext(true).visible = false;
                     }
                  }
               }
               param3.offset(param1.renderingX,param1.renderingY);
            }
            else if(!param1.testParamFlag(16))
            {
               if(param1.testParamFlag(1073741824))
               {
                  if(!_loc7_)
                  {
                     _loc7_ = IGraphicContextHost(param1).getGraphicContext(true);
                  }
                  _loc7_.setDrawRegion(param1.renderingRectangle,false,var_3378);
                  _loc7_.visible = false;
               }
            }
         }
      }
   }
}

