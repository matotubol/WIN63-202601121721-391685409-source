package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.utils.class_2201;
   import flash.display.BitmapData;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapDataRenderer extends SkinRenderer
   {
      
      protected static const const_433:Number = 0.212671;
      
      protected static const const_226:Number = 0.71516;
      
      protected static const B:Number = 0.072169;
      
      protected static const _MATRIX:Matrix = new Matrix();
      
      protected static const const_7:ColorTransform = new ColorTransform();
      
      protected static const const_10:ColorTransform = new ColorTransform(0,0,0,1,1,1,1,0);
      
      protected static const _GREYSCALE_FILTER:ColorMatrixFilter = new ColorMatrixFilter();
      
      public function BitmapDataRenderer(param1:String)
      {
         super(param1);
      }
      
      override public function draw(param1:class_1741, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc9_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:BitmapData = null;
         var _loc12_:Matrix = null;
         var _loc15_:int = 0;
         var _loc21_:int = 0;
         var _loc20_:int = 0;
         var _loc22_:int = 0;
         var _loc19_:int = 0;
         var _loc18_:int = 0;
         var _loc13_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc17_:int = 0;
         var _loc16_:int = 0;
         var _loc6_:class_2201 = param1 as class_2201;
         var _loc14_:BitmapData = _loc6_.bitmapData;
         if(param2 != null && _loc14_ != null)
         {
            if(_loc6_.rotation != 0)
            {
               _loc9_ = _loc14_.width / 2;
               _loc7_ = _loc14_.height / 2;
               _loc10_ = new BitmapData(_loc14_.width,_loc14_.height,true,0);
               _loc12_ = new Matrix();
               _loc12_.translate(-_loc9_,-_loc7_);
               _loc12_.rotate(_loc6_.rotation / 180 * 3.141592653589793);
               _loc12_.translate(_loc9_,_loc7_);
               _loc10_.draw(_loc14_,_loc12_);
               _loc14_ = _loc10_;
            }
            _loc15_ = (_loc6_.stretchedX ? param1.width : _loc14_.width) * _loc6_.zoomX;
            _loc21_ = (_loc6_.stretchedY ? param1.height : _loc14_.height) * _loc6_.zoomY;
            _loc20_ = !_loc6_.wrapX ? 1 : param1.width / _loc15_ + 2;
            _loc22_ = !_loc6_.wrapY ? 1 : param1.height / _loc21_ + 2;
            _MATRIX.a = _loc15_ / _loc14_.width;
            _MATRIX.d = _loc21_ / _loc14_.height;
            switch(int(_loc6_.pivotPoint))
            {
               case 0:
               case 3:
               case 6:
                  _MATRIX.tx = _loc6_.zoomX < 0 ? -_loc15_ : 0;
                  break;
               case 1:
               case 4:
               case 7:
                  _MATRIX.tx = int((param1.width - _loc15_) / 2);
                  break;
               case 2:
               case 5:
               case 8:
                  _MATRIX.tx = _loc6_.zoomX < 0 ? param1.width : param1.width - _loc15_;
            }
            _loc19_ = _MATRIX.tx;
            while(_loc6_.wrapX && _loc19_ > 0)
            {
               _loc19_ -= _loc15_;
            }
            switch(int(_loc6_.pivotPoint))
            {
               case 0:
               case 1:
               case 2:
                  _MATRIX.ty = _loc6_.zoomY < 0 ? -_loc21_ : 0;
                  break;
               case 3:
               case 4:
               case 5:
                  _MATRIX.ty = int((param1.height - _loc21_) / 2);
                  break;
               case 6:
               case 7:
               case 8:
                  _MATRIX.ty = _loc6_.zoomY < 0 ? param1.height : param1.height - _loc21_;
            }
            _loc18_ = _MATRIX.ty;
            while(_loc6_.wrapY && _loc18_ > 0)
            {
               _loc18_ -= _loc21_;
            }
            _loc13_ = ((param1.color & 0xFF0000) >> 16) / 255;
            _loc11_ = ((param1.color & 0xFF00) >> 8) / 255;
            _loc8_ = (param1.color & 0xFF) / 255;
            const_10.alphaMultiplier = (_loc6_.etchingColor >> 24 & 0xFF) / 255;
            const_10.redOffset = _loc6_.etchingColor >> 16 & 0xFF;
            const_10.greenOffset = _loc6_.etchingColor >> 8 & 0xFF;
            const_10.blueOffset = _loc6_.etchingColor & 0xFF;
            param2.lock();
            _MATRIX.ty = _loc18_;
            _loc17_ = 0;
            while(_loc17_ < _loc22_)
            {
               _MATRIX.tx = _loc19_;
               _loc16_ = 0;
               while(_loc16_ < _loc20_)
               {
                  if(_loc6_.greyscale)
                  {
                     _GREYSCALE_FILTER.matrix = [_loc13_ * 0.212671,_loc13_ * 0.71516,_loc13_ * 0.072169,0,0,_loc11_ * 0.212671,_loc11_ * 0.71516,_loc11_ * 0.072169,0,0,_loc8_ * 0.212671,_loc8_ * 0.71516,_loc8_ * 0.072169,0,0,0,0,0,1,0];
                     if(const_10.alphaMultiplier >= 0.001)
                     {
                        _MATRIX.tx += _loc6_.etchingPoint.x;
                        _MATRIX.ty += _loc6_.etchingPoint.y;
                        param2.draw(_loc14_,_MATRIX,const_10,null,null,false);
                        _MATRIX.tx -= _loc6_.etchingPoint.x;
                        _MATRIX.ty -= _loc6_.etchingPoint.y;
                     }
                     param2.draw(_loc14_,_MATRIX,null,null,null,false);
                     param2.applyFilter(param2,param2.rect,new Point(),_GREYSCALE_FILTER);
                  }
                  else
                  {
                     const_7.redMultiplier = _loc13_;
                     const_7.greenMultiplier = _loc11_;
                     const_7.blueMultiplier = _loc8_;
                     const_7.alphaMultiplier = 1;
                     const_7.redOffset = 0;
                     const_7.greenOffset = 0;
                     const_7.blueOffset = 0;
                     const_7.alphaOffset = 0;
                     if(param1.dynamicStyleColor)
                     {
                        const_7.concat(param1.dynamicStyleColor);
                     }
                     if(const_10.alphaMultiplier >= 0.001)
                     {
                        _MATRIX.tx += _loc6_.etchingPoint.x;
                        _MATRIX.ty += _loc6_.etchingPoint.y;
                        param2.draw(_loc14_,_MATRIX,const_10,null,null,false);
                        _MATRIX.tx -= _loc6_.etchingPoint.x;
                        _MATRIX.ty -= _loc6_.etchingPoint.y;
                     }
                     param2.draw(_loc14_,_MATRIX,const_7,null,null,false);
                  }
                  _MATRIX.tx += _loc15_;
                  _loc16_++;
               }
               _MATRIX.ty += _loc21_;
               _loc17_++;
            }
            param2.unlock();
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return param1 == 0;
      }
   }
}

