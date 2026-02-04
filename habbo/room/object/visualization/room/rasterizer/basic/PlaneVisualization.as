package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.PlaneVisualizationAnimationLayer;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneVisualization
   {
      
      private var _layers:Array = [];
      
      private var _geometry:IRoomGeometry = null;
      
      private var var_53:BitmapData;
      
      private var _cachedBitmapNormal:Vector3d = null;
      
      private var var_2904:Boolean = false;
      
      private var _hasAnimationLayers:Boolean = false;
      
      public function PlaneVisualization(param1:Number, param2:int, param3:IRoomGeometry)
      {
         super();
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc4_:int = 0;
         while(0 < param2)
         {
            _layers.push(null);
            _loc4_++;
         }
         _geometry = param3;
         _cachedBitmapNormal = new Vector3d();
      }
      
      public function get geometry() : IRoomGeometry
      {
         return _geometry;
      }
      
      public function get hasAnimationLayers() : Boolean
      {
         return _hasAnimationLayers;
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:class_13 = null;
         if(_layers != null)
         {
            _loc1_ = 0;
            while(_loc1_ < _layers.length)
            {
               _loc2_ = _layers[_loc1_] as class_13;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            _layers = null;
         }
         _geometry = null;
         if(var_53 != null)
         {
            var_53.dispose();
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal = null;
         }
      }
      
      public function clearCache() : void
      {
         var _loc2_:int = 0;
         var _loc3_:PlaneVisualizationLayer = null;
         var _loc1_:PlaneVisualizationAnimationLayer = null;
         if(!var_2904)
         {
            return;
         }
         if(var_53 != null)
         {
            var_53.dispose();
            var_53 = null;
         }
         if(_cachedBitmapNormal != null)
         {
            _cachedBitmapNormal.assign(new Vector3d());
         }
         if(_layers != null)
         {
            _loc2_ = 0;
            while(_loc2_ < _layers.length)
            {
               _loc3_ = _layers[_loc2_] as PlaneVisualizationLayer;
               _loc1_ = _layers[_loc2_] as PlaneVisualizationAnimationLayer;
               if(_loc3_ != null)
               {
                  _loc3_.clearCache();
               }
               else if(_loc1_ != null)
               {
                  _loc1_.clearCache();
               }
               _loc2_++;
            }
         }
         var_2904 = false;
      }
      
      public function setLayer(param1:int, param2:PlaneMaterial, param3:uint, param4:int, param5:int = 0) : Boolean
      {
         if(param1 < 0 || param1 > _layers.length)
         {
            return false;
         }
         var _loc6_:class_13 = _layers[param1] as class_13;
         if(_loc6_ != null)
         {
            _loc6_.dispose();
            _loc6_ = null;
         }
         _loc6_ = new PlaneVisualizationLayer(param2,param3,param4,param5);
         _layers[param1] = _loc6_;
         return true;
      }
      
      public function setAnimationLayer(param1:int, param2:XML, param3:class_1805) : Boolean
      {
         if(param1 < 0 || param1 > _layers.length)
         {
            return false;
         }
         var _loc4_:class_13 = _layers[param1] as class_13;
         if(_loc4_ != null)
         {
            _loc4_.dispose();
            _loc4_ = null;
         }
         _loc4_ = new PlaneVisualizationAnimationLayer(param2,param3);
         _layers[param1] = _loc4_;
         _hasAnimationLayers = true;
         return true;
      }
      
      public function getLayers() : Array
      {
         return _layers;
      }
      
      public function render(param1:BitmapData, param2:int, param3:int, param4:IVector3d, param5:Boolean, param6:int = 0, param7:int = 0, param8:int = 0, param9:int = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : BitmapData
      {
         if(param2 < 1)
         {
            param2 = 1;
         }
         if(param3 < 1)
         {
            param3 = 1;
         }
         if(param1 == null || param1.width != param2 || param1.height != param3)
         {
            param1 = null;
         }
         if(var_53 != null)
         {
            try
            {
               if(var_53.width == param2 && var_53.height == param3 && Vector3d.isEqual(_cachedBitmapNormal,param4))
               {
                  if(!hasAnimationLayers)
                  {
                     if(param1 != null)
                     {
                        param1.copyPixels(var_53,var_53.rect,new Point(0,0),null,null,false);
                        return param1;
                     }
                     return var_53;
                  }
               }
               else
               {
                  var_53.dispose();
                  var_53 = null;
               }
            }
            catch(e:Error)
            {
               var_53.dispose();
               var_53 = null;
               return null;
            }
         }
         var_2904 = true;
         if(var_53 == null)
         {
            try
            {
               var_53 = new BitmapData(param2,param3,true,16777215);
            }
            catch(e:Error)
            {
               if(var_53)
               {
                  var_53.dispose();
               }
               var_53 = null;
               return null;
            }
         }
         else
         {
            var_53.fillRect(var_53.rect,16777215);
         }
         if(param1 == null)
         {
            param1 = var_53;
         }
         _cachedBitmapNormal.assign(param4);
         var _loc14_:int = 0;
         while(0 < _layers.length)
         {
            var _loc15_:PlaneVisualizationLayer = _layers[0] as PlaneVisualizationLayer;
            var _loc13_:PlaneVisualizationAnimationLayer = _layers[0] as PlaneVisualizationAnimationLayer;
            _loc14_++;
         }
         if(param1 != null && param1 != var_53)
         {
            var_53.copyPixels(param1,param1.rect,new Point(0,0),null,null,false);
            return param1;
         }
         return var_53;
      }
   }
}

