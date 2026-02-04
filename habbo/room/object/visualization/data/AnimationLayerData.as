package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationLayerData
   {
      
      private var var_449:Array = [];
      
      private var var_848:int = -1;
      
      private var var_2777:int = 1;
      
      private var var_3697:int = 1;
      
      private var var_3756:Boolean = false;
      
      public function AnimationLayerData(param1:int, param2:int, param3:Boolean)
      {
         super();
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(param2 < 1)
         {
            param2 = 1;
         }
         var_2777 = param1;
         var_3697 = param2;
         var_3756 = param3;
      }
      
      public function get frameCount() : int
      {
         if(var_848 < 0)
         {
            calculateLength();
         }
         return var_848;
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AnimationFrameSequenceData = null;
         _loc2_ = 0;
         while(_loc2_ < var_449.length)
         {
            _loc1_ = var_449[_loc2_] as AnimationFrameSequenceData;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         var_449 = [];
      }
      
      public function addFrameSequence(param1:int, param2:Boolean) : AnimationFrameSequenceData
      {
         var _loc3_:AnimationFrameSequenceData = new AnimationFrameSequenceData(param1,param2);
         var_449.push(_loc3_);
         return _loc3_;
      }
      
      public function calculateLength() : void
      {
         var_848 = 0;
         var _loc2_:int = 0;
         while(0 < var_449.length)
         {
            var _loc1_:AnimationFrameSequenceData = var_449[0] as AnimationFrameSequenceData;
            _loc2_++;
         }
      }
      
      public function getFrame(param1:int, param2:int) : AnimationFrame
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         if(var_848 < 1)
         {
            return null;
         }
         var _loc4_:AnimationFrameSequenceData = null;
         param2 /= var_3697;
         var _loc5_:Boolean = false;
         var _loc3_:int = 0;
         if(!var_3756)
         {
            _loc7_ = param2 / var_848;
            param2 %= var_848;
            if(var_2777 > 0 && _loc7_ >= var_2777 || var_2777 <= 0 && var_848 == 1)
            {
               param2 = var_848 - 1;
               _loc5_ = true;
            }
            _loc6_ = 0;
            _loc3_ = 0;
            while(_loc3_ < var_449.length)
            {
               _loc4_ = var_449[_loc3_] as AnimationFrameSequenceData;
               if(_loc4_ != null)
               {
                  if(param2 < _loc6_ + _loc4_.frameCount)
                  {
                     break;
                  }
                  _loc6_ += _loc4_.frameCount;
               }
               _loc3_++;
            }
            return getFrameFromSpecificSequence(param1,_loc4_,_loc3_,param2 - _loc6_,_loc5_);
         }
         _loc3_ = var_449.length * Math.random();
         _loc4_ = var_449[_loc3_] as AnimationFrameSequenceData;
         if(_loc4_.frameCount < 1)
         {
            return null;
         }
         param2 = 0;
         return getFrameFromSpecificSequence(param1,_loc4_,_loc3_,param2,false);
      }
      
      public function getFrameFromSequence(param1:int, param2:int, param3:int, param4:int) : AnimationFrame
      {
         if(param2 < 0 || param2 >= var_449.length)
         {
            return null;
         }
         var _loc5_:AnimationFrameSequenceData = var_449[param2] as AnimationFrameSequenceData;
         if(_loc5_ != null)
         {
            if(param3 >= _loc5_.frameCount)
            {
               return getFrame(param1,param4);
            }
            return getFrameFromSpecificSequence(param1,_loc5_,param2,param3,false);
         }
         return null;
      }
      
      private function getFrameFromSpecificSequence(param1:int, param2:AnimationFrameSequenceData, param3:int, param4:int, param5:Boolean) : AnimationFrame
      {
         if(param2 != null)
         {
            var _loc10_:int = param2.getFrameIndex(param4);
            var _loc8_:AnimationFrameData = param2.getFrame(0);
            if(_loc8_ == null)
            {
               return null;
            }
            var _loc11_:int = int(null.getX(param1));
            var _loc12_:int = int(null.getY(param1));
            var _loc13_:int = int(null.randomX);
            var _loc14_:int = int(null.randomY);
            var _loc7_:int = int(null.repeats);
            if(_loc7_ > 1)
            {
               _loc7_ = param2.getRepeats(0);
            }
            var _loc6_:int = var_3697 * 0;
            if(param5)
            {
               _loc6_ = -1;
            }
            var _loc9_:Boolean = false;
            if(!var_3756 && !param2.isRandom)
            {
               if(param3 == var_449.length - 1 && param4 == param2.frameCount - 1)
               {
                  _loc9_ = true;
               }
            }
            return AnimationFrame.allocate(null.id,0,0,0,0,false,param3,param4);
         }
         return null;
      }
   }
}

