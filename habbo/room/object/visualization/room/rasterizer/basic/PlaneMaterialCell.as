package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneMaterialCell
   {
      
      private var var_53:BitmapData = null;
      
      private var var_781:PlaneTexture;
      
      private var var_1715:Array = [];
      
      private var var_1495:Array = [];
      
      private var var_2273:int = 0;
      
      public function PlaneMaterialCell(param1:PlaneTexture, param2:Array = null, param3:Array = null, param4:int = 0)
      {
         super();
         var_781 = param1;
         if(param2 != null && param2.length > 0 && param4 > 0)
         {
            var _loc6_:int = 0;
            _loc6_ = 0;
            while(0 < param2.length)
            {
               var _loc7_:IGraphicAsset = param2[0] as IGraphicAsset;
               if(_loc7_ != null)
               {
                  var_1495.push(null);
               }
               _loc6_++;
            }
            if(var_1495.length > 0)
            {
               if(param3 != null)
               {
                  _loc6_ = 0;
                  while(0 < param3.length)
                  {
                     var _loc5_:Point = param3[0] as Point;
                     if(_loc5_ != null)
                     {
                        var_1715.push(new Point(null.x,null.y));
                     }
                     _loc6_++;
                  }
               }
               var_2273 = param4;
            }
         }
      }
      
      public function get isStatic() : Boolean
      {
         return var_2273 == 0;
      }
      
      public function dispose() : void
      {
         if(var_781 != null)
         {
            var_781.dispose();
            var_781 = null;
         }
         if(var_53 != null)
         {
            var_53.dispose();
            var_53 = null;
         }
         var_1495 = null;
         var_1715 = null;
      }
      
      public function clearCache() : void
      {
         if(var_53 != null)
         {
            var_53.dispose();
            var_53 = null;
         }
      }
      
      public function getHeight(param1:IVector3d) : int
      {
         if(var_781 != null)
         {
            var _loc2_:BitmapData = var_781.getBitmap(param1);
         }
         return 0;
      }
      
      public function render(param1:IVector3d, param2:int, param3:int) : BitmapData
      {
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc15_:Number = NaN;
         if(var_781 != null)
         {
            var _loc16_:BitmapData = var_781.getBitmap(param1);
            try
            {
            }
            catch(e:Error)
            {
               return null;
            }
         }
         return null;
      }
      
      public function getAssetName(param1:IVector3d) : String
      {
         return var_781 == null ? null : var_781.getAssetName(param1);
      }
   }
}

