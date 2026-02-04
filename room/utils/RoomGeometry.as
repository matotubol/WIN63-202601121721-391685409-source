package com.sulake.room.utils
{
   import com.sulake.core.utils.class_55;
   import flash.geom.Point;
   
   public class RoomGeometry implements IRoomGeometry
   {
      
      public static const SCALE_ZOOMED_IN:Number = 64;
      
      public static const SCALE_ZOOMED_OUT:Number = 32;
      
      private var var_186:int = 0;
      
      private var var_25:Vector3d;
      
      private var var_26:Vector3d;
      
      private var var_176:Vector3d;
      
      private var _directionAxis:Vector3d;
      
      private var var_559:Vector3d;
      
      private var var_81:Vector3d;
      
      private var _depth:Vector3d;
      
      private var var_337:Number = 1;
      
      private var var_1007:Number = 1;
      
      private var var_984:Number = 1;
      
      private var var_915:Number = 1;
      
      private var _x_scale_internal:Number = 1;
      
      private var _y_scale_internal:Number = 1;
      
      private var _z_scale_internal:Number = 1;
      
      private var var_190:Vector3d;
      
      private var var_772:Vector3d;
      
      private var var_5303:Number = -500;
      
      private var var_5346:Number = 500;
      
      private var var_1033:class_55 = null;
      
      public function RoomGeometry(param1:Number, param2:IVector3d, param3:IVector3d, param4:IVector3d = null)
      {
         super();
         this.scale = param1;
         var_25 = new Vector3d();
         var_26 = new Vector3d();
         var_176 = new Vector3d();
         _directionAxis = new Vector3d();
         var_559 = new Vector3d();
         var_81 = new Vector3d();
         _depth = new Vector3d();
         _x_scale_internal = 1;
         _y_scale_internal = 1;
         x_scale = 1;
         y_scale = 1;
         _z_scale_internal = Math.sqrt(0.5) / Math.sqrt(0.75);
         z_scale = 1;
         location = new Vector3d(param3.x,param3.y,param3.z);
         direction = new Vector3d(param2.x,param2.y,param2.z);
         if(param4 != null)
         {
            setDepthVector(param4);
         }
         else
         {
            setDepthVector(param2);
         }
         var_1033 = new class_55();
      }
      
      public static function getIntersectionVector(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:IVector3d) : IVector3d
      {
         var _loc6_:Number = Vector3d.dotProduct(param2,param4);
         if(Math.abs(_loc6_) < 0.00001)
         {
            return null;
         }
         var _loc8_:Vector3d = Vector3d.dif(param1,param3);
         var _loc5_:Number = -Vector3d.dotProduct(param4,_loc8_) / _loc6_;
         return Vector3d.sum(param1,Vector3d.product(param2,_loc5_));
      }
      
      public function get updateId() : int
      {
         return var_186;
      }
      
      public function get scale() : Number
      {
         return var_337 / Math.sqrt(0.5);
      }
      
      public function get directionAxis() : IVector3d
      {
         return _directionAxis;
      }
      
      public function get location() : IVector3d
      {
         var_559.assign(var_190);
         var_559.x *= var_1007;
         var_559.y *= var_984;
         var_559.z *= var_915;
         return var_559;
      }
      
      public function get direction() : IVector3d
      {
         return var_81;
      }
      
      public function set x_scale(param1:Number) : void
      {
         if(var_1007 != param1 * _x_scale_internal)
         {
            var_1007 = param1 * _x_scale_internal;
            var_186 = var_186 + 1;
         }
      }
      
      public function set y_scale(param1:Number) : void
      {
         if(var_984 != param1 * _y_scale_internal)
         {
            var_984 = param1 * _y_scale_internal;
            var_186 = var_186 + 1;
         }
      }
      
      public function set z_scale(param1:Number) : void
      {
         if(var_915 != param1 * _z_scale_internal)
         {
            var_915 = param1 * _z_scale_internal;
            var_186 = var_186 + 1;
         }
      }
      
      public function set scale(param1:Number) : void
      {
         if(param1 <= 1)
         {
            param1 = 1;
         }
         param1 *= Math.sqrt(0.5);
         if(param1 != var_337)
         {
            var_337 = param1;
            var_186 = var_186 + 1;
         }
      }
      
      public function set location(param1:IVector3d) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(var_190 == null)
         {
            var_190 = new Vector3d();
         }
         var _loc2_:Number = var_190.x;
         var _loc3_:Number = var_190.y;
         var _loc4_:Number = var_190.z;
         var_190.assign(param1);
         var_190.x /= var_1007;
         var_190.y /= var_984;
         var_190.z /= var_915;
         if(var_190.x != _loc2_ || var_190.y != _loc3_ || var_190.z != _loc4_)
         {
            var_186 = var_186 + 1;
         }
      }
      
      public function set direction(param1:IVector3d) : void
      {
         var _loc4_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc19_:Vector3d = null;
         var _loc14_:Vector3d = null;
         var _loc2_:Vector3d = null;
         if(param1 == null)
         {
            return;
         }
         if(var_772 == null)
         {
            var_772 = new Vector3d();
         }
         var _loc7_:Number = var_772.x;
         var _loc8_:Number = var_772.y;
         var _loc9_:Number = var_772.z;
         var_772.assign(param1);
         var_81.assign(param1);
         if(var_772.x != _loc7_ || var_772.y != _loc8_ || var_772.z != _loc9_)
         {
            var_186 = var_186 + 1;
         }
         var _loc18_:Vector3d = new Vector3d(0,1,0);
         var _loc20_:Vector3d = new Vector3d(0,0,1);
         var _loc22_:Vector3d = new Vector3d(1,0,0);
         var _loc10_:Number = param1.x / 180 * 3.141592653589793;
         var _loc11_:Number = param1.y / 180 * 3.141592653589793;
         var _loc12_:Number = param1.z / 180 * 3.141592653589793;
         var _loc6_:Number = Math.cos(_loc10_);
         var _loc25_:Number = Math.sin(_loc10_);
         var _loc16_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc6_),Vector3d.product(_loc22_,-_loc25_));
         var _loc15_:Vector3d = new Vector3d(_loc20_.x,_loc20_.y,_loc20_.z);
         var _loc17_:Vector3d = Vector3d.sum(Vector3d.product(_loc18_,_loc25_),Vector3d.product(_loc22_,_loc6_));
         var _loc5_:Number = Math.cos(_loc11_);
         var _loc24_:Number = Math.sin(_loc11_);
         var _loc13_:Vector3d = new Vector3d(_loc16_.x,_loc16_.y,_loc16_.z);
         var _loc23_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc5_),Vector3d.product(_loc17_,_loc24_));
         var _loc3_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,-_loc24_),Vector3d.product(_loc17_,_loc5_));
         if(_loc12_ != 0)
         {
            _loc4_ = Math.cos(_loc12_);
            _loc21_ = Math.sin(_loc12_);
            _loc19_ = Vector3d.sum(Vector3d.product(_loc13_,_loc4_),Vector3d.product(_loc23_,_loc21_));
            _loc14_ = Vector3d.sum(Vector3d.product(_loc13_,-_loc21_),Vector3d.product(_loc23_,_loc4_));
            _loc2_ = new Vector3d(_loc3_.x,_loc3_.y,_loc3_.z);
            var_25.assign(_loc19_);
            var_26.assign(_loc14_);
            var_176.assign(_loc2_);
            _directionAxis.assign(var_176);
         }
         else
         {
            var_25.assign(_loc13_);
            var_26.assign(_loc23_);
            var_176.assign(_loc3_);
            _directionAxis.assign(var_176);
         }
      }
      
      public function dispose() : void
      {
         var_25 = null;
         var_26 = null;
         var_176 = null;
         var_190 = null;
         var_772 = null;
         _directionAxis = null;
         var_559 = null;
         if(var_1033 != null)
         {
            var_1033.dispose();
            var_1033 = null;
         }
      }
      
      public function setDisplacement(param1:IVector3d, param2:IVector3d) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(var_1033 != null)
         {
            var _loc4_:String = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            var_1033.remove(null);
            var _loc3_:Vector3d = new Vector3d();
            null.assign(param2);
            var_1033.add(null,null);
            var_186 = var_186 + 1;
         }
      }
      
      private function getDisplacenent(param1:IVector3d) : IVector3d
      {
         if(var_1033 != null)
         {
            var _loc2_:String = int(Math.round(param1.x)) + "_" + int(Math.round(param1.y)) + "_" + int(Math.round(param1.z));
            return var_1033.getValue(null);
         }
         return null;
      }
      
      public function setDepthVector(param1:IVector3d) : void
      {
         var _loc9_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc16_:Vector3d = null;
         var _loc7_:Vector3d = null;
         var _loc4_:Vector3d = null;
         var _loc15_:Vector3d = new Vector3d(0,1,0);
         var _loc17_:Vector3d = new Vector3d(0,0,1);
         var _loc19_:Vector3d = new Vector3d(1,0,0);
         var _loc2_:Number = param1.x / 180 * 3.141592653589793;
         var _loc3_:Number = param1.y / 180 * 3.141592653589793;
         var _loc5_:Number = param1.z / 180 * 3.141592653589793;
         var _loc11_:Number = Math.cos(_loc2_);
         var _loc22_:Number = Math.sin(_loc2_);
         var _loc13_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc11_),Vector3d.product(_loc19_,-_loc22_));
         var _loc12_:Vector3d = new Vector3d(_loc17_.x,_loc17_.y,_loc17_.z);
         var _loc14_:Vector3d = Vector3d.sum(Vector3d.product(_loc15_,_loc22_),Vector3d.product(_loc19_,_loc11_));
         var _loc10_:Number = Math.cos(_loc3_);
         var _loc21_:Number = Math.sin(_loc3_);
         var _loc6_:Vector3d = new Vector3d(_loc13_.x,_loc13_.y,_loc13_.z);
         var _loc20_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,_loc10_),Vector3d.product(_loc14_,_loc21_));
         var _loc8_:Vector3d = Vector3d.sum(Vector3d.product(_loc12_,-_loc21_),Vector3d.product(_loc14_,_loc10_));
         if(_loc5_ != 0)
         {
            _loc9_ = Math.cos(_loc5_);
            _loc18_ = Math.sin(_loc5_);
            _loc16_ = Vector3d.sum(Vector3d.product(_loc6_,_loc9_),Vector3d.product(_loc20_,_loc18_));
            _loc7_ = Vector3d.sum(Vector3d.product(_loc6_,-_loc18_),Vector3d.product(_loc20_,_loc9_));
            _loc4_ = new Vector3d(_loc8_.x,_loc8_.y,_loc8_.z);
            _depth.assign(_loc4_);
         }
         else
         {
            _depth.assign(_loc8_);
         }
         var_186 = var_186 + 1;
      }
      
      public function adjustLocation(param1:IVector3d, param2:Number) : void
      {
         if(param1 == null || var_176 == null)
         {
            return;
         }
         var _loc4_:Vector3d = Vector3d.product(var_176,-param2);
         var _loc3_:Vector3d = new Vector3d(param1.x + _loc4_.x,param1.y + _loc4_.y,param1.z + _loc4_.z);
         location = _loc3_;
      }
      
      public function getCoordinatePosition(param1:IVector3d) : IVector3d
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(param1,var_25);
         var _loc4_:Number = Vector3d.scalarProjection(param1,var_26);
         var _loc5_:Number = Vector3d.scalarProjection(param1,var_176);
         return new Vector3d(_loc3_,_loc4_,_loc5_);
      }
      
      public function getScreenPosition(param1:IVector3d) : IVector3d
      {
         var _loc2_:Vector3d = Vector3d.dif(param1,var_190);
         _loc2_.x *= var_1007;
         _loc2_.y *= var_984;
         _loc2_.z *= var_915;
         var _loc5_:Number = Vector3d.scalarProjection(_loc2_,_depth);
         if(_loc5_ < var_5303 || _loc5_ > var_5346)
         {
            return null;
         }
         var _loc3_:Number = Vector3d.scalarProjection(_loc2_,var_25);
         var _loc4_:Number = -Vector3d.scalarProjection(_loc2_,var_26);
         _loc3_ *= var_337;
         _loc4_ *= var_337;
         var _loc6_:IVector3d = getDisplacenent(param1);
         if(_loc6_ != null)
         {
            _loc2_ = Vector3d.dif(param1,var_190);
            _loc2_.add(_loc6_);
            _loc2_.x *= var_1007;
            _loc2_.y *= var_984;
            _loc2_.z *= var_915;
            _loc5_ = Vector3d.scalarProjection(_loc2_,_depth);
         }
         _loc2_.x = _loc3_;
         _loc2_.y = _loc4_;
         _loc2_.z = _loc5_;
         return _loc2_;
      }
      
      public function getScreenPoint(param1:IVector3d) : Point
      {
         var _loc2_:IVector3d = getScreenPosition(param1);
         if(_loc2_ == null)
         {
            return null;
         }
         return new Point(_loc2_.x,_loc2_.y);
      }
      
      public function getPlanePosition(param1:Point, param2:IVector3d, param3:IVector3d, param4:IVector3d) : Point
      {
         var _loc10_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc14_:Number = param1.x / var_337;
         var _loc16_:Number = -param1.y / var_337;
         var _loc6_:Vector3d = Vector3d.product(var_25,_loc14_);
         _loc6_.add(Vector3d.product(var_26,_loc16_));
         var _loc8_:Vector3d = new Vector3d(var_190.x * var_1007,var_190.y * var_984,var_190.z * var_915);
         _loc8_.add(_loc6_);
         var _loc15_:IVector3d = var_176;
         var _loc5_:Vector3d = new Vector3d(param2.x * var_1007,param2.y * var_984,param2.z * var_915);
         var _loc13_:Vector3d = new Vector3d(param3.x * var_1007,param3.y * var_984,param3.z * var_915);
         var _loc7_:Vector3d = new Vector3d(param4.x * var_1007,param4.y * var_984,param4.z * var_915);
         var _loc11_:IVector3d = Vector3d.crossProduct(_loc13_,_loc7_);
         var _loc9_:Vector3d = new Vector3d();
         _loc9_.assign(RoomGeometry.getIntersectionVector(_loc8_,_loc15_,_loc5_,_loc11_));
         if(_loc9_ != null)
         {
            _loc9_.sub(_loc5_);
            _loc10_ = Vector3d.scalarProjection(_loc9_,param3) / _loc13_.length * param3.length;
            _loc12_ = Vector3d.scalarProjection(_loc9_,param4) / _loc7_.length * param4.length;
            return new Point(_loc10_,_loc12_);
         }
         return null;
      }
      
      public function performZoom() : void
      {
         if(isZoomedIn())
         {
            scale = 32;
         }
         else
         {
            scale = 64;
         }
      }
      
      public function isZoomedIn() : Boolean
      {
         return scale == 64;
      }
      
      public function performZoomOut() : void
      {
         scale = 32;
      }
      
      public function performZoomIn() : void
      {
         scale = 64;
      }
   }
}

