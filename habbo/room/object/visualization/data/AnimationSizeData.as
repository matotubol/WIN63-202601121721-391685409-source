package com.sulake.habbo.room.object.visualization.data
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.utils.class_2119;
   
   public class AnimationSizeData extends SizeData
   {
      
      private var var_617:class_55 = null;
      
      private var var_3261:Array = [];
      
      public function AnimationSizeData(param1:int, param2:int)
      {
         super(param1,param2);
         var_617 = new class_55();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AnimationData = null;
         super.dispose();
         if(var_617 != null)
         {
            _loc1_ = 0;
            while(_loc1_ < var_617.length)
            {
               _loc2_ = var_617.getWithIndex(_loc1_) as AnimationData;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
               _loc1_++;
            }
            var_617.dispose();
            var_617 = null;
         }
      }
      
      public function defineAnimations(param1:XML) : Boolean
      {
         var _loc6_:int = 0;
         var _loc10_:XML = null;
         var _loc14_:int = 0;
         var _loc13_:Boolean = false;
         var _loc5_:String = null;
         var _loc3_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:AnimationData = null;
         var _loc8_:Array = null;
         var _loc11_:Array = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         var _loc7_:Array = ["id"];
         var _loc9_:XMLList = param1.animation;
         _loc6_ = 0;
         while(_loc6_ < _loc9_.length())
         {
            _loc10_ = _loc9_[_loc6_];
            if(!class_2119.checkRequiredAttributes(_loc10_,_loc7_))
            {
               return false;
            }
            _loc14_ = int(_loc10_.@id);
            _loc13_ = false;
            _loc5_ = _loc10_.@transitionTo;
            if(_loc5_.length > 0)
            {
               _loc3_ = int(_loc5_);
               _loc14_ = AnimationData.getTransitionToAnimationId(_loc3_);
               _loc13_ = true;
            }
            _loc5_ = _loc10_.@transitionFrom;
            if(_loc5_.length > 0)
            {
               _loc12_ = int(_loc5_);
               _loc14_ = AnimationData.getTransitionFromAnimationId(_loc12_);
               _loc13_ = true;
            }
            _loc2_ = createAnimationData();
            if(!_loc2_.initialize(_loc10_))
            {
               _loc2_.dispose();
               return false;
            }
            _loc5_ = _loc10_.@immediateChangeFrom;
            if(_loc5_.length > 0)
            {
               _loc8_ = _loc5_.split(",");
               _loc11_ = [];
               for each(var _loc15_ in _loc8_)
               {
                  _loc4_ = int(_loc15_);
                  if(_loc11_.indexOf(_loc4_) < 0)
                  {
                     _loc11_.push(_loc4_);
                  }
               }
               _loc2_.setImmediateChanges(_loc11_);
            }
            var_617.add(_loc14_,_loc2_);
            if(!_loc13_)
            {
               var_3261.push(_loc14_);
            }
            _loc6_++;
         }
         return true;
      }
      
      protected function createAnimationData() : AnimationData
      {
         return new AnimationData();
      }
      
      public function hasAnimation(param1:int) : Boolean
      {
         if(var_617.getValue(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      public function getAnimationCount() : int
      {
         return var_3261.length;
      }
      
      public function getAnimationId(param1:int) : int
      {
         var _loc2_:int = getAnimationCount();
         if(param1 >= 0 && _loc2_ > 0)
         {
            return var_3261[param1 % _loc2_];
         }
         return 0;
      }
      
      public function isImmediateChange(param1:int, param2:int) : Boolean
      {
         var _loc3_:AnimationData = var_617.getValue(param1) as AnimationData;
         if(_loc3_ != null)
         {
            return _loc3_.isImmediateChange(param2);
         }
         return false;
      }
      
      public function getStartFrame(param1:int, param2:int) : int
      {
         var _loc3_:AnimationData = var_617.getValue(param1) as AnimationData;
         if(_loc3_ != null)
         {
            return _loc3_.getStartFrame(param2);
         }
         return 0;
      }
      
      public function getFrame(param1:int, param2:int, param3:int, param4:int) : AnimationFrame
      {
         var _loc5_:AnimationData = var_617.getValue(param1) as AnimationData;
         if(_loc5_ != null)
         {
            return _loc5_.getFrame(param2,param3,param4);
         }
         return null;
      }
      
      public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : AnimationFrame
      {
         var _loc7_:AnimationData = var_617.getValue(param1) as AnimationData;
         if(_loc7_ != null)
         {
            return _loc7_.getFrameFromSequence(param2,param3,param4,param5,param6);
         }
         return null;
      }
   }
}

