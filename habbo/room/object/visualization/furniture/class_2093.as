package com.sulake.habbo.room.object.visualization.furniture
{
   public class class_2093 extends AnimatedFurnitureVisualization
   {
      
      private static const SECONDS_SPRITE_TAG:String = "seconds_sprite";
      
      private static const TEN_SECONDS_SPRITE_TAG:String = "ten_seconds_sprite";
      
      private static const MINUTES_SPRITE_TAG:String = "minutes_sprite";
      
      private static const TEN_MINUTES_SPRITE_TAG:String = "ten_minutes_sprite";
      
      public function class_2093()
      {
         super();
      }
      
      override public function get animationId() : int
      {
         return 0;
      }
      
      override protected function getFrameNumber(param1:int, param2:int) : int
      {
         var _loc4_:String = getSpriteTag(param1,direction,param2);
         var _loc3_:int = super.animationId;
         switch(_loc4_)
         {
            case "seconds_sprite":
               return _loc3_ % 60 % 10;
            case "ten_seconds_sprite":
               return _loc3_ % 60 / 10;
            case "minutes_sprite":
               return _loc3_ / 60 % 10;
            case "ten_minutes_sprite":
               return _loc3_ / 60 / 10 % 10;
            default:
               return super.getFrameNumber(param1,param2);
         }
      }
   }
}

