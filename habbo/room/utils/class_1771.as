package com.sulake.habbo.room.utils
{
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class class_1771
   {
      
      private static const MOVE_SPEED_DENOMINATOR:Number = 12;
      
      private var var_4433:int = -1;
      
      private var var_4562:int = -2;
      
      private var var_318:Vector3d = null;
      
      private var var_1969:Number = 0;
      
      private var var_2209:Number = 0;
      
      private var var_3326:Boolean = false;
      
      private var var_235:Vector3d = null;
      
      private var var_3556:Vector3d = new Vector3d();
      
      private var var_4370:Boolean = false;
      
      private var var_5107:Boolean = false;
      
      private var var_4857:Boolean = false;
      
      private var var_4794:Boolean = false;
      
      private var var_4915:int = 0;
      
      private var var_4907:int = 0;
      
      private var var_337:int = 0;
      
      private var var_4066:int = 0;
      
      private var var_4626:int = 0;
      
      private var var_2795:int = -1;
      
      private var var_3379:Boolean = false;
      
      private var var_4221:int;
      
      public function class_1771()
      {
         super();
      }
      
      public function get location() : IVector3d
      {
         return var_235;
      }
      
      public function get targetId() : int
      {
         return var_4433;
      }
      
      public function get targetCategory() : int
      {
         return var_4562;
      }
      
      public function get targetObjectLoc() : IVector3d
      {
         return var_3556;
      }
      
      public function get limitedLocationX() : Boolean
      {
         return var_4370;
      }
      
      public function get limitedLocationY() : Boolean
      {
         return var_5107;
      }
      
      public function get centeredLocX() : Boolean
      {
         return var_4857;
      }
      
      public function get centeredLocY() : Boolean
      {
         return var_4794;
      }
      
      public function get screenWd() : int
      {
         return var_4915;
      }
      
      public function get screenHt() : int
      {
         return var_4907;
      }
      
      public function get scale() : int
      {
         return var_337;
      }
      
      public function get roomWd() : int
      {
         return var_4066;
      }
      
      public function get roomHt() : int
      {
         return var_4626;
      }
      
      public function get geometryUpdateId() : int
      {
         return var_2795;
      }
      
      public function get isMoving() : Boolean
      {
         if(var_318 != null && var_235 != null)
         {
            return true;
         }
         return false;
      }
      
      public function set targetId(param1:int) : void
      {
         var_4433 = param1;
      }
      
      public function set targetObjectLoc(param1:IVector3d) : void
      {
         var_3556.assign(param1);
      }
      
      public function set targetCategory(param1:int) : void
      {
         var_4562 = param1;
      }
      
      public function set limitedLocationX(param1:Boolean) : void
      {
         var_4370 = param1;
      }
      
      public function set limitedLocationY(param1:Boolean) : void
      {
         var_5107 = param1;
      }
      
      public function set centeredLocX(param1:Boolean) : void
      {
         var_4857 = param1;
      }
      
      public function set centeredLocY(param1:Boolean) : void
      {
         var_4794 = param1;
      }
      
      public function set screenWd(param1:int) : void
      {
         var_4915 = param1;
      }
      
      public function set screenHt(param1:int) : void
      {
         var_4907 = param1;
      }
      
      public function set scale(param1:int) : void
      {
         if(var_337 != param1)
         {
            var_337 = param1;
            var_3379 = true;
         }
      }
      
      public function set roomWd(param1:int) : void
      {
         var_4066 = param1;
      }
      
      public function set roomHt(param1:int) : void
      {
         var_4626 = param1;
      }
      
      public function set geometryUpdateId(param1:int) : void
      {
         var_2795 = param1;
      }
      
      public function set target(param1:IVector3d) : void
      {
         var _loc2_:Vector3d = null;
         if(var_318 == null)
         {
            var_318 = new Vector3d();
         }
         if(var_318.x != param1.x || var_318.y != param1.y || var_318.z != param1.z)
         {
            var_318.assign(param1);
            _loc2_ = Vector3d.dif(var_318,var_235);
            var_1969 = _loc2_.length;
            var_3326 = true;
         }
      }
      
      public function dispose() : void
      {
         var_318 = null;
         var_235 = null;
      }
      
      public function initializeLocation(param1:IVector3d) : void
      {
         if(var_235 != null)
         {
            return;
         }
         var_235 = new Vector3d();
         var_235.assign(param1);
      }
      
      public function resetLocation(param1:IVector3d) : void
      {
         if(var_235 == null)
         {
            var_235 = new Vector3d();
         }
         var_235.assign(param1);
      }
      
      public function update(param1:uint, param2:Number) : void
      {
         var _loc4_:Vector3d = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:Number = NaN;
         if(var_4221 > 0 && var_318 != null && var_235 != null)
         {
            if(var_3379)
            {
               var_3379 = false;
               var_235 = var_318;
               var_318 = null;
               return;
            }
            _loc4_ = Vector3d.dif(var_318,var_235);
            if(_loc4_.length > var_1969)
            {
               var_1969 = _loc4_.length;
            }
            if(_loc4_.length <= param2)
            {
               var_235 = var_318;
               var_318 = null;
               var_2209 = 0;
            }
            else
            {
               _loc5_ = Math.sin(3.141592653589793 * _loc4_.length / var_1969);
               _loc6_ = param2 * 0.5;
               _loc3_ = var_1969 / 12;
               _loc7_ = _loc6_ + (_loc3_ - _loc6_) * _loc5_;
               if(var_3326)
               {
                  if(_loc7_ < var_2209)
                  {
                     _loc7_ = var_2209;
                     if(_loc7_ > _loc4_.length)
                     {
                        _loc7_ = _loc4_.length;
                     }
                  }
                  else
                  {
                     var_3326 = false;
                  }
               }
               var_2209 = _loc7_;
               _loc4_.div(_loc4_.length);
               _loc4_.mul(_loc7_);
               var_235 = Vector3d.sum(var_235,_loc4_);
            }
         }
      }
      
      public function reset() : void
      {
         var_2795 = -1;
      }
      
      public function activateFollowing(param1:int) : void
      {
         var_4221 = param1;
      }
   }
}

