package com.sulake.core.window.graphics
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.graphics.renderer.ISkinRenderer;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WindowRendererItem implements class_13
   {
      
      protected static const RENDER_TYPE_NULL:uint = 0;
      
      protected static const RENDER_TYPE_SKIN:uint = 1;
      
      protected static const RENDER_TYPE_FILL:uint = 2;
      
      protected static const MATRIX:Matrix = new Matrix();
      
      protected static const COLOR_TRANSFORM:ColorTransform = new ColorTransform();
      
      protected var var_256:TrackedBitmapData;
      
      protected var var_779:ISkinContainer;
      
      protected var _disposed:Boolean;
      
      protected var _refresh:Boolean;
      
      protected var var_2459:uint;
      
      protected var var_1751:uint;
      
      public function WindowRendererItem(param1:ISkinContainer)
      {
         super();
         _disposed = false;
         var_779 = param1;
         var_2459 = 4294967295;
         var_1751 = 0;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get buffer() : BitmapData
      {
         return var_256;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _disposed = true;
            var_779 = null;
            if(var_256 != null)
            {
               var_256.dispose();
               var_256 = null;
            }
         }
      }
      
      public function purge() : void
      {
      }
      
      public function render(param1:class_1741, param2:Point, param3:Rectangle, param4:Rectangle, param5:BitmapData) : BitmapData
      {
         var _loc13_:Boolean = false;
         var _loc6_:BitmapData = null;
         var _loc11_:String = null;
         var _loc14_:uint = param1.background ? 2 : 0;
         var _loc7_:ISkinRenderer = var_779.getSkinRendererByTypeAndStyle(param1.type,param1.style);
         if(_loc7_ != null)
         {
            if(_loc7_.isStateDrawable(var_1751))
            {
               _loc14_ = 1;
            }
         }
         var _loc12_:int = Math.max(param1.renderingWidth,1);
         var _loc8_:int = Math.max(param1.renderingHeight,1);
         if(_loc14_ != 0)
         {
            if(!var_256 || var_256.width != _loc12_ || var_256.height != _loc8_)
            {
               if(var_256)
               {
                  var_256.dispose();
               }
               var_256 = new TrackedBitmapData(this,_loc12_,_loc8_,true,param1.color);
               _refresh = true;
               var _loc9_:Boolean = false;
            }
         }
         var _loc15_:IGraphicContext = IGraphicContextHost(param1).getGraphicContext(false);
         if(_loc15_)
         {
            if(!_loc15_.visible)
            {
               _loc15_.visible = true;
            }
            _loc13_ = param1.testParamFlag(1073741824);
            _loc6_ = _loc15_.setDrawRegion(param1.renderingRectangle,!param1.testParamFlag(16),_loc13_ ? param4 : null);
            if(_loc6_)
            {
               param5 = _loc6_;
               _refresh = true;
            }
         }
         var _loc10_:* = !param1.testParamFlag(16);
         if(_loc14_ != 0)
         {
            if(param5 != null)
            {
               param5.lock();
               if(_loc14_ == 1)
               {
                  if(_refresh)
                  {
                     if(_loc10_)
                     {
                        param5.fillRect(param3,0);
                     }
                     _refresh = false;
                     var_256.fillRect(var_256.rect,param1.color);
                     _loc7_.draw(param1,var_256,var_256.rect,var_1751,false);
                  }
                  _loc11_ = "normal";
                  if(param1.tags != null && param1.tags.indexOf("BLEND_ADD") != -1)
                  {
                     _loc11_ = "add";
                  }
                  if((param1.blend < 1 || _loc11_ != "normal") && !_loc10_)
                  {
                     MATRIX.tx = param2.x - param3.x;
                     MATRIX.ty = param2.y - param3.y;
                     COLOR_TRANSFORM.alphaMultiplier = param1.blend;
                     param3.offset(MATRIX.tx,MATRIX.ty);
                     param5.draw(var_256,MATRIX,COLOR_TRANSFORM,_loc11_,param3,false);
                     param3.offset(-MATRIX.tx,-MATRIX.ty);
                  }
                  else
                  {
                     param5.copyPixels(var_256,param3,param2,null,null,true);
                  }
               }
               else if(_loc14_ == 2)
               {
                  if(!_loc10_)
                  {
                     var_256.fillRect(var_256.rect,param1.color);
                     param5.copyPixels(var_256,param3,param2,null,null,true);
                  }
                  else
                  {
                     param5.fillRect(new Rectangle(param2.x,param2.y,param3.width,param3.height),param1.color);
                     _loc15_.blend = param1.blend;
                  }
               }
               param5.unlock();
            }
         }
         else if(_refresh && _loc10_)
         {
            _refresh = false;
            if(param5 != null)
            {
               param5.fillRect(param3,0);
            }
         }
         var_2459 = var_1751;
         return param5;
      }
      
      public function testForStateChange(param1:class_1741) : Boolean
      {
         return var_779.getTheActualState(param1.type,param1.style,param1.state) != var_2459;
      }
      
      public function invalidate(param1:class_1741, param2:uint) : Boolean
      {
         var _loc4_:IGraphicContext = null;
         var _loc3_:Boolean = false;
         switch(param2)
         {
            case 1:
               _refresh = true;
               _loc3_ = true;
               break;
            case 2:
               _refresh = true;
               _loc3_ = true;
               break;
            case 4:
               if(param1.testParamFlag(16))
               {
                  _loc3_ = true;
                  break;
               }
               _loc4_ = IGraphicContextHost(param1).getGraphicContext(true);
               _loc4_.setDrawRegion(param1.renderingRectangle,false,null);
               if(!_loc4_.visible)
               {
                  _loc3_ = true;
               }
               break;
            case 8:
               var_1751 = var_779.getTheActualState(param1.type,param1.style,param1.state);
               if(var_1751 != var_2459)
               {
                  _refresh = true;
                  _loc3_ = true;
               }
               break;
            case 16:
               if(param1.testParamFlag(16))
               {
                  _refresh = true;
                  _loc3_ = true;
                  break;
               }
               IGraphicContextHost(param1).getGraphicContext(true).blend = param1.blend;
               break;
            case 32:
               _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function drawRect(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right)
         {
            param1.setPixel32(_loc4_,param2.top,param3);
            param1.setPixel32(_loc4_,param2.bottom - 1,param3);
            _loc4_++;
         }
         _loc4_ = param2.top;
         while(_loc4_ < param2.bottom)
         {
            param1.setPixel32(param2.left,_loc4_,param3);
            param1.setPixel32(param2.right - 1,_loc4_,param3);
            _loc4_++;
         }
      }
   }
}

