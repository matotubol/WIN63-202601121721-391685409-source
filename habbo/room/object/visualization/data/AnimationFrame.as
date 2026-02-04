package com.sulake.habbo.room.object.visualization.data
{
   public class AnimationFrame
   {
      
      public static const FRAME_REPEAT_FOREVER:int = -1;
      
      public static const const_1218:int = -1;
      
      private static const POOL_SIZE_LIMIT:int = 6000;
      
      private static const const_17:Array = [];
      
      private var var_197:int = 0;
      
      private var var_25:int = 0;
      
      private var var_26:int = 0;
      
      private var var_2743:int = 1;
      
      private var var_2216:int = 1;
      
      private var var_3410:int = 1;
      
      private var var_5202:int = -1;
      
      private var _activeSequenceOffset:int = 0;
      
      private var _isLastFrame:Boolean = false;
      
      private var var_3432:Boolean = false;
      
      public function AnimationFrame()
      {
         super();
      }
      
      public static function allocate(param1:int, param2:int, param3:int, param4:int, param5:int, param6:Boolean, param7:int = -1, param8:int = 0) : AnimationFrame
      {
         var _loc9_:AnimationFrame = const_17.length > 0 ? const_17.pop() : new AnimationFrame();
         _loc9_.var_3432 = false;
         _loc9_.var_197 = param1;
         _loc9_.var_25 = param2;
         _loc9_.var_26 = param3;
         _loc9_._isLastFrame = param6;
         if(param4 < 1)
         {
            param4 = 1;
         }
         _loc9_.var_2743 = param4;
         if(param5 < 0)
         {
            param5 = -1;
         }
         _loc9_.var_2216 = param5;
         _loc9_.var_3410 = param5;
         if(param7 >= 0)
         {
            _loc9_.var_5202 = param7;
            _loc9_._activeSequenceOffset = param8;
         }
         return _loc9_;
      }
      
      public function get id() : int
      {
         if(var_197 >= 0)
         {
            return var_197;
         }
         return -var_197 * Math.random();
      }
      
      public function get x() : int
      {
         return var_25;
      }
      
      public function get y() : int
      {
         return var_26;
      }
      
      public function get repeats() : int
      {
         return var_2743;
      }
      
      public function get frameRepeats() : int
      {
         return var_2216;
      }
      
      public function get isLastFrame() : Boolean
      {
         return _isLastFrame;
      }
      
      public function get remainingFrameRepeats() : int
      {
         if(var_2216 < 0)
         {
            return -1;
         }
         return var_3410;
      }
      
      public function set remainingFrameRepeats(param1:int) : void
      {
         if(param1 < 0)
         {
            param1 = 0;
         }
         if(var_2216 > 0 && param1 > var_2216)
         {
            param1 = var_2216;
         }
         var_3410 = param1;
      }
      
      public function get activeSequence() : int
      {
         return var_5202;
      }
      
      public function get activeSequenceOffset() : int
      {
         return _activeSequenceOffset;
      }
      
      public function recycle() : void
      {
         if(!var_3432)
         {
            var_3432 = true;
            if(const_17.length < 6000)
            {
               const_17.push(this);
            }
         }
      }
   }
}

