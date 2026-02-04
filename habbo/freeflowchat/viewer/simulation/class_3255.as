package com.sulake.habbo.freeflowchat.viewer.simulation
{
   public class class_3255
   {
      
      public static const INPUT_GRAVITY_COEFFICIENT:int = 60;
      
      public static const INPUT_GRAVITY_USERPOS_MARGIN:int = 15;
      
      public static const INPUT_GRAVITY_MAX_IMPULSE:Number = 40;
      
      private const MAX_ATTRACTION_RANGE:Number = 380;
      
      private const NORMAL_SCALING_COEFFICENT:Number = 1;
      
      public function class_3255()
      {
         super();
      }
      
      public function getAttraction(param1:ChatBubbleSimulationEntity, param2:ChatBubbleSimulationEntity, param3:Number = 1, param4:Number = 100) : Number
      {
         var _loc5_:Number = Math.abs(param2.centerX - param1.centerX);
         if(_loc5_ > 380)
         {
            return 0;
         }
         if(_loc5_ < 1)
         {
            return 0;
         }
         return (int(param1.centerX <= param2.centerX ? 1 : -1)) * Math.min(Math.min(_loc5_,param3 / _loc5_),param4);
      }
   }
}

