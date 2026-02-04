package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.visualization.data.AnimationData;
   import com.sulake.habbo.room.object.visualization.data.AnimationFrame;
   import com.sulake.habbo.room.object.visualization.data.AnimationStateData;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   
   public class AnimatedFurnitureVisualization extends FurnitureVisualization
   {
      
      public static const DEFAULT_ANIMATION_ID:int = 0;
      
      private var var_244:AnimatedFurnitureVisualizationData = null;
      
      private var var_61:int = -1;
      
      private var var_240:AnimationStateData;
      
      private var _animationChangeTime:int = 0;
      
      private var var_3525:int = 1;
      
      private var var_892:Number = 0;
      
      private var var_2538:int = 0;
      
      protected var var_1676:Boolean = false;
      
      public function AnimatedFurnitureVisualization()
      {
         super();
         var_240 = new AnimationStateData();
      }
      
      protected function get animatedLayerCount() : int
      {
         return var_2538;
      }
      
      protected function get frameIncrease() : int
      {
         return var_3525;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var_244 = null;
         if(var_240 != null)
         {
            var_240.dispose();
            var_240 = null;
         }
      }
      
      public function get animationId() : int
      {
         return var_240.animationId;
      }
      
      protected function getAnimationId(param1:AnimationStateData) : int
      {
         var _loc2_:int = animationId;
         if(_loc2_ != 0 && var_244.hasAnimation(var_892,_loc2_))
         {
            return _loc2_;
         }
         return 0;
      }
      
      override public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         if(!(param1 is AnimatedFurnitureVisualizationData))
         {
            return false;
         }
         var_244 = param1 as AnimatedFurnitureVisualizationData;
         return super.initialize(param1);
      }
      
      override protected function updateObject(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:IRoomObject = null;
         var _loc6_:int = 0;
         if(super.updateObject(param1,param2))
         {
            _loc3_ = object;
            if(_loc3_ == null)
            {
               return false;
            }
            _loc6_ = _loc3_.getState(0);
            if(_loc6_ != var_61)
            {
               setAnimation(_loc6_);
               var_61 = _loc6_;
               var _loc4_:IRoomObjectModel = _loc3_.getModel();
               if(_loc4_ != null)
               {
                  var _loc5_:int;
                  _animationChangeTime = _loc5_ = int(null.getNumber("furniture_state_update_time"));
               }
            }
            return true;
         }
         return false;
      }
      
      override protected function updateModel(param1:Number) : Boolean
      {
         var _loc2_:IRoomObject = null;
         var _loc4_:IRoomObjectModel = null;
         var _loc5_:int = 0;
         var _loc3_:Number = NaN;
         var _loc6_:int = 0;
         if(super.updateModel(param1))
         {
            _loc2_ = object;
            if(_loc2_ != null)
            {
               _loc4_ = _loc2_.getModel();
               if(_loc4_ != null)
               {
                  if(usesAnimationResetting())
                  {
                     _loc5_ = _loc4_.getNumber("furniture_state_update_time");
                     if(_loc5_ > _animationChangeTime)
                     {
                        _animationChangeTime = _loc5_;
                        setAnimation(var_61);
                     }
                  }
                  _loc3_ = _loc4_.getNumber("furniture_automatic_state_index");
                  if(!isNaN(_loc3_))
                  {
                     _loc6_ = var_244.getAnimationId(var_892,_loc3_);
                     setAnimation(_loc6_);
                  }
               }
            }
            return true;
         }
         return false;
      }
      
      private function isPlayingTransition(param1:AnimationStateData, param2:int) : Boolean
      {
         var _loc3_:int = param1.animationId;
         if(AnimationData.isTransitionFromAnimation(_loc3_) || AnimationData.isTransitionToAnimation(_loc3_))
         {
            if(param2 == param1.animationAfterTransitionId)
            {
               if(!param1.animationOver)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getCurrentState(param1:AnimationStateData) : int
      {
         var _loc2_:int = param1.animationId;
         if(AnimationData.isTransitionFromAnimation(_loc2_) || AnimationData.isTransitionToAnimation(_loc2_))
         {
            return param1.animationAfterTransitionId;
         }
         return _loc2_;
      }
      
      protected function setAnimation(param1:int) : void
      {
         if(var_244 != null)
         {
            setSubAnimation(var_240,param1,var_61 >= 0);
         }
      }
      
      protected function setSubAnimation(param1:AnimationStateData, param2:int, param3:Boolean = true) : Boolean
      {
         var _loc4_:int = param1.animationId;
         if(param3)
         {
            if(isPlayingTransition(param1,param2))
            {
               return false;
            }
            var _loc5_:int = getCurrentState(param1);
            if(param2 != 0)
            {
               if(!var_244.isImmediateChange(var_892,param2,0))
               {
                  var _loc6_:int = AnimationData.getTransitionFromAnimationId(0);
                  if(var_244.hasAnimation(var_892,0))
                  {
                     param1.animationAfterTransitionId = param2;
                     param2 = 0;
                  }
                  else
                  {
                     _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                     if(var_244.hasAnimation(var_892,0))
                     {
                        param1.animationAfterTransitionId = param2;
                        param2 = 0;
                     }
                  }
               }
            }
            else if(AnimationData.isTransitionFromAnimation(_loc4_))
            {
               _loc6_ = AnimationData.getTransitionToAnimationId(param2);
               if(var_244.hasAnimation(var_892,0))
               {
                  param1.animationAfterTransitionId = param2;
                  param2 = 0;
               }
            }
            else if(!AnimationData.isTransitionToAnimation(_loc4_))
            {
               if(usesAnimationResetting())
               {
                  _loc6_ = AnimationData.getTransitionFromAnimationId(0);
                  if(var_244.hasAnimation(var_892,0))
                  {
                     param1.animationAfterTransitionId = param2;
                     param2 = 0;
                  }
                  else
                  {
                     _loc6_ = AnimationData.getTransitionToAnimationId(param2);
                     if(var_244.hasAnimation(var_892,0))
                     {
                        param1.animationAfterTransitionId = param2;
                        param2 = 0;
                     }
                  }
               }
            }
         }
         if(_loc4_ != param2)
         {
            param1.animationId = param2;
            return true;
         }
         return false;
      }
      
      protected function getLastFramePlayed(param1:int) : Boolean
      {
         return var_240.getLastFramePlayed(param1);
      }
      
      protected function resetAllAnimationFrames() : void
      {
         if(var_240 != null)
         {
            var_240.setLayerCount(var_2538);
         }
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         if(var_244 == null)
         {
            return 0;
         }
         if(param1 != var_892)
         {
            var_892 = param1;
            var_2538 = var_244.getLayerCount(param1);
            resetAllAnimationFrames();
         }
         var _loc2_:int = updateAnimations(param1);
         var_1676 = false;
         return _loc2_;
      }
      
      protected function updateAnimations(param1:Number) : int
      {
         var _loc2_:int = 0;
         if(!var_240.animationOver || var_1676)
         {
            _loc2_ = updateFramesForAnimation(var_240,param1);
            if(var_240.animationOver)
            {
               if(AnimationData.isTransitionFromAnimation(var_240.animationId) || AnimationData.isTransitionToAnimation(var_240.animationId))
               {
                  setAnimation(var_240.animationAfterTransitionId);
                  var_240.animationOver = false;
               }
            }
         }
         return _loc2_;
      }
      
      protected function updateFramesForAnimation(param1:AnimationStateData, param2:Number) : int
      {
         var _loc7_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc11_:AnimationFrame = null;
         var _loc3_:int = 0;
         if(param1.animationOver && !var_1676)
         {
            return 0;
         }
         var _loc4_:int = param1.frameCounter;
         var _loc8_:int = getAnimationId(param1);
         if(_loc4_ == 0)
         {
            _loc4_ = var_244.getStartFrame(param2,_loc8_,direction);
         }
         _loc4_ += frameIncrease;
         param1.frameCounter = _loc4_;
         var _loc9_:* = 0;
         param1.animationOver = true;
         var _loc10_:* = 1 << var_2538 - 1;
         _loc7_ = var_2538 - 1;
         while(_loc7_ >= 0)
         {
            _loc5_ = param1.getAnimationPlayed(_loc7_);
            if(!_loc5_ || var_1676)
            {
               _loc6_ = param1.getLastFramePlayed(_loc7_);
               _loc11_ = param1.getFrame(_loc7_);
               if(_loc11_ != null)
               {
                  if(_loc11_.isLastFrame && _loc11_.remainingFrameRepeats <= frameIncrease)
                  {
                     _loc6_ = true;
                  }
               }
               if(var_1676 || _loc11_ == null || _loc11_.remainingFrameRepeats >= 0 && (_loc11_.remainingFrameRepeats -= frameIncrease) <= 0)
               {
                  _loc3_ = -1;
                  if(_loc11_ != null)
                  {
                     _loc3_ = _loc11_.activeSequence;
                  }
                  if(_loc3_ == -1)
                  {
                     _loc11_ = var_244.getFrame(param2,_loc8_,direction,_loc7_,_loc4_);
                  }
                  else
                  {
                     _loc11_ = var_244.getFrameFromSequence(param2,_loc8_,direction,_loc7_,_loc3_,_loc11_.activeSequenceOffset + _loc11_.repeats,_loc4_);
                  }
                  param1.setFrame(_loc7_,_loc11_);
                  _loc9_ |= _loc10_;
               }
               if(_loc11_ == null || _loc11_.remainingFrameRepeats == -1)
               {
                  _loc6_ = true;
                  _loc5_ = true;
               }
               else
               {
                  param1.animationOver = false;
               }
               param1.setLastFramePlayed(_loc7_,_loc6_);
               param1.setAnimationPlayed(_loc7_,_loc5_);
            }
            _loc10_ >>= 1;
            _loc7_--;
         }
         return _loc9_;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc3_:AnimationFrame = var_240.getFrame(param2);
         if(_loc3_ != null)
         {
            return _loc3_.id;
         }
         return super.getFrameNumber(param1,param2);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteXOffset(param1,param2,param3);
         var _loc5_:AnimationFrame = var_240.getFrame(param3);
         if(_loc5_ != null)
         {
            _loc4_ += _loc5_.x;
         }
         return _loc4_;
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:int = super.getSpriteYOffset(param1,param2,param3);
         var _loc5_:AnimationFrame = var_240.getFrame(param3);
         if(_loc5_ != null)
         {
            _loc4_ += _loc5_.y;
         }
         return _loc4_;
      }
      
      protected function usesAnimationResetting() : Boolean
      {
         return false;
      }
   }
}

