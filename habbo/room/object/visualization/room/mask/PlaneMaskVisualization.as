package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   
   public class PlaneMaskVisualization
   {
      
      public static const const_21:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _bitmaps:Array = [];
      
      public function PlaneMaskVisualization()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneMaskBitmap = null;
         if(_bitmaps != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _bitmaps.length)
            {
               _loc1_ = _bitmaps[_loc2_] as PlaneMaskBitmap;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _bitmaps = null;
         }
      }
      
      public function addBitmap(param1:IGraphicAsset, param2:Number = -1, param3:Number = 1, param4:Number = -1, param5:Number = 1) : void
      {
         var _loc6_:PlaneMaskBitmap = new PlaneMaskBitmap(param1,param2,param3,param4,param5);
         _bitmaps.push(_loc6_);
      }
      
      public function getAsset(param1:IVector3d) : IGraphicAsset
      {
         var _loc3_:int = 0;
         var _loc2_:PlaneMaskBitmap = null;
         if(param1 == null)
         {
            return null;
         }
         _loc3_ = 0;
         while(_loc3_ < _bitmaps.length)
         {
            _loc2_ = _bitmaps[_loc3_] as PlaneMaskBitmap;
            if(_loc2_ != null)
            {
               if(param1.x >= _loc2_.normalMinX && param1.x <= _loc2_.normalMaxX && param1.y >= _loc2_.normalMinY && param1.y <= _loc2_.normalMaxY)
               {
                  return _loc2_.asset;
               }
            }
            _loc3_++;
         }
         return null;
      }
   }
}

