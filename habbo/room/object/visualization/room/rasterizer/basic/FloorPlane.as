package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class FloorPlane extends Plane
   {
      
      public static const DEFAULT_COLOR:uint = 16777215;
      
      public static const HORIZONTAL_ANGLE_DEFAULT:Number = 45;
      
      public static const VERTICAL_ANGLE_DEFAULT:Number = 30;
      
      public function FloorPlane()
      {
         super();
      }
      
      public function render(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:IVector3d, param6:Boolean, param7:Number, param8:Number) : BitmapData
      {
         var _loc14_:Number = NaN;
         var _loc10_:PlaneVisualization = getPlaneVisualization(param4);
         if(_loc10_ == null || _loc10_.geometry == null)
         {
            return null;
         }
         var _loc11_:Point = _loc10_.geometry.getScreenPoint(new Vector3d(0,0,0));
         var _loc12_:Point = _loc10_.geometry.getScreenPoint(new Vector3d(0,param3 / _loc10_.geometry.scale,0));
         var _loc13_:Point = _loc10_.geometry.getScreenPoint(new Vector3d(param2 / _loc10_.geometry.scale,0,0));
         var _loc9_:int = 0;
         var _loc15_:int = 0;
         if(_loc11_ != null && _loc12_ != null && _loc13_ != null)
         {
            param2 = Math.round(Math.abs(_loc11_.x - _loc13_.x));
            param3 = Math.round(Math.abs(_loc11_.x - _loc12_.x));
            _loc14_ = _loc11_.x - _loc10_.geometry.getScreenPoint(new Vector3d(1,0,0)).x;
            _loc9_ = param7 * int(Math.abs(_loc14_));
            _loc15_ = param8 * int(Math.abs(_loc14_));
         }
         return _loc10_.render(param1,param2,param3,param5,param6,_loc9_,_loc15_);
      }
   }
}

