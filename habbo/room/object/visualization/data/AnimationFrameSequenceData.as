package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrameSequenceData
   {
      
      private var var_353:Array = [];
      
      private var var_1045:Array = [];
      
      private var var_2216:Array = [];
      
      private var var_3756:Boolean = false;
      
      private var var_2777:int = 1;
      
      public function AnimationFrameSequenceData(param1:int, param2:Boolean)
      {
         super();
         if(param1 < 1)
         {
            param1 = 1;
         }
         var_2777 = param1;
         var_3756 = param2;
      }
      
      public function get isRandom() : Boolean
      {
         return var_3756;
      }
      
      public function get frameCount() : int
      {
         return var_1045.length * var_2777;
      }
      
      public function dispose() : void
      {
         var_353 = [];
      }
      
      public function initialize() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 1;
         var _loc2_:int = -1;
         _loc3_ = var_1045.length - 1;
         while(_loc3_ >= 0)
         {
            if(var_1045[_loc3_] == _loc2_)
            {
               _loc1_++;
            }
            else
            {
               _loc2_ = int(var_1045[_loc3_]);
               _loc1_ = 1;
            }
            var_2216[_loc3_] = _loc1_;
            _loc3_--;
         }
      }
      
      public function addFrame(param1:int, param2:int, param3:int, param4:int, param5:int, param6:class_2427) : void
      {
         var _loc8_:AnimationFrameData = null;
         if(var_353.length > 0)
         {
            _loc8_ = var_353[var_353.length - 1];
            if(_loc8_.id == param1 && !_loc8_.hasDirectionalOffsets() && _loc8_.x == param2 && _loc8_.y == param3 && _loc8_.randomX == param4 && param4 == 0 && _loc8_.randomY == param5 && param5 == 0)
            {
               var _loc7_:int = 1 + _loc8_.repeats;
               var_353.pop();
            }
         }
         var _loc9_:AnimationFrameData = null;
         if(param6 == null)
         {
            _loc9_ = new AnimationFrameData(param1,param2,param3,param4,param5,1);
         }
         else
         {
            _loc9_ = new AnimationFrameDirectionalData(param1,param2,param3,param4,param5,param6,1);
         }
         var_353.push(_loc9_);
         var_1045.push(var_353.length - 1);
         var_2216.push(1);
      }
      
      public function getFrame(param1:int) : AnimationFrameData
      {
         if(var_353.length == 0 || param1 < 0 || param1 >= frameCount)
         {
            return null;
         }
         param1 = int(var_1045[param1 % var_1045.length]);
         return var_353[param1] as AnimationFrameData;
      }
      
      public function getFrameIndex(param1:int) : int
      {
         if(param1 < 0 || param1 >= frameCount)
         {
            return -1;
         }
         if(var_3756)
         {
            param1 = Math.random() * var_1045.length;
            if(param1 == var_1045.length)
            {
               param1--;
            }
         }
         return param1;
      }
      
      public function getRepeats(param1:int) : int
      {
         if(param1 < 0 || param1 >= frameCount)
         {
            return 0;
         }
         return var_2216[param1 % var_2216.length];
      }
   }
}

