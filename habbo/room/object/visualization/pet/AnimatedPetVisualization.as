package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.habbo.room.object.visualization.data.AnimationData;
   import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
   import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
   import com.sulake.habbo.room.object.visualization.furniture.AnimatedFurnitureVisualization;
   import com.sulake.habbo.room.object.visualization.furniture.FurnitureVisualizationData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.IGraphicAsset;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   
   public class AnimatedPetVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const HEAD_SPRITE_TAG:String = "head";
      
      private static const SADDLE_SPRITE_TAG:String = "saddle";
      
      private static const HAIR_SPRITE_TAG:String = "hair";
      
      private static const ADDITIONAL_SPRITE_COUNT:int = 1;
      
      private static const EXPERIENCE_BUBBLE_VISIBLE_IN_MS:int = 1000;
      
      private static const EXPERIENCE_BUBBLE_ASSET_NAME:String = "pet_experience_bubble_png";
      
      private static const POSTURE_ANIMATION_INDEX:int = 0;
      
      private static const GESTURE_ANIMATION_INDEX:int = 1;
      
      private static const const_857:int = 2;
      
      private var var_359:String = "";
      
      private var var_2937:String = "";
      
      private var var_2869:Boolean = false;
      
      private var _headDirection:int = 0;
      
      private var var_722:ExperienceData;
      
      private var var_2630:int = 0;
      
      private var var_4116:int = 0;
      
      private var var_244:AnimatedPetVisualizationData = null;
      
      private var _paletteName:String = "";
      
      private var var_3673:int = -1;
      
      private var var_1975:Array = [];
      
      private var var_3052:Array = [];
      
      private var var_3168:Array = [];
      
      private var _color:int = 16777215;
      
      private var _headOnly:Boolean = false;
      
      private var var_4070:Boolean = false;
      
      private var var_246:Array = [];
      
      private var var_1882:Boolean = false;
      
      private var _headSprites:Array = [];
      
      private var var_1944:Array = [];
      
      private var var_2635:Array = [];
      
      private var var_4094:int = -1;
      
      public function AnimatedPetVisualization()
      {
         super();
         while(var_246.length < 2)
         {
            var_246.push(new AnimationStateData());
         }
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AnimationStateData = null;
         super.dispose();
         if(var_246 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_246.length)
            {
               _loc1_ = var_246[_loc2_] as AnimationStateData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_246 = null;
         }
         if(var_722)
         {
            var_722.dispose();
            var_722 = null;
         }
      }
      
      override protected function getAnimationId(param1:AnimationStateData) : int
      {
         return param1.animationId;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         if(!(param1 is AnimatedPetVisualizationData))
         {
            return false;
         }
         var_244 = param1 as AnimatedPetVisualizationData;
         var _loc3_:BitmapData = null;
         if(var_244.commonAssets != null)
         {
            var _loc2_:BitmapDataAsset = var_244.commonAssets.getAssetByName("pet_experience_bubble_png") as BitmapDataAsset;
         }
         if(super.initialize(param1))
         {
            return true;
         }
         return false;
      }
      
      override protected function set direction(param1:int) : void
      {
         if(super.direction != param1)
         {
            super.direction = param1;
            var_1676 = true;
         }
      }
      
      override public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
         super.update(param1,param2,param3,param4);
         updateExperienceBubble(param2);
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         var _loc3_:int = 0;
         var _loc2_:IRoomObject = object;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getDirection().x;
            if(_loc3_ != var_4094)
            {
               var_4094 = _loc3_;
               resetAllAnimationFrames();
            }
         }
         return super.updateAnimation(param1);
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc5_:String = null;
         var _loc10_:String = null;
         var _loc11_:Number = NaN;
         var _loc7_:int = 0;
         var _loc2_:Number = NaN;
         var _loc6_:int = 0;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc13_:IRoomObject = object;
         if(_loc13_ == null)
         {
            return false;
         }
         var _loc14_:IRoomObjectModel = _loc13_.getModel();
         if(_loc14_ == null)
         {
            return false;
         }
         if(_loc14_.getUpdateID() != var_262)
         {
            _loc5_ = _loc14_.getString("figure_posture");
            _loc10_ = _loc14_.getString("figure_gesture");
            _loc11_ = _loc14_.getNumber("figure_posture");
            if(!isNaN(_loc11_))
            {
               _loc7_ = var_244.getPostureCount(var_199);
               if(_loc7_ > 0)
               {
                  _loc5_ = var_244.getPostureForAnimation(var_199,_loc11_ % _loc7_,true);
                  _loc10_ = null;
               }
            }
            _loc2_ = _loc14_.getNumber("figure_gesture");
            if(!isNaN(_loc2_))
            {
               _loc6_ = var_244.getGestureCount(var_199);
               if(_loc6_ > 0)
               {
                  _loc10_ = var_244.getGestureForAnimation(var_199,_loc2_ % _loc6_);
               }
            }
            validateActions(_loc5_,_loc10_);
            _loc8_ = _loc14_.getNumber("furniture_alpha_multiplier");
            if(isNaN(_loc8_))
            {
               _loc8_ = 1;
            }
            if(_loc8_ != var_1756)
            {
               var_1756 = _loc8_;
               var_1531 = true;
            }
            var_2869 = _loc14_.getNumber("figure_sleep") > 0;
            _loc4_ = _loc14_.getNumber("head_direction");
            if(!isNaN(_loc4_) && var_244.isAllowedToTurnHead)
            {
               _headDirection = _loc4_;
            }
            else
            {
               _headDirection = _loc13_.getDirection().x;
            }
            var_2630 = _loc14_.getNumber("figure_experience_timestamp");
            var_4116 = _loc14_.getNumber("figure_gained_experience");
            var _loc16_:int = _loc14_.getNumber("pet_palette_index");
            if(_loc16_ != var_3673)
            {
               var_3673 = 0;
               _paletteName = var_3673.toString();
            }
            var _loc15_:Array = _loc14_.getNumberArray("pet_custom_layer_ids");
            var_1975 = _loc15_ != null ? null : [];
            var _loc12_:Array = _loc14_.getNumberArray("pet_custom_part_ids");
            var_3052 = _loc12_ != null ? null : [];
            var _loc17_:Array = _loc14_.getNumberArray("pet_custom_palette_ids");
            var_3168 = _loc17_ != null ? null : [];
            var _loc9_:int = _loc14_.getNumber("pet_is_riding");
            var_4070 = !isNaN(0) && 0 > 0;
            _loc3_ = _loc14_.getNumber("pet_color");
            if(!isNaN(_loc3_) && _loc3_ != _color)
            {
               _color = _loc3_;
            }
            _headOnly = _loc14_.getNumber("pet_head_only") > 0;
            var_262 = _loc14_.getUpdateID();
            return true;
         }
         return false;
      }
      
      private function updateExperienceBubble(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:IRoomObjectSprite = null;
         if(var_722 != null)
         {
            var_722.alpha = 0;
            if(var_2630 > 0)
            {
               _loc2_ = param1 - var_2630;
               if(_loc2_ < 1000)
               {
                  var_722.alpha = Math.sin(_loc2_ / 1000 * 3.141592653589793) * 255;
                  var_722.setExperience(var_4116);
               }
               else
               {
                  var_2630 = 0;
               }
               _loc3_ = getSprite(spriteCount - 1);
               if(_loc3_ != null)
               {
                  if(var_722.alpha > 0)
                  {
                     _loc3_.asset = var_722.image;
                     _loc3_.offsetX = -20;
                     _loc3_.offsetY = -80;
                     _loc3_.alpha = var_722.alpha;
                     _loc3_.visible = true;
                  }
                  else
                  {
                     _loc3_.asset = null;
                     _loc3_.visible = false;
                  }
               }
            }
         }
      }
      
      private function validateActions(param1:String, param2:String) : void
      {
         if(param1 != var_359)
         {
            var_359 = param1;
            var _loc3_:int = var_244.getAnimationForPosture(var_199,param1);
            setAnimationForIndex(0,0);
         }
         if(var_244.getGestureDisabled(var_199,param1))
         {
            param2 = null;
         }
         if(param2 != var_2937)
         {
            var_2937 = param2;
            _loc3_ = var_244.getAnimationForGesture(var_199,param2);
            setAnimationForIndex(1,0);
         }
      }
      
      override protected function updateLayerCount(param1:int) : void
      {
         super.updateLayerCount(param1);
         _headSprites = [];
      }
      
      override protected function getAdditionalSpriteCount() : int
      {
         return super.getAdditionalSpriteCount() + 1;
      }
      
      override protected function setAnimation(param1:int) : void
      {
      }
      
      private function getAnimationStateData(param1:int) : AnimationStateData
      {
         var _loc2_:* = null;
         if(param1 >= 0 && param1 < var_246.length)
         {
            return var_246[param1];
         }
         return null;
      }
      
      private function setAnimationForIndex(param1:int, param2:int) : void
      {
         var _loc3_:AnimationStateData = getAnimationStateData(param1);
         if(_loc3_ != null)
         {
            if(setSubAnimation(_loc3_,param2))
            {
               var_1882 = false;
            }
         }
      }
      
      override protected function resetAllAnimationFrames() : void
      {
         var_1882 = false;
         var _loc2_:int = var_246.length - 1;
         while(true)
         {
            var _loc1_:AnimationStateData = var_246[0];
            _loc2_--;
         }
      }
      
      override protected function updateAnimations(param1:Number) : int
      {
         var _loc5_:int = 0;
         var _loc4_:AnimationStateData = null;
         var _loc6_:int = 0;
         if(var_1882)
         {
            return 0;
         }
         var _loc3_:Boolean = true;
         var _loc2_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < var_246.length)
         {
            _loc4_ = var_246[_loc5_];
            if(_loc4_ != null)
            {
               if(!_loc4_.animationOver)
               {
                  _loc6_ = updateFramesForAnimation(_loc4_,param1);
                  _loc2_ |= _loc6_;
                  if(!_loc4_.animationOver)
                  {
                     _loc3_ = false;
                  }
                  else if(AnimationData.isTransitionFromAnimation(_loc4_.animationId) || AnimationData.isTransitionToAnimation(_loc4_.animationId))
                  {
                     setAnimationForIndex(_loc5_,_loc4_.animationAfterTransitionId);
                     _loc3_ = false;
                  }
               }
            }
            _loc5_++;
         }
         var_1882 = _loc3_;
         return _loc2_;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:AnimationStateData = null;
         _loc4_ = var_246.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = var_246[_loc4_];
            if(_loc3_ != null)
            {
               var _loc5_:AnimationFrame = _loc3_.getFrame(param2);
               if(_loc5_ != null)
               {
                  return null.id;
               }
            }
            _loc4_--;
         }
         return super.getFrameNumber(param1,param2);
      }
      
      override protected function getPostureForAssetFile(param1:int, param2:String) : String
      {
         var _loc5_:int = 0;
         var _loc6_:String = null;
         var _loc4_:Array = param2.split("_");
         var _loc3_:int = int(_loc4_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            if(_loc4_[_loc5_] == "64" || _loc4_[_loc5_] == "32")
            {
               _loc3_ = _loc5_ + 3;
               break;
            }
            _loc5_++;
         }
         var _loc7_:String = null;
         if(_loc3_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc3_];
            _loc6_ = _loc6_.split("@")[0];
            _loc7_ = var_244.getPostureForAnimation(param1,int(_loc6_) / 100,false);
            if(_loc7_ == null)
            {
               _loc7_ = var_244.getGestureForAnimationId(param1,int(_loc6_) / 100);
            }
         }
         return _loc7_;
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:int = 0;
         var _loc5_:AnimationStateData = null;
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         _loc6_ = var_246.length - 1;
         while(_loc6_ >= 0)
         {
            _loc5_ = var_246[_loc6_];
            if(_loc5_ != null)
            {
               var _loc7_:AnimationFrame = _loc5_.getFrame(param3);
               if(_loc7_ != null)
               {
                  _loc4_ += null.x;
               }
            }
            _loc6_--;
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc6_:int = 0;
         var _loc5_:AnimationStateData = null;
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         _loc6_ = var_246.length - 1;
         while(_loc6_ >= 0)
         {
            _loc5_ = var_246[_loc6_];
            if(_loc5_ != null)
            {
               var _loc7_:AnimationFrame = _loc5_.getFrame(param3);
               if(_loc7_ != null)
               {
                  _loc4_ += null.y;
               }
            }
            _loc6_--;
         }
         return _loc4_;
      }
      
      override protected function getAsset(param1:String, param2:int = -1) : IGraphicAsset
      {
         if(assetCollection != null)
         {
            var _loc3_:int = int(var_1975.indexOf(param2));
            var _loc5_:String = _paletteName;
            var _loc6_:int = -1;
            var _loc7_:int = -1;
            _loc6_ = int(var_3052[0]);
            _loc7_ = int(var_3168[0]);
            _loc5_ = _loc7_ > -1 ? String(0) : _paletteName;
            if(!isNaN(0) && 0 > -1)
            {
               param1 += "_" + 0;
            }
            return assetCollection.getAssetWithPalette(param1,null);
         }
         return null;
      }
      
      override protected function getSpriteZOffset(param1:int, param2:int, param3:int) : Number
      {
         if(var_244 == null)
         {
            return 0;
         }
         return var_244.getZOffset(param1,getDirection(param1,param3),param3);
      }
      
      override protected function getSpriteAssetName(param1:int, param2:int) : String
      {
         if(_headOnly && isNonHeadSprite(param2))
         {
            return null;
         }
         if(var_4070 && isSaddleSprite(param2))
         {
            return null;
         }
         var _loc4_:int = spriteCount;
         if(param2 < _loc4_ - 1)
         {
            var _loc3_:int = getSize(param1);
            if(param2 < _loc4_ - (1 + 1))
            {
               if(param2 >= FurnitureVisualizationData.LAYER_NAMES.length)
               {
                  return null;
               }
               var _loc5_:String = FurnitureVisualizationData.LAYER_NAMES[param2];
               return type + "_" + 0 + "_" + null + "_" + getDirection(param1,param2) + "_" + getFrameNumber(0,param2);
            }
            return type + "_" + 0 + "_sd_" + getDirection(param1,param2) + "_0";
         }
         return null;
      }
      
      override protected function getSpriteColor(param1:int, param2:int, param3:int) : int
      {
         if(param2 < spriteCount - 1)
         {
            return _color;
         }
         return 16777215;
      }
      
      private function getDirection(param1:int, param2:int) : int
      {
         if(isHeadSprite(param2))
         {
            return var_244.getDirectionValue(param1,_headDirection);
         }
         return direction;
      }
      
      private function isHeadSprite(param1:int) : Boolean
      {
         if(_headSprites[param1] == null)
         {
            var _loc3_:* = var_244.getTag(var_199,-1,param1) == "head";
            var _loc2_:* = var_244.getTag(var_199,-1,param1) == "hair";
            _headSprites[param1] = false;
         }
         return _headSprites[param1];
      }
      
      private function isNonHeadSprite(param1:int) : Boolean
      {
         if(var_1944[param1] == null)
         {
            if(param1 < spriteCount - (1 + 1))
            {
               var _loc2_:String = var_244.getTag(var_199,-1,param1);
               if(null != null)
               {
                  var_1944[param1] = true;
               }
               else
               {
                  var_1944[param1] = false;
               }
            }
            else
            {
               var_1944[param1] = true;
            }
         }
         return var_1944[param1];
      }
      
      private function isSaddleSprite(param1:int) : Boolean
      {
         if(var_2635[param1] == null)
         {
            if(var_244.getTag(var_199,-1,param1) == "saddle")
            {
               var_2635[param1] = true;
            }
            else
            {
               var_2635[param1] = false;
            }
         }
         return var_2635[param1];
      }
   }
}

