package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   import flash.geom.Point;
   
   public class FurniturePartyBeamerVisualization extends AnimatedFurnitureVisualization
   {
      
      private static const UPDATE_INTERVAL:int = 2;
      
      private static const AREA_DIAMETER_SMALL:int = 15;
      
      private static const AREA_DIAMETER_LARGE:int = 31;
      
      private static const ANIM_SPEED_FAST:int = 2;
      
      private static const const_341:int = 1;
      
      private var var_2443:Array;
      
      private var var_2392:Array;
      
      private var var_2662:Array;
      
      private var var_2599:Array;
      
      private var var_1718:Array = [];
      
      public function FurniturePartyBeamerVisualization()
      {
         super();
      }
      
      override protected function updateAnimation(param1:Number) : int
      {
         var _loc3_:IRoomObjectSprite = null;
         if(var_2662 == null)
         {
            initItems(param1);
         }
         _loc3_ = getSprite(2);
         if(_loc3_ != null)
         {
            var_1718[0] = getNewPoint(param1,0);
         }
         _loc3_ = getSprite(3);
         if(_loc3_ != null)
         {
            var_1718[1] = getNewPoint(param1,1);
         }
         return super.updateAnimation(param1);
      }
      
      override protected function getSpriteXOffset(param1:int, param2:int, param3:int) : int
      {
         if(param3 == 2 || param3 == 3)
         {
            if(var_1718.length == 2)
            {
               return var_1718[param3 - 2].x;
            }
         }
         return super.getSpriteXOffset(param1,param2,param3);
      }
      
      override protected function getSpriteYOffset(param1:int, param2:int, param3:int) : int
      {
         if(param3 == 2 || param3 == 3)
         {
            if(var_1718.length == 2)
            {
               return var_1718[param3 - 2].y;
            }
         }
         return super.getSpriteYOffset(param1,param2,param3);
      }
      
      private function getNewPoint(param1:Number, param2:int) : Point
      {
         var _loc8_:int = 0;
         var _loc10_:Number = Number(var_2443[param2]);
         var _loc3_:int = int(var_2392[param2]);
         var _loc5_:int = int(var_2662[param2]);
         var _loc6_:Number = Number(var_2599[param2]);
         var _loc11_:Number = 1;
         if(param1 == 32)
         {
            _loc8_ = 15;
            _loc11_ = 0.5;
         }
         else
         {
            _loc8_ = 31;
         }
         var _loc7_:Number = _loc10_ + _loc3_ * _loc5_;
         if(Math.abs(_loc7_) >= _loc8_)
         {
            if(_loc3_ > 0)
            {
               _loc10_ -= _loc7_ - _loc8_;
            }
            else
            {
               _loc10_ += -_loc8_ - _loc7_;
            }
            _loc3_ = -_loc3_;
            var_2392[param2] = _loc3_;
         }
         var _loc4_:Number = (_loc8_ - Math.abs(_loc10_)) * _loc6_;
         var _loc9_:Number = _loc3_ * Math.sin(Math.abs(_loc10_ / 4)) * _loc4_;
         if(_loc3_ > 0)
         {
            _loc9_ -= _loc4_;
         }
         else
         {
            _loc9_ += _loc4_;
         }
         _loc10_ += _loc3_ * _loc5_ * _loc11_;
         var_2443[param2] = _loc10_;
         if(int(_loc9_) == 0)
         {
            var_2599[param2] = getRandomAmplitudeFactor();
         }
         return new Point(_loc10_,_loc9_);
      }
      
      private function initItems(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(param1 == 32)
         {
            _loc2_ = 15;
         }
         else
         {
            _loc2_ = 31;
         }
         var_2443 = [];
         var_2443.push(Math.random() * _loc2_ * 1.5);
         var_2443.push(Math.random() * _loc2_ * 1.5);
         var_2392 = [];
         var_2392.push(1);
         var_2392.push(-1);
         var_2662 = [];
         var_2662.push(2);
         var_2662.push(1);
         var_2599 = [];
         var_2599.push(getRandomAmplitudeFactor());
         var_2599.push(getRandomAmplitudeFactor());
      }
      
      private function getRandomAmplitudeFactor() : Number
      {
         return Math.random() * 30 / 100 + 0.15;
      }
   }
}

