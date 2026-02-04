package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationStateData
   {
      
      private var var_3478:int = -1;
      
      private var var_4716:int = 0;
      
      private var var_1882:Boolean = false;
      
      private var var_380:int = 0;
      
      private var var_353:Array = [];
      
      private var var_1397:Array = [];
      
      private var var_1442:Array = [];
      
      private var var_1112:int = 0;
      
      public function AnimationStateData()
      {
         super();
      }
      
      public function get animationOver() : Boolean
      {
         return var_1882;
      }
      
      public function set animationOver(param1:Boolean) : void
      {
         var_1882 = param1;
      }
      
      public function get frameCounter() : int
      {
         return var_380;
      }
      
      public function set frameCounter(param1:int) : void
      {
         var_380 = param1;
      }
      
      public function get animationId() : int
      {
         return var_3478;
      }
      
      public function set animationId(param1:int) : void
      {
         if(param1 != var_3478)
         {
            var_3478 = param1;
            resetAnimationFrames(false);
         }
      }
      
      public function get animationAfterTransitionId() : int
      {
         return var_4716;
      }
      
      public function set animationAfterTransitionId(param1:int) : void
      {
         var_4716 = param1;
      }
      
      public function dispose() : void
      {
         recycleFrames();
         var_353 = null;
         var_1397 = null;
         var_1442 = null;
      }
      
      public function setLayerCount(param1:int) : void
      {
         var_1112 = param1;
         resetAnimationFrames();
      }
      
      public function resetAnimationFrames(param1:Boolean = true) : void
      {
         if(param1 || var_353 == null)
         {
            recycleFrames();
            var_353 = [];
         }
         var_1397 = [];
         var_1442 = [];
         var_1882 = false;
         var_380 = 0;
         var _loc2_:int = 0;
         while(0 < var_1112)
         {
            if(param1 || var_353.length <= 0)
            {
               var_353[0] = null;
            }
            else
            {
               var _loc3_:AnimationFrame = var_353[0];
            }
            var_1397[0] = false;
            var_1442[0] = false;
            _loc2_++;
         }
      }
      
      private function recycleFrames() : void
      {
         if(var_353 != null)
         {
            for each(var _loc1_ in var_353)
            {
               if(_loc1_ != null)
               {
                  _loc1_.recycle();
               }
            }
         }
      }
      
      public function getFrame(param1:int) : AnimationFrame
      {
         if(param1 >= 0 && param1 < var_1112)
         {
            return var_353[param1];
         }
         return null;
      }
      
      public function setFrame(param1:int, param2:AnimationFrame) : void
      {
         var _loc3_:AnimationFrame = null;
         if(param1 >= 0 && param1 < var_1112)
         {
            _loc3_ = var_353[param1];
            if(_loc3_ != null)
            {
               _loc3_.recycle();
            }
            var_353[param1] = param2;
         }
      }
      
      public function getAnimationPlayed(param1:int) : Boolean
      {
         if(param1 >= 0 && param1 < var_1112)
         {
            return var_1442[param1];
         }
         return true;
      }
      
      public function setAnimationPlayed(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < var_1112)
         {
            var_1442[param1] = param2;
         }
      }
      
      public function getLastFramePlayed(param1:int) : Boolean
      {
         if(param1 >= 0 && param1 < var_1112)
         {
            return var_1397[param1];
         }
         return true;
      }
      
      public function setLastFramePlayed(param1:int, param2:Boolean) : void
      {
         if(param1 >= 0 && param1 < var_1112)
         {
            var_1397[param1] = param2;
         }
      }
   }
}

