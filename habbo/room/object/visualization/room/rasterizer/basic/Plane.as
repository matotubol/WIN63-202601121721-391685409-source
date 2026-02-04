package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class Plane
   {
      
      private var var_670:class_55;
      
      private var var_467:Array = [];
      
      private var var_1564:PlaneVisualization = null;
      
      private var var_3517:int = -1;
      
      public function Plane()
      {
         super();
         var_670 = new class_55();
      }
      
      public function isStatic(param1:int) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         var _loc1_:PlaneVisualization = null;
         var _loc2_:int = 0;
         if(var_670 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < var_670.length)
            {
               _loc1_ = var_670.getWithIndex(_loc2_) as PlaneVisualization;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_670.dispose();
            var_670 = null;
         }
         var_1564 = null;
         var_467 = null;
      }
      
      public function clearCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneVisualization = null;
         _loc2_ = 0;
         while(_loc2_ < var_670.length)
         {
            _loc1_ = var_670.getWithIndex(_loc2_) as PlaneVisualization;
            if(_loc1_ != null)
            {
               _loc1_.clearCache();
            }
            _loc2_++;
         }
      }
      
      public function createPlaneVisualization(param1:int, param2:int, param3:IRoomGeometry) : PlaneVisualization
      {
         if(var_670.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc4_:PlaneVisualization = new PlaneVisualization(param1,param2,param3);
         var_670.add(String(param1),_loc4_);
         var_467.push(param1);
         var_467.sort();
         return _loc4_;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         _loc3_ = 1;
         while(_loc3_ < var_467.length)
         {
            if(var_467[_loc3_] > param1)
            {
               if(var_467[_loc3_] - param1 < param1 - var_467[_loc3_ - 1])
               {
                  _loc2_ = _loc3_;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function getPlaneVisualization(param1:int) : PlaneVisualization
      {
         if(param1 == var_3517)
         {
            return var_1564;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < var_467.length)
         {
            var_1564 = var_670.getValue(String(var_467[_loc2_])) as PlaneVisualization;
         }
         else
         {
            var_1564 = null;
         }
         var_3517 = param1;
         return var_1564;
      }
      
      public function getLayers() : Array
      {
         return getPlaneVisualization(var_3517).getLayers();
      }
   }
}

