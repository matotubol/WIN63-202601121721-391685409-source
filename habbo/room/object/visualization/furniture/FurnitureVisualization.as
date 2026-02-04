package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.utils.StringBuffer;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.RoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class FurnitureVisualization extends RoomObjectSpriteVisualization
   {
      
      private static var var_1650:StringBuffer;
      
      private static var var_545:Array;
      
      protected static const Z_MULTIPLIER:Number = Math.sqrt(0.5);
      
      private const const_565:int = 41;
      
      private var _lastUpdateTime:int = -1000;
      
      private var var_81:int;
      
      private var var_4294:Number = NaN;
      
      private var _selectedColor:int = -1;
      
      protected var var_1756:Number = 1;
      
      private var var_3289:String = null;
      
      private var var_3762:Boolean = false;
      
      private var var_24:FurnitureVisualizationData = null;
      
      private var var_230:String = "";
      
      private var var_770:Array = [];
      
      private var _assetNamesFrame:Array = [];
      
      private var var_4973:Number = 0;
      
      private var var_3593:int = -1;
      
      private var var_4227:int = -1;
      
      private var var_672:Array = [];
      
      private var var_621:Array = [];
      
      private var _spriteColors:Array = [];
      
      private var var_679:Array = [];
      
      private var var_651:Array = [];
      
      private var var_705:Array = [];
      
      private var var_755:Array = [];
      
      private var var_694:Array = [];
      
      protected var var_1531:Boolean = true;
      
      protected var var_1112:int = 0;
      
      protected var var_3232:int = -1;
      
      private var _updatedLayers:int = 0;
      
      private var var_4889:Number = 0;
      
      private var var_3447:Boolean = false;
      
      private var var_2704:Boolean = false;
      
      private var _filters:Array = null;
      
      private var var_3375:Boolean = false;
      
      public function FurnitureVisualization()
      {
         super();
         reset();
         if(!var_1650)
         {
            var_1650 = new StringBuffer();
            var_545 = [];
            var_545[0] = null;
            var_545[1] = "_";
            var_545[2] = null;
            var_545[3] = "_";
            var_545[4] = null;
            var_545[5] = "_";
            var_545[6] = null;
            var_545[7] = "_";
         }
      }
      
      protected function set direction(param1:int) : void
      {
         var_81 = param1;
      }
      
      protected function get direction() : int
      {
         return var_81;
      }
      
      protected function get type() : String
      {
         return var_230;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_24 = null;
         var_770 = null;
         _assetNamesFrame = null;
         var_672 = null;
         var_621 = null;
         _spriteColors = null;
         var_679 = null;
         var_651 = null;
         var_705 = null;
         var_755 = null;
         var_694 = null;
         _filters = null;
      }
      
      override protected function reset() : void
      {
         super.reset();
         direction = -1;
         var_24 = null;
         var_770 = var_770.length > 0 ? [] : var_770;
         _assetNamesFrame = _assetNamesFrame.length > 0 ? [] : _assetNamesFrame;
         var_672 = var_672.length > 0 ? [] : var_672;
         var_621 = var_621.length > 0 ? [] : var_621;
         _spriteColors = _spriteColors.length > 0 ? [] : _spriteColors;
         var_679 = var_679.length > 0 ? [] : var_679;
         var_651 = var_651.length > 0 ? [] : var_651;
         var_705 = var_705.length > 0 ? [] : var_705;
         var_755 = var_755.length > 0 ? [] : var_755;
         var_694 = var_694.length > 0 ? [] : var_694;
         clearSprites();
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         reset();
         if(param1 == null || !(param1 is FurnitureVisualizationData))
         {
            return false;
         }
         var_24 = param1 as FurnitureVisualizationData;
         var_230 = var_24.getType();
         return true;
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param2 < _lastUpdateTime + 41)
         {
            return;
         }
         _lastUpdateTime += 41;
         if(_lastUpdateTime + 41 < param2)
         {
            _lastUpdateTime = param2 - 41;
         }
         var _loc5_:Boolean = false;
         var _loc6_:Number = param1.scale;
         if(updateObject(_loc6_,param1.direction.x))
         {
            _loc5_ = true;
         }
         if(updateModel(_loc6_))
         {
            _loc5_ = true;
         }
         if(var_2704)
         {
            _loc5_ = true;
            var_2704 = false;
         }
         if(var_3375)
         {
            _loc5_ = true;
            var_3375 = false;
         }
         var _loc7_:* = 0;
         if(param4)
         {
            _updatedLayers |= updateAnimation(_loc6_);
         }
         else
         {
            _loc7_ = updateAnimation(_loc6_) | _updatedLayers;
            _updatedLayers = 0;
         }
         if(_loc5_ || _loc7_ != 0)
         {
            updateSprites(_loc6_,_loc5_,_loc7_);
            var_199 = _loc6_;
            increaseUpdateId();
         }
      }
      
      protected function updateSprites(param1:int, param2:Boolean, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(var_1112 != spriteCount)
         {
            createSprites(var_1112);
         }
         if(param2)
         {
            _loc5_ = spriteCount - 1;
            while(_loc5_ >= 0)
            {
               updateSprite(param1,_loc5_);
               _loc5_--;
            }
         }
         else
         {
            _loc4_ = 0;
            while(param3 > 0)
            {
               if(param3 & 1)
               {
                  updateSprite(param1,_loc4_);
               }
               _loc4_++;
               param3 >>= 1;
            }
         }
         var_1531 = false;
      }
      
      protected function updateSprite(param1:int, param2:int) : void
      {
         var _loc7_:IGraphicAsset = null;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         var _loc5_:String = getSpriteAssetName(param1,param2);
         var _loc6_:IRoomObjectSprite = getSprite(param2);
         if(_loc6_ != null && _loc5_ != null)
         {
            _loc7_ = getAsset(_loc5_,param2);
            if(_loc7_ != null && _loc7_.asset != null)
            {
               _loc6_.visible = true;
               _loc6_.objectType = var_230;
               _loc6_.asset = _loc7_.asset.content as BitmapData;
               if(_loc7_.asset.content == null)
               {
                  var_262 = var_262 + 1;
               }
               _loc6_.flipH = _loc7_.flipH;
               _loc6_.flipV = _loc7_.flipV;
               _loc6_.direction = var_81;
               _loc3_ = 0;
               if(param2 != var_3232)
               {
                  _loc6_.tag = getSpriteTag(param1,var_81,param2);
                  _loc6_.alpha = getSpriteAlpha(param1,var_81,param2);
                  _loc6_.color = getSpriteColor(param1,param2,_selectedColor);
                  _loc6_.offsetX = _loc7_.offsetX + getSpriteXOffset(param1,var_81,param2);
                  _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1,var_81,param2);
                  _loc6_.alphaTolerance = getSpriteMouseCapture(param1,var_81,param2) ? 128 : 256;
                  _loc6_.blendMode = getBlendMode(getSpriteInk(param1,var_81,param2));
                  _loc3_ = getSpriteZOffset(param1,var_81,param2);
                  _loc3_ -= param2 * 0.001;
               }
               else
               {
                  _loc6_.offsetX = _loc7_.offsetX;
                  _loc6_.offsetY = _loc7_.offsetY + getSpriteYOffset(param1,var_81,param2);
                  _loc4_ = 48;
                  _loc4_ = _loc4_ * var_1756;
                  _loc6_.alpha = _loc4_;
                  _loc6_.alphaTolerance = 256;
                  _loc3_ = 1;
               }
               if(var_3447)
               {
                  _loc6_.alpha *= 0.2;
               }
               _loc3_ *= Z_MULTIPLIER;
               _loc6_.relativeDepth = _loc3_;
               _loc6_.assetName = _loc7_.assetName;
               _loc6_.libraryAssetName = getLibraryAssetNameForSprite(_loc7_,_loc6_);
               _loc6_.assetPosture = getPostureForAssetFile(param1,_loc7_.libraryAssetName);
               _loc6_.clickHandling = var_3762;
               if(_loc6_.blendMode != "add")
               {
                  _loc6_.filters = _filters;
               }
            }
            else
            {
               resetSprite(_loc6_,param2);
            }
         }
         else if(_loc6_ != null)
         {
            resetSprite(_loc6_,param2);
         }
      }
      
      protected function getLibraryAssetNameForSprite(param1:IGraphicAsset, param2:IRoomObjectSprite) : String
      {
         return param1.libraryAssetName;
      }
      
      private function resetSprite(param1:IRoomObjectSprite, param2:int) : void
      {
         param1.asset = null;
         param1.assetName = "";
         param1.assetPosture = null;
         param1.alpha = 0;
         param1.tag = "";
         param1.flipH = false;
         param1.flipV = false;
         param1.offsetX = 0;
         param1.offsetY = 0;
         param1.relativeDepth = 0;
         param1.clickHandling = false;
         if(var_1531)
         {
            delete var_621[param2];
         }
      }
      
      protected function getBlendMode(param1:int) : String
      {
         var _loc2_:String = "normal";
         switch(param1)
         {
            case 1:
               _loc2_ = "add";
               break;
            case 2:
               _loc2_ = "subtract";
               break;
            case 3:
               _loc2_ = "darken";
               break;
            case 4:
               _loc2_ = "difference";
               break;
            case 5:
               _loc2_ = "multiply";
               break;
            case 6:
               _loc2_ = "invert";
               break;
            case 7:
               _loc2_ = "screen";
         }
         return _loc2_;
      }
      
      protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = object;
         if(_loc3_ == null)
         {
            return false;
         }
         if(var_1559 != _loc3_.getUpdateID() || param1 != var_199 || param2 != var_4294)
         {
            _loc4_ = _loc3_.getDirection().x - (param2 + 135);
            _loc4_ = (_loc4_ % 360 + 360) % 360;
            if(var_24 != null)
            {
               direction = _loc5_ = var_24.getDirectionValue(param1,_loc4_);
            }
            var_1559 = _loc3_.getUpdateID();
            var_4294 = param2;
            var_199 = param1;
            updateAssetAndSpriteCache(param1,var_81);
            return true;
         }
         return false;
      }
      
      protected function updateModel(param1:Number) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc2_:IRoomObject = object;
         if(_loc2_ == null)
         {
            return false;
         }
         var _loc3_:IRoomObjectModel = _loc2_.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         if(var_262 != _loc3_.getUpdateID())
         {
            _selectedColor = _loc3_.getNumber("furniture_color");
            _loc4_ = _loc3_.getNumber("furniture_alpha_multiplier");
            if(isNaN(_loc4_))
            {
               _loc4_ = 1;
            }
            if(_loc4_ != var_1756)
            {
               var_1756 = _loc4_;
               var_1531 = true;
            }
            var_3289 = getAdClickUrl(_loc3_);
            var_3762 = var_3289 != null && var_3289 != "" && var_3289.indexOf("http") == 0;
            var_4889 = _loc3_.getNumber("furniture_lift_amount");
            var_262 = _loc3_.getUpdateID();
            return true;
         }
         return false;
      }
      
      protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return param1.getString("furniture_ad_url");
      }
      
      protected function updateAnimation(param1:Number) : int
      {
         return 0;
      }
      
      private function updateAssetAndSpriteCache(param1:Number, param2:int) : void
      {
         if(var_4227 != param2 || var_4973 != param1)
         {
            var_770 = [];
            _assetNamesFrame = [];
            var_672 = [];
            var_621 = [];
            _spriteColors = [];
            var_679 = [];
            var_651 = [];
            var_705 = [];
            var_755 = [];
            var_694 = [];
            var_4227 = param2;
            var_4973 = param1;
            var_3593 = getSize(param1);
            updateLayerCount(var_24.getLayerCount(param1) + getAdditionalSpriteCount());
         }
      }
      
      protected function updateLayerCount(param1:int) : void
      {
         var_1112 = param1;
         var_3232 = var_1112 - getAdditionalSpriteCount();
      }
      
      protected function getAdditionalSpriteCount() : int
      {
         return 1;
      }
      
      protected function getFrameNumber(param1:int, param2:int) : int
      {
         return 0;
      }
      
      protected function getPostureForAssetFile(param1:int, param2:String) : String
      {
         return null;
      }
      
      protected function getAsset(param1:String, param2:int = -1) : IGraphicAsset
      {
         if(assetCollection != null)
         {
            var _loc3_:IGraphicAsset = assetCollection.getAsset(param1);
            return null;
         }
         return null;
      }
      
      protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(var_24 == null || param2 >= FurnitureVisualizationData.LAYER_NAMES.length)
         {
            return "";
         }
         var _loc4_:String = var_770[param2];
         var _loc3_:* = Boolean(_assetNamesFrame[param2]);
         if(_loc4_ == null || _loc4_.length == 0)
         {
            _loc4_ = getSpriteAssetNameWithoutFrame(param1,param2,true);
            _loc3_ = var_3593 != 1;
         }
         if(_loc3_)
         {
            _loc4_ += getFrameNumber(param1,param2);
         }
         return _loc4_;
      }
      
      protected function getSpriteAssetNameWithoutFrame(param1:int, param2:int, param3:Boolean) : String
      {
         var _loc7_:String = null;
         var _loc4_:int = param3 ? var_3593 : getSize(param1);
         var _loc5_:* = _loc4_ == 1;
         if(param2 != var_3232)
         {
            _loc7_ = FurnitureVisualizationData.LAYER_NAMES[param2];
         }
         else
         {
            _loc7_ = "sd";
         }
         if(_loc5_)
         {
            return var_230 + "_icon_" + _loc7_;
         }
         var_545[0] = var_230;
         var_545[2] = _loc4_;
         var_545[4] = _loc7_;
         var_545[6] = var_81;
         var_1650.length = 0;
         var_1650.appendStringArray(var_545);
         var _loc6_:String = var_1650.toString();
         if(param3)
         {
            var_770[param2] = _loc6_;
            _assetNamesFrame[param2] = !_loc5_;
         }
         return _loc6_;
      }
      
      protected function getSpriteTag(param1:int, param2:int, param3:int) : String
      {
         if(var_672[param3] != null)
         {
            return var_672[param3];
         }
         if(var_24 == null)
         {
            return "";
         }
         var _loc4_:String = var_24.getTag(param1,param2,param3);
         var_672[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteAlpha(param1:int, param2:int, param3:int) : int
      {
         if(var_621[param3] != null && !var_1531)
         {
            return var_621[param3];
         }
         if(var_24 == null)
         {
            return 255;
         }
         var _loc4_:int = var_24.getAlpha(param1,param2,param3);
         _loc4_ = _loc4_ * var_1756;
         var_621[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(_spriteColors[param2] != null)
         {
            return _spriteColors[param2];
         }
         if(var_24 == null)
         {
            return 16777215;
         }
         var _loc4_:int = var_24.getColor(param1,param2,param3);
         _spriteColors[param2] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(var_679[param3] != null)
         {
            return var_679[param3];
         }
         if(var_24 == null)
         {
            return 0;
         }
         var _loc4_:int = var_24.getXOffset(param1,param2,param3);
         var_679[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(param3 != var_3232)
         {
            if(var_651[param3] != null)
            {
               return var_651[param3];
            }
            if(var_24 != null)
            {
               var _loc4_:int = var_24.getYOffset(param1,param2,param3);
               var_651[param3] = 0;
               return 0;
            }
            return 0;
         }
         return Math.ceil(var_4889 * (param1 / 2));
      }
      
      protected function getSpriteMouseCapture(param1:int, param2:int, param3:int) : Boolean
      {
         if(var_755[param3] != null)
         {
            return var_755[param3];
         }
         if(var_24 == null)
         {
            return true;
         }
         var _loc4_:* = !var_24.getIgnoreMouse(param1,param2,param3);
         var_755[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteInk(param1:int, param2:int, param3:int) : int
      {
         if(var_694[param3] != null)
         {
            return var_694[param3];
         }
         if(var_24 == null)
         {
            return 0;
         }
         var _loc4_:int = var_24.getInk(param1,param2,param3);
         var_694[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(var_705[param3] != null)
         {
            return var_705[param3];
         }
         if(var_24 == null)
         {
            return 0;
         }
         var _loc4_:Number = var_24.getZOffset(param1,param2,param3);
         var_705[param3] = _loc4_;
         return _loc4_;
      }
      
      protected function getSize(param1:int) : int
      {
         if(var_24 != null)
         {
            return var_24.getSize(param1);
         }
         return param1;
      }
      
      protected function get data() : FurnitureVisualizationData
      {
         return var_24;
      }
      
      public function set lookThrough(param1:Boolean) : *
      {
         if(var_3447 != param1)
         {
            var_2704 = true;
            var_3447 = param1;
         }
      }
      
      public function set filters(param1:Array) : *
      {
         _filters = param1;
         var_3375 = true;
      }
      
      public function get filters() : Array
      {
         return _filters;
      }
   }
}

