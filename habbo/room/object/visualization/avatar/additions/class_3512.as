package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.habbo.room.object.visualization.avatar.AvatarVisualization;
   
   public class class_3512
   {
      
      public static const WAVE:int = 1;
      
      public static const BLOW:int = 2;
      
      public static const LAUGH:int = 3;
      
      public static const CRY:int = 4;
      
      public static const const_19:int = 5;
      
      public function class_3512()
      {
         super();
      }
      
      public static function make(param1:int, param2:int, param3:AvatarVisualization) : IExpressionAddition
      {
         switch(param2 - 2)
         {
            case 0:
               return new FloatingHeart(param1,2,param3);
            default:
               return new ExpressionAddition(param1,param2,param3);
         }
      }
   }
}

