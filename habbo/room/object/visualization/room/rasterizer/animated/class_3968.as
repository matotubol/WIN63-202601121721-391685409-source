package com.sulake.habbo.room.object.visualization.room.rasterizer.animated
{
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.Plane;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.PlaneVisualization;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class class_3968 extends Plane
   {
      
      public static const DEFAULT_COLOR:uint = 16777215;
      
      public static const HORIZONTAL_ANGLE_DEFAULT:Number = 45;
      
      public static const VERTICAL_ANGLE_DEFAULT:Number = 30;
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      public function class_3968()
      {
         super();
      }
      
      override public function isStatic(param1:int) : Boolean
      {
         var _loc2_:PlaneVisualization = getPlaneVisualization(param1);
         if(_loc2_ != null)
         {
            return !_loc2_.hasAnimationLayers;
         }
         return super.isStatic(param1);
      }
      
      public function initializeDimensions(param1:int, param2:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 0)
         {
            param2 = 0;
         }
         if(param1 != _width || param2 != var_385)
         {
            _width = param1;
            var_385 = param2;
         }
      }
      
      public function render(param1:BitmapData, param2:Number, param3:Number, param4:Number, param5:IVector3d, param6:Boolean, param7:Number, param8:Number, param9:Number, param10:Number, param11:int) : BitmapData
      {
         var _loc12_:int = 0;
         var _loc20_:int = 0;
         var _loc19_:int = 0;
         var _loc18_:int = 0;
         var _loc17_:* = null;
         var _loc13_:PlaneVisualization = getPlaneVisualization(param4);
         if(_loc13_ == null || _loc13_.geometry == null)
         {
            return null;
         }
         var _loc14_:Point = _loc13_.geometry.getScreenPoint(new Vector3d(0,0,0));
         var _loc15_:Point = _loc13_.geometry.getScreenPoint(new Vector3d(0,0,1));
         var _loc16_:Point = _loc13_.geometry.getScreenPoint(new Vector3d(0,1,0));
         if(_loc14_ != null && _loc15_ != null && _loc16_ != null)
         {
            param2 = Math.round(Math.abs((_loc14_.x - _loc16_.x) * param2 / _loc13_.geometry.scale));
            param3 = Math.round(Math.abs((_loc14_.y - _loc15_.y) * param3 / _loc13_.geometry.scale));
            _loc12_ = param7 * Math.abs(_loc14_.x - _loc16_.x);
            _loc20_ = param8 * Math.abs(_loc14_.y - _loc15_.y);
            _loc19_ = param9 * Math.abs(_loc14_.x - _loc16_.x);
            _loc18_ = param10 * Math.abs(_loc14_.y - _loc15_.y);
            return _loc13_.render(param1,param2,param3,param5,param6,_loc12_,_loc20_,_loc19_,_loc18_,param9,param10,param11);
         }
         return null;
      }
   }
}

