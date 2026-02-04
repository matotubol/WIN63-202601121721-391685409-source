package com.sulake.core.window.graphics.renderer
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.profiler.tracking.TrackedBitmapData;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.graphics.class_3809;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class BitmapSkinRenderer extends SkinRenderer implements ISkinRenderer
   {
      
      protected static const const_3:Rectangle = new Rectangle();
      
      protected static const const_41:Point = new Point();
      
      protected var _bitmapCache:Dictionary;
      
      protected var var_613:Matrix;
      
      protected var var_859:ColorTransform;
      
      public function BitmapSkinRenderer(param1:String)
      {
         super(param1);
         _bitmapCache = new Dictionary(false);
         var_613 = new Matrix();
         var_859 = new ColorTransform();
      }
      
      override public function parse(param1:IAsset, param2:XMLList, param3:class_40) : void
      {
         class_3809.parseSkinDescription(param1.content as XML,param2,this,name,param3);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            super.dispose();
            var_613 = null;
            var_859 = null;
            for(var _loc2_ in _bitmapCache)
            {
               var _loc1_:BitmapData = _bitmapCache[null] as BitmapData;
               null.dispose();
               delete _bitmapCache[null];
            }
            _bitmapCache = null;
         }
      }
      
      override public function isStateDrawable(param1:uint) : Boolean
      {
         return var_702[param1] != null;
      }
      
      override public function draw(param1:class_1741, param2:BitmapData, param3:Rectangle, param4:uint, param5:Boolean) : void
      {
         var _loc13_:* = 0;
         var _loc8_:ISkinTemplateEntity = null;
         var _loc15_:Boolean = false;
         var _loc9_:Boolean = false;
         var _loc20_:* = 0;
         var _loc22_:SkinLayoutEntity = null;
         var _loc14_:BitmapData = null;
         var _loc24_:int = 0;
         var _loc27_:* = 0;
         var _loc26_:int = 0;
         var _loc17_:BitmapData = null;
         var _loc23_:ISkinLayout = var_824[param4];
         var _loc6_:ISkinTemplate = var_702[param4];
         if(_loc23_ == null)
         {
            _loc23_ = var_824[0];
            _loc6_ = var_702[0];
         }
         _loc13_ = uint(_loc23_.numChildren);
         if(_loc23_ != null && _loc13_ > 0)
         {
            var _loc10_:int = param3.width - _loc23_.width;
            var _loc28_:int = param3.height - _loc23_.height;
            var _loc12_:Boolean = !param1.background && (param1.color & 0xFFFFFF) < 16777215;
            if(_loc12_)
            {
               var_859.redMultiplier = ((param1.color & 0xFF0000) >> 16) / 255;
               var_859.greenMultiplier = ((param1.color & 0xFF00) >> 8) / 255;
               var_859.blueMultiplier = (param1.color & 0xFF) / 255;
               var_859.alphaMultiplier = 1;
            }
            _loc20_ = 0;
            while(_loc20_ < _loc13_)
            {
               _loc22_ = _loc23_.getChildAt(_loc20_) as SkinLayoutEntity;
               _loc8_ = _loc6_.getChildByName(_loc22_.name) as ISkinTemplateEntity;
               if(_loc8_ != null)
               {
                  _loc14_ = getBitmapFromCache(_loc6_,_loc22_.name);
                  if(_loc12_ && _loc22_.colorize)
                  {
                     _loc14_ = _loc14_.clone();
                     _loc14_.colorTransform(_loc14_.rect,var_859);
                  }
                  _loc15_ = false;
                  _loc9_ = false;
                  const_3.x = _loc22_.region.x + param3.x;
                  const_3.y = _loc22_.region.y + param3.y;
                  const_3.width = _loc22_.region.width;
                  const_3.height = _loc22_.region.height;
                  if(_loc22_.scaleH == 1)
                  {
                     const_3.x += _loc10_;
                  }
                  else if(_loc22_.scaleH == 2)
                  {
                     _loc15_ = true;
                     const_3.right += _loc10_;
                     if(const_3.width < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc22_.scaleH == 4)
                  {
                     _loc15_ = true;
                     const_3.right += _loc10_;
                     if(const_3.width < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc22_.scaleH == 8)
                  {
                     const_3.x = param3.width / 2 - const_3.width / 2;
                  }
                  if(_loc22_.scaleV == 1)
                  {
                     const_3.y += _loc28_;
                  }
                  else if(_loc22_.scaleV == 2)
                  {
                     _loc9_ = true;
                     const_3.bottom += _loc28_;
                     if(const_3.height < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc22_.scaleV == 4)
                  {
                     _loc9_ = true;
                     const_3.bottom += _loc28_;
                     if(const_3.height < 1)
                     {
                        break;
                     }
                  }
                  else if(_loc22_.scaleV == 8)
                  {
                     const_3.y = param3.height / 2 - const_3.height / 2;
                  }
                  if(!_loc15_ && !_loc9_)
                  {
                     param2.copyPixels(_loc14_,_loc14_.rect,const_3.topLeft,null,null,true);
                  }
                  else if(_loc22_.scaleV == 4 || _loc22_.scaleH == 4)
                  {
                     _loc24_ = _loc14_.width;
                     var _loc19_:int = _loc14_.height;
                     var _loc11_:int = const_3.width / _loc24_;
                     var _loc29_:int = const_3.height / _loc19_;
                     var _loc16_:int = const_3.width % _loc24_;
                     var _loc7_:int = const_3.height % _loc19_;
                     var _loc25_:Point = new Point(const_3.x,const_3.y);
                     var _loc18_:Rectangle = new Rectangle(0,0,_loc16_,_loc14_.height);
                     var _loc21_:Rectangle = new Rectangle(0,0,_loc14_.width,_loc7_);
                     _loc27_ = 0;
                     while(_loc27_ < _loc29_)
                     {
                        _loc25_.x = const_3.x;
                        _loc26_ = 0;
                        while(_loc26_ < _loc11_)
                        {
                           param2.copyPixels(_loc14_,_loc14_.rect,_loc25_,null,null,true);
                           _loc25_.x += _loc24_;
                           _loc26_++;
                        }
                        if(_loc16_ > 0)
                        {
                           param2.copyPixels(_loc14_,_loc18_,_loc25_,null,null,true);
                        }
                        _loc25_.y += _loc19_;
                        _loc27_++;
                     }
                     if(_loc7_ > 0)
                     {
                        _loc25_.x = const_3.x;
                        _loc27_ = 0;
                        while(_loc27_ < _loc11_)
                        {
                           param2.copyPixels(_loc14_,_loc21_,_loc25_,null,null,true);
                           _loc25_.x += _loc24_;
                           _loc27_++;
                        }
                     }
                  }
                  else if(_loc14_.width == 1 && _loc14_.height == 1)
                  {
                     var_613.a = const_3.width;
                     var_613.d = const_3.height;
                     var_613.tx = const_3.x;
                     var_613.ty = const_3.y;
                     param2.draw(_loc14_,var_613);
                  }
                  else
                  {
                     if(const_3.width < 1)
                     {
                        break;
                     }
                     if(const_3.height < 1)
                     {
                        break;
                     }
                     var_613.a = const_3.width / _loc14_.width;
                     var_613.d = const_3.height / _loc14_.height;
                     var_613.tx = 0;
                     var_613.ty = 0;
                     _loc17_ = new BitmapData(const_3.width,const_3.height,true,0);
                     _loc17_.draw(_loc14_,var_613);
                     param2.copyPixels(_loc17_,_loc17_.rect,const_3.topLeft,null,null,true);
                     _loc17_.dispose();
                  }
                  if(_loc12_ && _loc22_.colorize)
                  {
                     _loc14_.dispose();
                  }
               }
               _loc20_++;
            }
         }
      }
      
      protected function drawStaticLayoutEntity(param1:BitmapData, param2:Rectangle, param3:ISkinLayout, param4:SkinLayoutEntity, param5:ISkinTemplate, param6:ISkinTemplateEntity) : void
      {
         var _loc8_:Rectangle = param4.region.clone();
         _loc8_.x = _loc8_.x + param2.x;
         _loc8_.y += param2.y;
         switch(param6.type)
         {
            case "bitmap":
               var _loc7_:BitmapData = getBitmapFromCache(param5,param4.name);
               if(param4.scaleH == 1)
               {
                  _loc8_.x += param2.width - param3.width;
               }
               if(param4.scaleV == 1)
               {
                  _loc8_.y += param2.height - param3.height;
               }
               param1.copyPixels(null,null.rect,_loc8_.topLeft,null,null,true);
               break;
            case "fill":
               param1.fillRect(_loc8_,param4.color);
         }
      }
      
      protected function getBitmapFromCache(param1:ISkinTemplate, param2:String) : BitmapData
      {
         var _loc5_:String = null;
         _loc5_ = param2 + "@" + param1.name;
         var _loc3_:BitmapData = _bitmapCache[_loc5_];
         if(_loc3_ == null)
         {
            var _loc6_:ISkinTemplateEntity = param1.getChildByName(param2) as ISkinTemplateEntity;
            if(_loc6_ == null)
            {
               throw new Error("Template entity" + param2 + "not found!");
            }
            var _loc4_:BitmapData = param1.asset.content as BitmapData;
            if(_loc4_ == null)
            {
               throw new Error("Asset " + param1.asset + " not found!");
            }
            _loc3_ = new TrackedBitmapData(this,null.region.width,null.region.height,true);
            _loc3_.copyPixels(null,null.region,const_41);
            _bitmapCache[_loc5_] = _loc3_;
         }
         return _loc3_;
      }
      
      private function drawBorders(param1:BitmapData, param2:Rectangle, param3:uint) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param2.bottom - 1;
         _loc4_ = param2.left;
         while(_loc4_ < param2.right - 1)
         {
            param1.setPixel32(_loc4_,0,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc4_++;
         }
         _loc5_ = param2.top;
         while(_loc5_ < param2.bottom - 1)
         {
            param1.setPixel32(0,_loc5_,param3);
            param1.setPixel32(_loc4_,_loc5_,param3);
            _loc5_++;
         }
      }
   }
}

