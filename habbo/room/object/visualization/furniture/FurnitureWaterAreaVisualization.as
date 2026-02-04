package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import flash.display.BitmapData;
   
   public class FurnitureWaterAreaVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const SHORE_SPRITE_TAG:String = "shore";
      
      private var var_3021:Boolean = true;
      
      private var var_834:Array = [];
      
      private var var_1052:Array = [];
      
      private var var_1978:Array = [];
      
      private var _needsShoreUpdate:Boolean = false;
      
      private var var_1132:int = 0;
      
      private var var_1224:int = 0;
      
      private var var_3735:int = 0;
      
      private var var_5046:int = -1;
      
      private var var_4355:int = -1;
      
      private var var_105:BitmapData = null;
      
      public function FurnitureWaterAreaVisualization()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(assetCollection != null)
         {
            for each(var _loc1_ in var_1978)
            {
               ShoreMaskCreatorUtility.disposeInstanceMask(object.getInstanceId(),_loc1_,assetCollection);
            }
            var_1978 = [];
         }
         if(var_105 != null)
         {
            var_105.dispose();
            var_105 = null;
         }
         super.dispose();
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         if(super.updateObject(param1,param2))
         {
            _needsShoreUpdate = true;
            updateBorderData();
            return true;
         }
         return false;
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         var _loc3_:* = super.updateAnimation(param1);
         if(updateInstanceShoreMask(param1))
         {
            var _loc2_:int = getShoreSpriteIndex(param1);
            _loc3_ |= 1 << 0;
         }
         return _loc3_;
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(param1 == 1 || param2 != getShoreSpriteIndex(param1))
         {
            return super.getSpriteAssetName(param1,param2);
         }
         if(var_3021)
         {
            return ShoreMaskCreatorUtility.getInstanceMaskName(object.getInstanceId(),getSize(param1));
         }
         return null;
      }
      
      private function getShoreSpriteIndex(param1:int) : int
      {
         var _loc2_:int = 0;
         if(var_5046 == param1 && var_4355 == direction)
         {
            return var_3735;
         }
         _loc2_ = spriteCount - 1;
         while(_loc2_ >= 0)
         {
            if(getSpriteTag(param1,direction,_loc2_) == "shore")
            {
               var_3735 = _loc2_;
               var_5046 = param1;
               var_4355 = direction;
               return var_3735;
            }
            _loc2_--;
         }
         return -1;
      }
      
      private function getShoreAsset(param1:int) : IGraphicAsset
      {
         var _loc3_:String = super.getSpriteAssetName(param1,getShoreSpriteIndex(param1));
         return assetCollection.getAsset(_loc3_);
      }
      
      private function getInstanceMask(param1:int) : IGraphicAsset
      {
         var _loc2_:int = getSize(param1);
         var _loc3_:IGraphicAsset = ShoreMaskCreatorUtility.getInstanceMask(object.getInstanceId(),_loc2_,assetCollection,getShoreAsset(param1));
         if(_loc3_ != null)
         {
            if(var_1978.indexOf(_loc2_) < 0)
            {
               var_1978.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function updateBorderData() : void
      {
         resetBorders();
         var _loc2_:* = object.getState(0);
         var _loc6_:Array = getAreaData();
         var _loc1_:int = var_1132 + 2;
         var _loc7_:int = var_1224 + 2;
         var _loc3_:int = 0;
         var _loc5_:Array = _loc6_[_loc7_ - 1];
         _loc3_ = _loc1_ - 1;
         while(_loc3_ >= 0)
         {
            if(_loc2_ & 1)
            {
               _loc5_[_loc3_] = true;
            }
            _loc2_ >>= 1;
            _loc3_--;
         }
         _loc3_ = _loc7_ - 2;
         while(_loc3_ >= 1)
         {
            _loc5_ = _loc6_[_loc3_];
            if(_loc2_ & 1)
            {
               _loc5_[_loc1_ - 1] = true;
            }
            _loc2_ >>= 1;
            if(_loc2_ & 1)
            {
               _loc5_[0] = true;
            }
            _loc2_ >>= 1;
            _loc3_--;
         }
         _loc5_ = _loc6_[0];
         _loc3_ = _loc1_ - 1;
         while(_loc3_ >= 0)
         {
            if(_loc2_ & 1)
            {
               _loc5_[_loc3_] = true;
            }
            _loc2_ >>= 1;
            _loc3_--;
         }
         var _loc4_:int = 0;
         _loc4_ = updateTopBorder(_loc6_,_loc4_);
         _loc4_ = updateRightBorder(_loc6_,_loc4_);
         _loc4_ = updateBottomBorder(_loc6_,_loc4_);
         _loc4_ = updateLeftBorder(_loc6_,_loc4_);
         var_3021 = false;
         _loc3_ = 0;
         while(_loc3_ < var_834.length)
         {
            if(var_834[_loc3_] == true)
            {
               var_3021 = true;
            }
            _loc3_++;
         }
      }
      
      private function updateTopBorder(param1:Array, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = var_1132 + 2;
         var _loc6_:Array = param1[0];
         var _loc7_:Array = param1[1];
         _loc4_ = 1;
         while(_loc4_ < _loc3_ - 1)
         {
            if(_loc6_[_loc4_] == false)
            {
               var_834[param2] = true;
               if(_loc7_[_loc4_ - 1] == false && _loc6_[_loc4_ - 1] == false)
               {
                  var _loc8_:int = 0;
               }
               else if(_loc6_[_loc4_ - 1] == true)
               {
                  _loc8_ = 2;
               }
               else
               {
                  _loc8_ = 1;
               }
               if(_loc7_[_loc4_ + 1] == false && _loc6_[_loc4_ + 1] == false)
               {
                  var _loc5_:int = 0;
               }
               else if(_loc6_[_loc4_ + 1] == true)
               {
                  _loc5_ = 2;
               }
               else
               {
                  _loc5_ = 1;
               }
               var_1052[param2] = ShoreMaskCreatorUtility.getBorderType(0,0);
            }
            param2++;
            _loc4_++;
         }
         return param2;
      }
      
      private function updateRightBorder(param1:Array, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = var_1132 + 2;
         var _loc10_:int = var_1224 + 2;
         var _loc6_:Array = null;
         var _loc9_:Array = null;
         var _loc7_:Array = null;
         _loc4_ = 1;
         while(_loc4_ < _loc10_ - 1)
         {
            _loc6_ = param1[_loc4_];
            _loc9_ = param1[_loc4_ - 1];
            _loc7_ = param1[_loc4_ + 1];
            if(_loc6_[_loc3_ - 1] == false)
            {
               var_834[param2] = true;
               if(_loc9_[_loc3_ - 2] == false && _loc9_[_loc3_ - 1] == false)
               {
                  var _loc8_:int = 0;
               }
               else if(_loc9_[_loc3_ - 1] == true)
               {
                  _loc8_ = 2;
               }
               else
               {
                  _loc8_ = 1;
               }
               if(_loc7_[_loc3_ - 2] == false && _loc7_[_loc3_ - 1] == false)
               {
                  var _loc5_:int = 0;
               }
               else if(_loc7_[_loc3_ - 1] == true)
               {
                  _loc5_ = 2;
               }
               else
               {
                  _loc5_ = 1;
               }
               var_1052[param2] = ShoreMaskCreatorUtility.getBorderType(0,0);
            }
            param2++;
            _loc4_++;
         }
         return param2;
      }
      
      private function updateBottomBorder(param1:Array, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = var_1132 + 2;
         var _loc9_:int = var_1224 + 2;
         var _loc6_:Array = param1[_loc9_ - 1];
         var _loc8_:Array = param1[_loc9_ - 2];
         _loc4_ = _loc3_ - 2;
         while(_loc4_ >= 1)
         {
            if(_loc6_[_loc4_] == false)
            {
               var_834[param2] = true;
               if(_loc8_[_loc4_ + 1] == false && _loc6_[_loc4_ + 1] == false)
               {
                  var _loc7_:int = 0;
               }
               else if(_loc6_[_loc4_ + 1] == true)
               {
                  _loc7_ = 2;
               }
               else
               {
                  _loc7_ = 1;
               }
               if(_loc8_[_loc4_ - 1] == false && _loc6_[_loc4_ - 1] == false)
               {
                  var _loc5_:int = 0;
               }
               else if(_loc6_[_loc4_ - 1] == true)
               {
                  _loc5_ = 2;
               }
               else
               {
                  _loc5_ = 1;
               }
               var_1052[param2] = ShoreMaskCreatorUtility.getBorderType(0,0);
            }
            param2++;
            _loc4_--;
         }
         return param2;
      }
      
      private function updateLeftBorder(param1:Array, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = var_1132 + 2;
         var _loc10_:int = var_1224 + 2;
         var _loc6_:Array = null;
         var _loc9_:Array = null;
         var _loc7_:Array = null;
         _loc4_ = _loc10_ - 2;
         while(_loc4_ >= 1)
         {
            _loc6_ = param1[_loc4_];
            _loc9_ = param1[_loc4_ + 1];
            _loc7_ = param1[_loc4_ - 1];
            if(_loc6_[0] == false)
            {
               var_834[param2] = true;
               if(_loc9_[1] == false && _loc9_[0] == false)
               {
                  var _loc8_:int = 0;
               }
               else if(_loc9_[0] == true)
               {
                  _loc8_ = 2;
               }
               else
               {
                  _loc8_ = 1;
               }
               if(_loc7_[1] == false && _loc7_[0] == false)
               {
                  var _loc5_:int = 0;
               }
               else if(_loc7_[0] == true)
               {
                  _loc5_ = 2;
               }
               else
               {
                  _loc5_ = 1;
               }
               var_1052[param2] = ShoreMaskCreatorUtility.getBorderType(0,0);
            }
            param2++;
            _loc4_--;
         }
         return param2;
      }
      
      private function resetBorders() : void
      {
         var _loc2_:IRoomObjectModel = null;
         if(var_1132 == 0 || var_1224 == 0)
         {
            if(object == null || object.getModel() == null)
            {
               return;
            }
            _loc2_ = object.getModel();
            var_1132 = _loc2_.getNumber("furniture_size_x");
            var_1224 = _loc2_.getNumber("furniture_size_y");
         }
         var_834 = [];
         var_1052 = [];
         var _loc1_:int = 0;
         while(0 < var_1132 * 2 + var_1224 * 2)
         {
            var_834.push(false);
            var_1052.push(1);
            _loc1_++;
         }
      }
      
      private function getAreaData() : Array
      {
         var _loc1_:int = var_1132 + 2;
         var _loc5_:int = var_1224 + 2;
         var _loc6_:Array = [];
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc5_)
         {
            _loc4_ = [];
            _loc2_ = _loc1_ - 1;
            while(_loc2_ >= 0)
            {
               _loc4_.push(false);
               _loc2_--;
            }
            _loc6_.push(_loc4_);
            _loc3_++;
         }
         _loc3_ = 1;
         while(_loc3_ < _loc5_ - 1)
         {
            _loc4_ = _loc6_[_loc3_];
            _loc2_ = 1;
            while(_loc2_ < _loc1_ - 1)
            {
               _loc4_[_loc2_] = true;
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc6_;
      }
      
      private function initializeShoreMasks(param1:Number) : Boolean
      {
         return ShoreMaskCreatorUtility.initializeShoreMasks(getSize(param1),assetCollection,getShoreAsset(param1));
      }
      
      private function createShoreMask(param1:int, param2:int, param3:Number) : BitmapData
      {
         if(var_105 == null || var_105.width < param1 || var_105.height < param2)
         {
            if(var_105 != null)
            {
               var_105.dispose();
            }
            var_105 = ShoreMaskCreatorUtility.createEmptyMask(param1,param2);
         }
         return ShoreMaskCreatorUtility.createShoreMask2x2(var_105,getSize(param3),var_834,var_1052,assetCollection);
      }
      
      private function updateInstanceShoreMask(param1:Number) : Boolean
      {
         var _loc3_:BitmapData = null;
         if(!_needsShoreUpdate)
         {
            return false;
         }
         var _loc5_:IGraphicAsset = getInstanceMask(param1);
         if(_loc5_ != null && _loc5_.asset != null && initializeShoreMasks(param1))
         {
            _loc3_ = _loc5_.asset.content as BitmapData;
            if(_loc3_ != null)
            {
               var _loc6_:BitmapData = createShoreMask(_loc3_.width,_loc3_.height,param1);
               var _loc2_:IGraphicAsset = getShoreAsset(param1);
            }
            return true;
         }
         return false;
      }
      
      override protected function setAnimation(param1:int) : void
      {
         super.setAnimation(0);
      }
   }
}

