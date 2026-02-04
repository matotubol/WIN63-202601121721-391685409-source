package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class FurniturePlane
   {
      
      private var var_2795:int = -1;
      
      private var var_2205:Number = 0;
      
      private var var_4219:Number = 0;
      
      private var var_4377:Number = 0;
      
      private var var_3217:Number = 0;
      
      private var _origin:Vector3d = null;
      
      private var var_190:Vector3d = null;
      
      private var var_428:Vector3d = null;
      
      private var var_535:Vector3d = null;
      
      private var var_1320:Vector3d = null;
      
      private var var_1377:Vector3d = null;
      
      private var _normal:Vector3d = null;
      
      private var var_1213:Boolean = true;
      
      private var _bitmapData:BitmapData = null;
      
      private var var_365:class_55 = null;
      
      private var _offset:Point = null;
      
      private var _relativeDepth:Number = 0;
      
      private var _color:uint = 0;
      
      private var var_4028:Boolean = false;
      
      private var var_197:String = null;
      
      private var var_309:Vector3d = null;
      
      private var var_242:Vector3d = null;
      
      private var var_175:Vector3d = null;
      
      private var var_253:Vector3d = null;
      
      private var _width:Number = 0;
      
      private var var_385:Number = 0;
      
      public function FurniturePlane(param1:IVector3d, param2:IVector3d, param3:IVector3d)
      {
         super();
         _origin = new Vector3d();
         var_190 = new Vector3d();
         var_190.assign(param1);
         var_428 = new Vector3d();
         var_428.assign(param2);
         var_535 = new Vector3d();
         var_535.assign(param3);
         var_1320 = new Vector3d();
         var_1320.assign(param2);
         var_1377 = new Vector3d();
         var_1377.assign(param3);
         _normal = Vector3d.crossProduct(var_428,var_535);
         if(_normal.length > 0)
         {
            _normal.mul(1 / _normal.length);
         }
         _offset = new Point();
         var_309 = new Vector3d();
         var_242 = new Vector3d();
         var_175 = new Vector3d();
         var_253 = new Vector3d();
         var_365 = new class_55();
      }
      
      public function get bitmapData() : BitmapData
      {
         if(var_1213)
         {
            if(_bitmapData != null)
            {
               return _bitmapData.clone();
            }
         }
         return null;
      }
      
      public function get visible() : Boolean
      {
         return var_1213;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get relativeDepth() : Number
      {
         return _relativeDepth;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function set color(param1:uint) : void
      {
         _color = param1;
      }
      
      public function get leftSide() : IVector3d
      {
         return var_428;
      }
      
      public function get rightSide() : IVector3d
      {
         return var_535;
      }
      
      public function get location() : IVector3d
      {
         return var_190;
      }
      
      public function get normal() : IVector3d
      {
         return _normal;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(_bitmapData != null)
         {
            _bitmapData.dispose();
            _bitmapData = null;
         }
         if(var_365 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_365.length)
            {
               _loc1_ = var_365.getWithIndex(_loc2_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_365.dispose();
            var_365 = null;
         }
         _origin = null;
         var_190 = null;
         var_428 = null;
         var_535 = null;
         var_1320 = null;
         var_1377 = null;
         _normal = null;
         var_309 = null;
         var_242 = null;
         var_175 = null;
         var_253 = null;
      }
      
      public function setRotation(param1:Boolean) : void
      {
         if(param1 != var_4028)
         {
            if(!param1)
            {
               var_428.assign(var_1320);
               var_535.assign(var_1377);
            }
            else
            {
               var_428.assign(var_1320);
               var_428.mul(var_1377.length / var_1320.length);
               var_535.assign(var_1377);
               var_535.mul(var_1320.length / var_1377.length);
            }
            var_2795 = -1;
            var_2205 -= 1;
            var_4028 = param1;
            resetTextureCache();
         }
      }
      
      private function cacheTexture(param1:String, param2:BitmapData) : Boolean
      {
         var _loc3_:BitmapData = var_365.remove(param1) as BitmapData;
         if(_loc3_ != null && param2 != _loc3_)
         {
            _loc3_.dispose();
         }
         var_365.add(param1,param2);
         return true;
      }
      
      private function resetTextureCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BitmapData = null;
         if(var_365 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_365.length)
            {
               _loc1_ = var_365.getWithIndex(_loc2_) as BitmapData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_365.reset();
         }
      }
      
      private function getTextureIdentifier(param1:IRoomGeometry) : String
      {
         if(param1 == null)
         {
            return null;
         }
         return String(param1.scale);
      }
      
      private function needsNewTexture(param1:IRoomGeometry) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = getTextureIdentifier(param1);
         var _loc3_:BitmapData = var_365.getValue(_loc2_) as BitmapData;
         if(_width > 0 && var_385 > 0)
         {
            if(_loc3_ == null)
            {
               return true;
            }
         }
         return false;
      }
      
      private function getTexture(param1:IRoomGeometry, param2:int) : BitmapData
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:String = getTextureIdentifier(param1);
         var _loc5_:BitmapData = null;
         if(needsNewTexture(param1))
         {
            _loc6_ = var_428.length * param1.scale;
            _loc7_ = var_535.length * param1.scale;
            if(_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            if(_loc7_ < 1)
            {
               _loc7_ = 1;
            }
            var _loc4_:IVector3d = param1.getCoordinatePosition(_normal);
            _loc5_ = var_365.getValue(_loc3_) as BitmapData;
            if(_loc5_ == null)
            {
               _loc5_ = new BitmapData(_loc6_,_loc7_,true,0xFF000000 | _color);
               if(_loc5_ != null)
               {
                  cacheTexture(_loc3_,_loc5_);
               }
            }
         }
         else
         {
            _loc5_ = var_365.getValue(_loc3_) as BitmapData;
         }
         if(_loc5_ != null)
         {
            return _loc5_;
         }
         return null;
      }
      
      public function update(param1:IRoomGeometry, param2:int) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:BitmapData = null;
         if(param1 == null || var_190 == null && _origin != null || var_428 == null || var_535 == null || _normal == null)
         {
            return false;
         }
         if(param1.updateId != var_2795)
         {
            var_2795 = param1.updateId;
            var _loc6_:IVector3d = param1.direction;
            if(_loc6_ != null && (null.x != var_2205 || null.y != var_4219 || null.z != var_4377 || param1.scale != var_3217))
            {
               var_2205 = null.x;
               var_4219 = null.y;
               var_4377 = null.z;
               var_3217 = param1.scale;
               var _loc9_:Boolean = true;
               _loc3_ = 0;
               _loc3_ = Vector3d.cosAngle(param1.directionAxis,normal);
               if(_loc3_ > -0.001)
               {
                  if(var_1213)
                  {
                     var_1213 = false;
                     return true;
                  }
                  return false;
               }
               updateCorners(param1);
               var _loc4_:IVector3d = param1.getScreenPosition(_origin);
               _loc5_ = _loc4_.z;
               _relativeDepth = _loc7_ = Math.max(var_309.z - _loc5_,var_242.z - _loc5_,var_175.z - _loc5_,var_253.z - _loc5_);
               var_1213 = true;
            }
         }
         if(needsNewTexture(param1))
         {
            if(_bitmapData == null || _width != _bitmapData.width || var_385 != _bitmapData.height)
            {
               if(_bitmapData != null)
               {
                  _bitmapData.dispose();
                  _bitmapData = null;
                  if(_width < 1 || var_385 < 1)
                  {
                     return true;
                  }
               }
               else if(_width < 1 || var_385 < 1)
               {
                  return false;
               }
               _bitmapData = new BitmapData(_width,var_385,true,16777215);
               _bitmapData.lock();
            }
            else
            {
               _bitmapData.lock();
               _bitmapData.fillRect(_bitmapData.rect,16777215);
            }
            _loc8_ = getTexture(param1,param2);
            if(_loc8_ != null)
            {
               renderTexture(param1,_loc8_);
            }
            _bitmapData.unlock();
            return true;
         }
         return false;
      }
      
      private function updateCorners(param1:IRoomGeometry) : void
      {
         var_309.assign(param1.getScreenPosition(var_190));
         var_242.assign(param1.getScreenPosition(Vector3d.sum(var_190,var_535)));
         var_175.assign(param1.getScreenPosition(Vector3d.sum(Vector3d.sum(var_190,var_428),var_535)));
         var_253.assign(param1.getScreenPosition(Vector3d.sum(var_190,var_428)));
         _offset = param1.getScreenPoint(_origin);
         var_309.x = Math.round(var_309.x);
         var_309.y = Math.round(var_309.y);
         var_242.x = Math.round(var_242.x);
         var_242.y = Math.round(var_242.y);
         var_175.x = Math.round(var_175.x);
         var_175.y = Math.round(var_175.y);
         var_253.x = Math.round(var_253.x);
         var_253.y = Math.round(var_253.y);
         _offset.x = Math.round(_offset.x);
         _offset.y = Math.round(_offset.y);
         var _loc3_:Number = Math.min(var_309.x,var_242.x,var_175.x,var_253.x);
         var _loc5_:Number = Math.max(var_309.x,var_242.x,var_175.x,var_253.x);
         var _loc2_:Number = Math.min(var_309.y,var_242.y,var_175.y,var_253.y);
         var _loc4_:Number = Math.max(var_309.y,var_242.y,var_175.y,var_253.y);
         _loc5_ -= _loc3_;
         _offset.x -= _loc3_;
         var_309.x -= _loc3_;
         var_242.x -= _loc3_;
         var_175.x -= _loc3_;
         var_253.x -= _loc3_;
         _loc4_ -= _loc2_;
         _offset.y -= _loc2_;
         var_309.y -= _loc2_;
         var_242.y -= _loc2_;
         var_175.y -= _loc2_;
         var_253.y -= _loc2_;
         _width = _loc5_;
         var_385 = _loc4_;
      }
      
      private function renderTexture(param1:IRoomGeometry, param2:BitmapData) : void
      {
         if(var_309 == null || var_242 == null || var_175 == null || var_253 == null || param2 == null || _bitmapData == null)
         {
            return;
         }
         var _loc8_:Number = var_253.x - var_175.x;
         var _loc10_:Number = var_253.y - var_175.y;
         var _loc4_:Number = var_242.x - var_175.x;
         var _loc3_:Number = var_242.y - var_175.y;
         if(Math.abs(_loc4_ - param2.width) <= 1)
         {
            _loc4_ = param2.width;
         }
         if(Math.abs(_loc3_ - param2.width) <= 1)
         {
            _loc3_ = param2.width;
         }
         if(Math.abs(_loc8_ - param2.height) <= 1)
         {
            _loc8_ = param2.height;
         }
         if(Math.abs(_loc10_ - param2.height) <= 1)
         {
            _loc10_ = param2.height;
         }
         var _loc5_:Number = _loc4_ / param2.width;
         var _loc6_:Number = _loc3_ / param2.width;
         var _loc7_:Number = _loc8_ / param2.height;
         var _loc9_:Number = _loc10_ / param2.height;
         var _loc11_:Matrix = new Matrix();
         _loc11_.a = _loc5_;
         _loc11_.b = _loc6_;
         _loc11_.c = _loc7_;
         _loc11_.d = _loc9_;
         _loc11_.translate(var_175.x,var_175.y);
         draw(param2,_loc11_);
      }
      
      private function draw(param1:BitmapData, param2:Matrix) : void
      {
         var _loc4_:int = 0;
         var _loc7_:* = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_bitmapData != null)
         {
            if(param2.a == 1 && param2.d == 1 && param2.c == 0 && param2.b != 0 && Math.abs(param2.b) <= 1)
            {
               _loc4_ = 0;
               _loc7_ = 0;
               _loc3_ = 0;
               _loc6_ = 0;
               if(param2.b > 0)
               {
                  param2.ty++;
               }
               _loc5_ = 0;
               while(_loc4_ < param1.width)
               {
                  _loc4_++;
                  _loc3_ += Math.abs(param2.b);
                  if(_loc3_ >= 1)
                  {
                     _bitmapData.copyPixels(param1,new Rectangle(_loc7_ + _loc6_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
                     _loc7_ = _loc4_;
                     if(param2.b > 0)
                     {
                        _loc5_++;
                     }
                     else
                     {
                        _loc5_--;
                     }
                     _loc3_ = 0;
                  }
               }
               if(_loc3_ > 0)
               {
                  _bitmapData.copyPixels(param1,new Rectangle(_loc7_,0,_loc4_ - _loc7_,param1.height),new Point(param2.tx + _loc7_,param2.ty + _loc5_),null,null,true);
               }
               return;
            }
            _bitmapData.draw(param1,param2,null,null,null,false);
         }
      }
   }
}

