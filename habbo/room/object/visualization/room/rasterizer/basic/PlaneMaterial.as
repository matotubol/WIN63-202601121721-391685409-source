package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   
   public class PlaneMaterial
   {
      
      public static const const_21:Number = -1;
      
      public static const MAX_NORMAL_COORDINATE_VALUE:Number = 1;
      
      private var _planeMaterialItems:Array = [];
      
      private var var_2904:Boolean = false;
      
      public function PlaneMaterial()
      {
         super();
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneMaterialCellMatrix = null;
         if(_planeMaterialItems != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _planeMaterialItems.length)
            {
               _loc1_ = _planeMaterialItems[_loc2_] as PlaneMaterialCellMatrix;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            _planeMaterialItems = null;
         }
      }
      
      public function clearCache() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneMaterialCellMatrix = null;
         if(!var_2904)
         {
            return;
         }
         if(_planeMaterialItems != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _planeMaterialItems.length)
            {
               _loc1_ = _planeMaterialItems[_loc2_] as PlaneMaterialCellMatrix;
               if(_loc1_ != null)
               {
                  _loc1_.clearCache();
               }
               _loc2_++;
            }
         }
         var_2904 = false;
      }
      
      public function addMaterialCellMatrix(param1:int, param2:int, param3:int, param4:Number = -1, param5:Number = 1, param6:Number = -1, param7:Number = 1) : PlaneMaterialCellMatrix
      {
         var _loc8_:PlaneMaterialCellMatrix = null;
         _loc8_ = new PlaneMaterialCellMatrix(param1,param2,param3,param4,param5,param6,param7);
         _planeMaterialItems.push(_loc8_);
         return _loc8_;
      }
      
      public function getMaterialCellMatrix(param1:IVector3d) : PlaneMaterialCellMatrix
      {
         var _loc2_:int = 0;
         var _loc3_:PlaneMaterialCellMatrix = null;
         if(param1 == null)
         {
            return null;
         }
         _loc2_ = 0;
         while(_loc2_ < _planeMaterialItems.length)
         {
            _loc3_ = _planeMaterialItems[_loc2_] as PlaneMaterialCellMatrix;
            if(_loc3_ != null)
            {
               if(param1.x >= _loc3_.normalMinX && param1.x <= _loc3_.normalMaxX && param1.y >= _loc3_.normalMinY && param1.y <= _loc3_.normalMaxY)
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int, param7:int, param8:Boolean) : BitmapData
      {
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(param3 < 1)
         {
            param3 = 1;
         }
         var _loc9_:PlaneMaterialCellMatrix = getMaterialCellMatrix(param4);
         if(_loc9_ != null)
         {
            var_2904 = true;
            return _loc9_.render(param1,param2,param3,param4,param5,param6,param7,param8);
         }
         return null;
      }
   }
}

