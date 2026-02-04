package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.assets.AssetLibrary;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class FurnitureCuboidVisualization extends RoomObjectSpriteVisualization
   {
      
      private var var_909:AssetLibrary = null;
      
      private var var_152:Array = [];
      
      private var var_3245:Boolean = false;
      
      private var var_2155:int = 0;
      
      public function FurnitureCuboidVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FurniturePlane = null;
         super.dispose();
         if(var_909 != null)
         {
            var_909.dispose();
            var_909 = null;
         }
         if(var_152 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_152.length)
            {
               _loc1_ = var_152[_loc2_] as FurniturePlane;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_152 = null;
         }
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         return true;
      }
      
      protected function defineSprites() : void
      {
         createSprites(1);
      }
      
      protected function initializePlanes() : void
      {
         var _loc4_:IVector3d = null;
         var _loc1_:FurniturePlane = null;
         if(var_3245)
         {
            return;
         }
         var _loc6_:IRoomObject = object;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc2_:Number = _loc6_.getModel().getNumber("furniture_size_x");
         var _loc9_:Number = _loc6_.getModel().getNumber("furniture_size_y");
         var _loc10_:Number = _loc6_.getModel().getNumber("furniture_size_z");
         if(isNaN(_loc2_) || isNaN(_loc9_) || isNaN(_loc10_))
         {
            return;
         }
         var _loc5_:Vector3d = new Vector3d(_loc2_,0,0);
         var _loc7_:Vector3d = new Vector3d(0,_loc9_,0);
         var _loc3_:Vector3d = new Vector3d(-0.5,-0.5,0);
         if(_loc3_ != null && _loc5_ != null && _loc7_ != null)
         {
            _loc4_ = Vector3d.crossProduct(_loc5_,_loc7_);
            _loc1_ = new FurniturePlane(_loc3_,_loc5_,_loc7_);
            _loc1_.color = 16776960;
            var_152.push(_loc1_);
            var_3245 = true;
            defineSprites();
            return;
         }
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         var _loc5_:IRoomObject = object;
         if(_loc5_ == null)
         {
            return;
         }
         if(var_909 == null)
         {
            var_909 = new AssetLibrary("furniture cuboid visualization - " + _loc5_.getInstanceId());
         }
         if(param1 == null)
         {
            return;
         }
         initializePlanes();
         updatePlanes(param1,param2);
      }
      
      protected function updatePlanes(param1:IRoomGeometry, param2:int) : void
      {
         var _loc10_:IRoomObject = object;
         if(_loc10_ == null)
         {
            return;
         }
         if(param1 == null || var_909 == null)
         {
            return;
         }
         var_2155 = var_2155 + 1;
         var _loc4_:int = param2;
         var _loc6_:int = 0;
         while(0 < var_152.length)
         {
            var _loc7_:Boolean = false;
            var _loc13_:String = "plane " + 0 + " " + param1.scale;
            var _loc14_:BitmapDataAsset = var_909.getAssetByName(null) as BitmapDataAsset;
            if(_loc14_ == null)
            {
               _loc14_ = new BitmapDataAsset(var_909.getAssetTypeDeclarationByClass(BitmapDataAsset));
               var_909.setAsset(null,null);
            }
            var _loc3_:FurniturePlane = var_152[0] as FurniturePlane;
            _loc14_ = null;
            var _loc12_:IRoomObjectSprite = getSprite(0);
            if(_loc12_ != null)
            {
               null.visible = false;
               null.asset = null;
               null.relativeDepth = null.relativeDepth;
            }
            _loc6_++;
         }
      }
   }
}

