package com.sulake.habbo.room.object.visualization.room.mask
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   
   public class PlaneMask
   {
      
      private var var_921:class_55;
      
      private var var_467:Array = [];
      
      private var var_770:class_55;
      
      private var var_1712:PlaneMaskVisualization = null;
      
      private var var_3517:int = -1;
      
      public function PlaneMask()
      {
         super();
         var_921 = new class_55();
         var_770 = new class_55();
      }
      
      public function dispose() : void
      {
         var _loc2_:PlaneMaskVisualization = null;
         var _loc1_:int = 0;
         if(var_921 != null)
         {
            _loc2_ = null;
            _loc1_ = 0;
            while(_loc1_ < var_921.length)
            {
               _loc2_ = var_921.getWithIndex(_loc1_) as PlaneMaskVisualization;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_921.dispose();
            var_921 = null;
         }
         var_1712 = null;
         var_467 = null;
      }
      
      public function createMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(var_921.getValue(String(param1)) != null)
         {
            return null;
         }
         var _loc2_:PlaneMaskVisualization = new PlaneMaskVisualization();
         var_921.add(String(param1),_loc2_);
         var_467.push(param1);
         var_467.sort();
         return _loc2_;
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
      
      protected function getMaskVisualization(param1:int) : PlaneMaskVisualization
      {
         if(param1 == var_3517)
         {
            return var_1712;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < var_467.length)
         {
            var_1712 = var_921.getValue(String(var_467[_loc2_])) as PlaneMaskVisualization;
         }
         else
         {
            var_1712 = null;
         }
         var_3517 = param1;
         return var_1712;
      }
      
      public function getGraphicAsset(param1:Number, param2:IVector3d) : IGraphicAsset
      {
         var _loc3_:PlaneMaskVisualization = getMaskVisualization(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getAsset(param2);
      }
      
      public function getAssetName(param1:int) : String
      {
         return var_770.getValue(param1);
      }
      
      public function setAssetName(param1:int, param2:String) : void
      {
         var_770.add(param1,param2);
      }
   }
}

