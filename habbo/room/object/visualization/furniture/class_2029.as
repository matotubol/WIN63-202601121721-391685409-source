package com.sulake.habbo.room.object.visualization.furniture
{
   public class class_2029 extends AnimatedFurnitureVisualization
   {
      
      private static const ONES_SPRITE_TAG:String = "ones_sprite";
      
      private static const TENS_SPRITE_TAG:String = "tens_sprite";
      
      private static const HUNDREDS_SPRITE_TAG:String = "hundreds_sprite";
      
      private static const THOUSANDS_SPRITE_TAG:String = "thousands_sprite";
      
      public function class_2029()
      {
         super();
      }
      
      override public function get animationId() : int
      {
         return 0;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc3_:String = getSpriteTag(param1,direction,param2);
         var _loc4_:int = super.animationId;
         switch(_loc3_)
         {
            case "ones_sprite":
               return _loc4_ % 10;
            case "tens_sprite":
               return _loc4_ / 10 % 10;
            case "hundreds_sprite":
               return _loc4_ / 100 % 10;
            case "thousands_sprite":
               return _loc4_ / 1000 % 10;
            default:
               return super.getFrameNumber(param1,param2);
         }
      }
   }
}

