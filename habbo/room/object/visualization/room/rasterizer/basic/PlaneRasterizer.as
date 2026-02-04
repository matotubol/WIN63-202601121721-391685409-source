package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.object.visualization.room.rasterizer.class_3227;
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.class_2119;
   import com.sulake.room.utils.class_4038;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PlaneRasterizer implements class_3227
   {
      
      protected static const DEFAULT_TYPE:String = "default";
      
      private var var_1373:class_1805 = null;
      
      private var _materials:class_55 = null;
      
      private var var_365:class_55 = null;
      
      private var var_152:class_55 = null;
      
      private var var_1111:class_55 = null;
      
      private var var_24:XML = null;
      
      public function PlaneRasterizer()
      {
         super();
         var_365 = new class_55();
         _materials = new class_55();
         var_152 = new class_55();
         var_1111 = new class_55();
      }
      
      protected function get data() : XML
      {
         return var_24;
      }
      
      protected function get assetCollection() : class_1805
      {
         return var_1373;
      }
      
      public function initializeDimensions(param1:int, param2:int) : Boolean
      {
         return true;
      }
      
      public function dispose() : void
      {
         var _loc1_:Plane = null;
         var _loc3_:RoomGeometry = null;
         var _loc2_:int = 0;
         if(var_152 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_152.length)
            {
               _loc1_ = var_152.getWithIndex(_loc2_) as Plane;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_152.dispose();
            var_152 = null;
         }
         if(_materials != null)
         {
            resetMaterials();
            _materials.dispose();
            _materials = null;
         }
         if(var_365 != null)
         {
            resetTextures();
            var_365.dispose();
            var_365 = null;
         }
         if(var_1111 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_1111.length)
            {
               _loc3_ = var_1111.getWithIndex(_loc2_);
               if(_loc3_ != null)
               {
                  _loc3_.dispose();
               }
               _loc2_++;
            }
            var_1111.dispose();
            var_1111 = null;
         }
         var_24 = null;
         var_1373 = null;
      }
      
      public function clearCache() : void
      {
         var _loc1_:Plane = null;
         var _loc2_:PlaneMaterial = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < var_152.length)
         {
            _loc1_ = var_152.getWithIndex(_loc3_) as Plane;
            if(_loc1_ != null)
            {
               _loc1_.clearCache();
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < _materials.length)
         {
            _loc2_ = _materials.getWithIndex(_loc3_) as PlaneMaterial;
            if(_loc2_ != null)
            {
               _loc2_.clearCache();
            }
            _loc3_++;
         }
      }
      
      public function initialize(param1:XML) : void
      {
         var_24 = param1;
      }
      
      public function reinitialize() : void
      {
         resetTextures();
         resetMaterials();
         initializeAll();
      }
      
      private function resetMaterials() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneMaterial = null;
         _loc2_ = 0;
         while(_loc2_ < _materials.length)
         {
            _loc1_ = _materials.getWithIndex(_loc2_) as PlaneMaterial;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         _materials.reset();
      }
      
      private function resetTextures() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PlaneTexture = null;
         _loc2_ = 0;
         while(_loc2_ < var_365.length)
         {
            _loc1_ = var_365.getWithIndex(_loc2_) as PlaneTexture;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         var_365.reset();
      }
      
      protected function getTexture(param1:String) : PlaneTexture
      {
         return var_365.getValue(param1) as PlaneTexture;
      }
      
      protected function getMaterial(param1:String) : PlaneMaterial
      {
         return _materials.getValue(param1) as PlaneMaterial;
      }
      
      protected function getPlane(param1:String) : Plane
      {
         return var_152.getValue(param1);
      }
      
      protected function addPlane(param1:String, param2:Plane) : Boolean
      {
         if(param2 == null)
         {
            return false;
         }
         if(var_152.getValue(param1) == null)
         {
            var_152.add(param1,param2);
            return true;
         }
         return false;
      }
      
      public function initializeAssetCollection(param1:class_1805) : void
      {
         if(data == null)
         {
            return;
         }
         var_1373 = param1;
         initializeAll();
      }
      
      private function initializeAll() : void
      {
         if(data == null)
         {
            return;
         }
         initializeTexturesAndMaterials();
         initializePlanes();
      }
      
      private function initializeTexturesAndMaterials() : void
      {
         var _loc2_:XMLList = data.textures;
         if(_loc2_.length() > 0)
         {
            parseTextures(_loc2_[0],assetCollection);
         }
         var _loc1_:XMLList = data.materials;
         if(_loc1_.length() > 0)
         {
            parsePlaneMaterials(_loc1_[0]);
         }
      }
      
      protected function initializePlanes() : void
      {
      }
      
      private function parseTextures(param1:XML, param2:class_1805) : void
      {
         var _loc7_:int = 0;
         var _loc6_:XML = null;
         var _loc16_:String = null;
         var _loc4_:PlaneTexture = null;
         var _loc3_:XMLList = null;
         var _loc9_:int = 0;
         var _loc13_:XML = null;
         var _loc8_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:String = null;
         var _loc17_:IGraphicAsset = null;
         var _loc11_:BitmapDataAsset = null;
         var _loc12_:BitmapData = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc5_:XMLList = param1.texture;
         _loc7_ = 0;
         while(_loc7_ < _loc5_.length())
         {
            _loc6_ = _loc5_[_loc7_];
            if(class_2119.checkRequiredAttributes(_loc6_,["id"]))
            {
               _loc16_ = _loc6_.@id;
               if(var_365.getValue(_loc16_) == null)
               {
                  _loc4_ = new PlaneTexture();
                  _loc3_ = _loc6_.bitmap;
                  _loc9_ = 0;
                  while(_loc9_ < _loc3_.length())
                  {
                     _loc13_ = _loc3_[_loc9_];
                     if(class_2119.checkRequiredAttributes(_loc13_,["assetName"]))
                     {
                        _loc8_ = -1;
                        _loc18_ = 1;
                        _loc10_ = -1;
                        _loc14_ = 1;
                        if(String(_loc13_.@normalMinX) != "")
                        {
                           _loc8_ = parseFloat(_loc13_.@normalMinX);
                        }
                        if(String(_loc13_.@normalMaxX) != "")
                        {
                           _loc18_ = parseFloat(_loc13_.@normalMaxX);
                        }
                        if(String(_loc13_.@normalMinY) != "")
                        {
                           _loc10_ = parseFloat(_loc13_.@normalMinY);
                        }
                        if(String(_loc13_.@normalMaxY) != "")
                        {
                           _loc14_ = parseFloat(_loc13_.@normalMaxY);
                        }
                        _loc15_ = _loc13_.@assetName;
                        _loc17_ = param2.getAsset(_loc15_);
                        if(_loc17_ != null)
                        {
                           _loc11_ = _loc17_.asset as BitmapDataAsset;
                           if(_loc11_ != null)
                           {
                              _loc12_ = _loc11_.content as BitmapData;
                              if(_loc12_ != null)
                              {
                                 if(_loc17_.flipH)
                                 {
                                    _loc12_ = class_4038.getFlipHBitmapData(_loc12_);
                                 }
                                 else
                                 {
                                    _loc12_ = _loc12_.clone();
                                 }
                                 _loc4_.addBitmap(_loc12_,_loc8_,_loc18_,_loc10_,_loc14_,_loc15_);
                              }
                           }
                        }
                     }
                     _loc9_++;
                  }
                  var_365.add(_loc16_,_loc4_);
               }
            }
            _loc7_++;
         }
      }
      
      private function parsePlaneMaterials(param1:XML) : void
      {
         var _loc4_:int = 0;
         var _loc15_:XML = null;
         var _loc20_:String = null;
         var _loc8_:PlaneMaterial = null;
         var _loc2_:XMLList = null;
         var _loc6_:int = 0;
         var _loc11_:XML = null;
         var _loc16_:String = null;
         var _loc12_:String = null;
         var _loc3_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc18_:XMLList = null;
         var _loc13_:PlaneMaterialCellMatrix = null;
         var _loc9_:int = 0;
         var _loc14_:XML = null;
         if(param1 == null)
         {
            return;
         }
         var _loc17_:XMLList = param1.material;
         _loc4_ = 0;
         while(_loc4_ < _loc17_.length())
         {
            _loc15_ = _loc17_[_loc4_];
            if(class_2119.checkRequiredAttributes(_loc15_,["id"]))
            {
               _loc20_ = _loc15_.@id;
               _loc8_ = new PlaneMaterial();
               _loc2_ = _loc15_.materialCellMatrix;
               _loc6_ = 0;
               while(_loc6_ < _loc2_.length())
               {
                  _loc11_ = _loc2_[_loc6_];
                  _loc16_ = _loc11_.@repeatMode;
                  _loc12_ = _loc11_.@align;
                  _loc3_ = 1;
                  switch(_loc16_)
                  {
                     case "borders":
                        _loc3_ = 2;
                        break;
                     case "center":
                        _loc3_ = 3;
                        break;
                     case "first":
                        _loc3_ = 4;
                        break;
                     case "last":
                        _loc3_ = 5;
                        break;
                     case "random":
                        _loc3_ = 6;
                  }
                  _loc10_ = 1;
                  switch(_loc12_)
                  {
                     case "top":
                        _loc10_ = 1;
                        break;
                     case "bottom":
                        _loc10_ = 2;
                  }
                  _loc5_ = -1;
                  _loc21_ = 1;
                  _loc7_ = -1;
                  _loc19_ = 1;
                  if(String(_loc11_.@normalMinX) != "")
                  {
                     _loc5_ = parseFloat(_loc11_.@normalMinX);
                  }
                  if(String(_loc11_.@normalMaxX) != "")
                  {
                     _loc21_ = parseFloat(_loc11_.@normalMaxX);
                  }
                  if(String(_loc11_.@normalMinY) != "")
                  {
                     _loc7_ = parseFloat(_loc11_.@normalMinY);
                  }
                  if(String(_loc11_.@normalMaxY) != "")
                  {
                     _loc19_ = parseFloat(_loc11_.@normalMaxY);
                  }
                  _loc18_ = _loc11_.materialCellColumn;
                  if(_loc18_.length() > 0)
                  {
                     _loc13_ = null;
                     _loc13_ = _loc8_.addMaterialCellMatrix(_loc18_.length(),_loc3_,_loc10_,_loc5_,_loc21_,_loc7_,_loc19_);
                     _loc9_ = 0;
                     while(_loc9_ < _loc18_.length())
                     {
                        _loc14_ = _loc18_[_loc9_];
                        parsePlaneMaterialCellColumn(_loc14_,_loc13_,_loc9_);
                        _loc9_++;
                     }
                  }
                  _materials.add(_loc20_,_loc8_);
                  _loc6_++;
               }
            }
            _loc4_++;
         }
      }
      
      private function parsePlaneMaterialCellColumn(param1:XML, param2:PlaneMaterialCellMatrix, param3:int) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc5_:String = param1.@repeatMode;
         var _loc7_:int = parseInt(param1.@width);
         var _loc6_:int = 1;
         switch(_loc5_)
         {
            case "borders":
               _loc6_ = 2;
               break;
            case "center":
               _loc6_ = 3;
               break;
            case "first":
               _loc6_ = 4;
               break;
            case "last":
               _loc6_ = 5;
               break;
            case "none":
               _loc6_ = 0;
         }
         var _loc4_:Array = parsePlaneMaterialCells(param1);
         param2.createColumn(param3,_loc7_,_loc4_,_loc6_);
      }
      
      private function parsePlaneMaterialCells(param1:XML) : Array
      {
         var _loc6_:int = 0;
         var _loc13_:XML = null;
         var _loc8_:String = null;
         var _loc20_:Array = null;
         var _loc21_:Array = null;
         var _loc2_:Array = null;
         var _loc14_:int = 0;
         var _loc3_:XMLList = null;
         var _loc10_:XML = null;
         var _loc18_:XMLList = null;
         var _loc4_:XMLList = null;
         var _loc15_:XML = null;
         var _loc12_:XML = null;
         var _loc7_:int = 0;
         var _loc16_:String = null;
         var _loc19_:IGraphicAsset = null;
         var _loc5_:PlaneTexture = null;
         var _loc9_:PlaneMaterialCell = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc11_:Array = [];
         var _loc17_:XMLList = param1.materialCell;
         _loc6_ = 0;
         while(_loc6_ < _loc17_.length())
         {
            _loc13_ = _loc17_[_loc6_];
            _loc8_ = _loc13_.@textureId;
            _loc20_ = null;
            _loc21_ = null;
            _loc2_ = null;
            _loc14_ = 0;
            _loc3_ = _loc13_.extraItemData;
            if(_loc3_.length() > 0)
            {
               _loc10_ = _loc3_[0];
               _loc18_ = _loc10_.extraItemTypes;
               _loc4_ = _loc10_.offsets;
               if(_loc18_.length() > 0 && _loc4_.length() > 0)
               {
                  _loc15_ = _loc18_[0];
                  _loc12_ = _loc4_[0];
                  _loc20_ = parseExtraItemTypes(_loc15_);
                  _loc2_ = parseExtraItemOffsets(_loc12_);
                  _loc14_ = int(_loc2_.length);
                  if(String(_loc10_.@limitMax) != "")
                  {
                     _loc14_ = parseInt(_loc10_.@limitMax);
                  }
               }
            }
            if(_loc20_ != null)
            {
               _loc21_ = [];
               _loc7_ = 0;
               while(_loc7_ < _loc20_.length)
               {
                  _loc16_ = _loc20_[_loc6_];
                  _loc19_ = var_1373.getAsset(_loc16_);
                  if(_loc19_ != null)
                  {
                     _loc21_.push(_loc19_);
                  }
                  _loc7_++;
               }
            }
            _loc5_ = getTexture(_loc8_);
            _loc9_ = new PlaneMaterialCell(_loc5_,_loc21_,_loc2_,_loc14_);
            _loc11_.push(_loc9_);
            _loc6_++;
         }
         if(_loc11_.length == 0)
         {
            _loc11_ = null;
         }
         return _loc11_;
      }
      
      private function parseExtraItemTypes(param1:XML) : Array
      {
         var _loc3_:XMLList = null;
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:String = null;
         var _loc2_:Array = [];
         var _loc7_:Array = ["assetName"];
         if(param1 != null)
         {
            _loc3_ = param1.extraItemType;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc5_ = _loc3_[_loc4_];
               if(class_2119.checkRequiredAttributes(_loc5_,_loc7_))
               {
                  _loc6_ = _loc5_.@assetName;
                  _loc2_.push(_loc6_);
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      private function parseExtraItemOffsets(param1:XML) : Array
      {
         var _loc4_:XMLList = null;
         var _loc6_:int = 0;
         var _loc3_:XML = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:Array = [];
         var _loc8_:Array = ["x","y"];
         if(param1 != null)
         {
            _loc4_ = param1.offset;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length())
            {
               _loc3_ = _loc4_[_loc6_];
               if(class_2119.checkRequiredAttributes(_loc3_,_loc8_))
               {
                  _loc5_ = parseInt(_loc3_.@x);
                  _loc7_ = parseInt(_loc3_.@y);
                  _loc2_.push(new Point(_loc5_,_loc7_));
               }
               _loc6_++;
            }
         }
         return _loc2_;
      }
      
      protected function getGeometry(param1:int, param2:Number, param3:Number) : IRoomGeometry
      {
         param2 = Math.abs(param2);
         if(param2 > 90)
         {
            param2 = 90;
         }
         param3 = Math.abs(param3);
         if(param3 > 90)
         {
            param3 = 90;
         }
         var _loc5_:String = param1 + "_" + Math.round(param2) + "_" + Math.round(param3);
         var _loc4_:IRoomGeometry = var_1111.getValue(_loc5_);
         if(_loc4_ == null)
         {
            _loc4_ = new RoomGeometry(param1,new Vector3d(param2,param3),new Vector3d(-10,0,0));
            var_1111.add(_loc5_,_loc4_);
         }
         return _loc4_;
      }
      
      protected function parseVisualizations(param1:Plane, param2:XMLList) : void
      {
         var _loc8_:int = 0;
         var _loc3_:XML = null;
         var _loc18_:Number = NaN;
         var _loc14_:Number = NaN;
         if(param1 == null || param2 == null)
         {
            return;
         }
         _loc8_ = 0;
         while(_loc8_ < param2.length())
         {
            _loc3_ = param2[_loc8_];
            if(class_2119.checkRequiredAttributes(_loc3_,["size"]))
            {
               var _loc16_:int = parseInt(_loc3_.@size);
               var _loc6_:String = _loc3_.@horizontalAngle;
               var _loc20_:String = _loc3_.@verticalAngle;
               _loc18_ = 45;
               _loc18_ = parseFloat(null);
               _loc14_ = 30;
               _loc14_ = parseFloat(null);
               var _loc19_:XMLList = _loc3_.visualizationLayer;
               var _loc7_:PlaneVisualization = param1.createPlaneVisualization(0,null.length(),getGeometry(0,_loc18_,_loc14_));
               if(_loc7_ != null)
               {
                  var _loc10_:int = 0;
                  while(0 < null.length())
                  {
                     var _loc13_:XML = null[0];
                     var _loc17_:PlaneMaterial = null;
                     var _loc11_:int = 1;
                     if(class_2119.checkRequiredAttributes(null,["materialId"]))
                     {
                        var _loc12_:String = null.@materialId;
                        _loc17_ = getMaterial(null);
                     }
                     var _loc21_:String = null.@offset;
                     var _loc4_:int = 0;
                     if(null.length > 0)
                     {
                        _loc4_ = parseInt(null);
                     }
                     var _loc9_:String = null.@color;
                     var _loc5_:* = 16777215;
                     if(null.length > 0)
                     {
                        _loc5_ = parseInt(null);
                     }
                     var _loc15_:String = null.@align;
                     if(_loc15_ == "bottom")
                     {
                        _loc11_ = 2;
                     }
                     null.setLayer(0,null,0,0,0);
                     _loc10_++;
                  }
               }
            }
            _loc8_++;
         }
      }
      
      public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         return null;
      }
      
      public function getTextureIdentifier(param1:Number, param2:IVector3d) : String
      {
         return String(param1);
      }
      
      public function getLayers(param1:String) : Array
      {
         var _loc2_:Plane = getPlane(param1);
         if(_loc2_ == null)
         {
            _loc2_ = getPlane("default");
         }
         return _loc2_.getLayers();
      }
   }
}

