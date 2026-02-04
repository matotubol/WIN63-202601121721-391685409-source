package com.sulake.habbo.room.object.visualization.room
{
   import com.sulake.habbo.room.object.visualization.room.mask.PlaneMaskManager;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.animated.LandscapeRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.FloorRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallAdRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.basic.WallRasterizer;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.class_3227;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.class_1805;
   
   public class RoomVisualizationData implements IRoomObjectVisualizationData
   {
      
      private var var_981:WallRasterizer;
      
      private var var_910:FloorRasterizer;
      
      private var var_1470:WallAdRasterizer;
      
      private var var_1010:LandscapeRasterizer;
      
      private var var_1391:PlaneMaskManager;
      
      private var var_704:Boolean = false;
      
      public function RoomVisualizationData()
      {
         super();
         var_981 = new WallRasterizer();
         var_910 = new FloorRasterizer();
         var_1470 = new WallAdRasterizer();
         var_1010 = new LandscapeRasterizer();
         var_1391 = new PlaneMaskManager();
      }
      
      public function get initialized() : Boolean
      {
         return var_704;
      }
      
      public function get floorRasterizer() : class_3227
      {
         return var_910;
      }
      
      public function get wallRasterizer() : class_3227
      {
         return var_981;
      }
      
      public function get wallAdRasterizr() : WallAdRasterizer
      {
         return var_1470;
      }
      
      public function get landscapeRasterizer() : class_3227
      {
         return var_1010;
      }
      
      public function get maskManager() : PlaneMaskManager
      {
         return var_1391;
      }
      
      public function dispose() : void
      {
         if(var_981 != null)
         {
            var_981.dispose();
            var_981 = null;
         }
         if(var_910 != null)
         {
            var_910.dispose();
            var_910 = null;
         }
         if(var_1470 != null)
         {
            var_1470.dispose();
            var_1470 = null;
         }
         if(var_1010 != null)
         {
            var_1010.dispose();
            var_1010 = null;
         }
         if(var_1391 != null)
         {
            var_1391.dispose();
            var_1391 = null;
         }
      }
      
      public function clearCache() : void
      {
         if(var_981 != null)
         {
            var_981.clearCache();
         }
         if(var_910 != null)
         {
            var_910.clearCache();
         }
         if(var_1010 != null)
         {
            var_1010.clearCache();
         }
      }
      
      public function initialize(param1:XML) : Boolean
      {
         var _loc4_:XML = null;
         var _loc3_:XML = null;
         var _loc7_:XML = null;
         var _loc11_:XML = null;
         var _loc6_:XML = null;
         reset();
         if(param1 == null)
         {
            return false;
         }
         var _loc5_:XMLList = param1.wallData;
         if(_loc5_.length() > 0)
         {
            _loc4_ = _loc5_[0];
            var_981.initialize(_loc4_);
         }
         var _loc2_:XMLList = param1.floorData;
         if(_loc2_.length() > 0)
         {
            _loc3_ = _loc2_[0];
            var_910.initialize(_loc3_);
         }
         var _loc10_:XMLList = param1.wallAdData;
         if(_loc10_.length() > 0)
         {
            _loc7_ = _loc10_[0];
            var_1470.initialize(_loc7_);
         }
         var _loc8_:XMLList = param1.landscapeData;
         if(_loc8_.length() > 0)
         {
            _loc11_ = _loc8_[0];
            var_1010.initialize(_loc11_);
         }
         var _loc9_:XMLList = param1.maskData;
         if(_loc9_.length() > 0)
         {
            _loc6_ = _loc9_[0];
            var_1391.initialize(_loc6_);
         }
         return true;
      }
      
      public function initializeAssetCollection(param1:class_1805) : void
      {
         if(var_704)
         {
            return;
         }
         var_981.initializeAssetCollection(param1);
         var_910.initializeAssetCollection(param1);
         var_1470.initializeAssetCollection(param1);
         var_1010.initializeAssetCollection(param1);
         var_1391.initializeAssetCollection(param1);
         var_704 = true;
      }
      
      protected function reset() : void
      {
      }
   }
}

