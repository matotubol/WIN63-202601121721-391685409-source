package com.sulake.habbo.game.snowwar.utils
{
   public class class_4067
   {
      
      public static const BOUNDING_TYPE_NONE:int = 0;
      
      public static const BOUNDING_TYPE_POINT:int = 1;
      
      public static const BOUNDING_TYPE_CIRCLE:int = 2;
      
      public static const BOUNDING_TYPE_BOX:int = 3;
      
      public static const BOUNDING_TYPE_TRIPLE_CIRCLE:int = 4;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_FIRST_RADIUS:int = 0;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_SECOND_RADIUS:int = 1;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_THIRD_RADIUS:int = 2;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_FIRST_OFFSET:int = 3;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_THIRD_OFFSET:int = 4;
      
      public static const BOUNDING_DATA_TRIPLE_CIRCLE_LARGEST_DISTANCE:int = 5;
      
      public function class_4067()
      {
         super();
      }
      
      public static function testForObjectToObjectCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         if(param2 == param1)
         {
            return false;
         }
         switch(param2.boundingType)
         {
            case 2:
               switch(param1.boundingType - 1)
               {
                  case 0:
                     if(testPointToCircleCollision(param1,param2))
                     {
                        return true;
                     }
                     break;
                  case 1:
                     if(testCircleToCircleCollision(param1,param2))
                     {
                        return true;
                     }
                     break;
                  case 3:
                     if(testCircleToTripleCircleCollision(param2,param1))
                     {
                        return true;
                     }
               }
               break;
            case 3:
               if(param1.boundingType == 1)
               {
                  if(testPointToBoxCollision(param1,param2))
                  {
                     return true;
                  }
               }
               break;
            case 4:
               switch(param1.boundingType - 1)
               {
                  case 0:
                     if(testPointToTripleCircleCollision(param1,param2))
                     {
                        return true;
                     }
                     break;
                  case 1:
                     if(testCircleToTripleCircleCollision(param1,param2))
                     {
                        return true;
                     }
                     break;
                  case 3:
                     if(testTripleCircleToTripleCircleCollision(param1,param2))
                     {
                        return true;
                     }
               }
         }
         return false;
      }
      
      private static function testPointToCircleCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         return param1.location3D.isInDistance(param2.location3D,param2.boundingData[0]);
      }
      
      private static function testPointToBoxCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         var _loc3_:Array = param2.boundingData;
         if(param1.location3D.x > param2.location3D.x + _loc3_[0] && param1.location3D.x < param2.location3D.x + _loc3_[2] && param1.location3D.y > param2.location3D.y + _loc3_[1] && param1.location3D.y < param2.location3D.y + _loc3_[3])
         {
            return true;
         }
         return false;
      }
      
      private static function testCircleToCircleCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         return param1.location3D.isInDistance(param2.location3D,param1.boundingData[0] + param2.boundingData[0]);
      }
      
      private static function testPointToTripleCircleCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         var _loc8_:int = absoluteValue(param2.location3D.x - param1.location3D.x);
         if(_loc8_ > param2.boundingData[5])
         {
            return false;
         }
         var _loc7_:int = absoluteValue(param2.location3D.y - param1.location3D.y);
         if(_loc7_ > param2.boundingData[5])
         {
            return false;
         }
         var _loc5_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         var _loc6_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         if(Location3D.isInDistanceStatic(_loc5_,_loc6_,param1.location3D.x,param1.location3D.y,param2.boundingData[0]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(param2.location3D.x,param2.location3D.y,param1.location3D.x,param1.location3D.y,param2.boundingData[1]))
         {
            return true;
         }
         var _loc3_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         var _loc4_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         if(Location3D.isInDistanceStatic(_loc3_,_loc4_,param1.location3D.x,param1.location3D.y,param2.boundingData[2]))
         {
            return true;
         }
         return false;
      }
      
      private static function testCircleToTripleCircleCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         var _loc8_:int = absoluteValue(param2.location3D.x - param1.location3D.x);
         if(_loc8_ > param1.boundingData[0] + param2.boundingData[5])
         {
            return false;
         }
         var _loc7_:int = absoluteValue(param2.location3D.y - param1.location3D.y);
         if(_loc7_ > param1.boundingData[0] + param2.boundingData[5])
         {
            return false;
         }
         var _loc5_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         var _loc6_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         if(Location3D.isInDistanceStatic(_loc5_,_loc6_,param1.location3D.x,param1.location3D.y,param2.boundingData[0] + param1.boundingData[0]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(param2.location3D.x,param2.location3D.y,param1.location3D.x,param1.location3D.y,param2.boundingData[1] + param1.boundingData[0]))
         {
            return true;
         }
         var _loc3_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         var _loc4_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         if(Location3D.isInDistanceStatic(_loc3_,_loc4_,param1.location3D.x,param1.location3D.y,param2.boundingData[2] + param1.boundingData[0]))
         {
            return true;
         }
         return false;
      }
      
      private static function testTripleCircleToTripleCircleCollision(param1:class_3256, param2:class_3256) : Boolean
      {
         var _loc11_:int = absoluteValue(param2.location3D.x - param1.location3D.x);
         if(_loc11_ > param1.boundingData[5] + param2.boundingData[5])
         {
            return false;
         }
         var _loc10_:int = absoluteValue(param2.location3D.y - param1.location3D.y);
         if(_loc10_ > param1.boundingData[5] + param2.boundingData[5])
         {
            return false;
         }
         var _loc5_:int = param1.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param1.direction360.intValue()) * param1.boundingData[3] / 256);
         var _loc3_:int = param1.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param1.direction360.intValue()) * param1.boundingData[3] / 256);
         var _loc12_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         var _loc6_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[3] / 256);
         if(Location3D.isInDistanceStatic(_loc5_,_loc3_,_loc12_,_loc6_,param1.boundingData[0] + param2.boundingData[0]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(_loc5_,_loc3_,param2.location3D.x,param2.location3D.y,param1.boundingData[0] + param2.boundingData[1]))
         {
            return true;
         }
         var _loc4_:int = param2.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         var _loc8_:int = param2.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param2.direction360.intValue()) * param2.boundingData[4] / 256);
         if(Location3D.isInDistanceStatic(_loc5_,_loc3_,_loc4_,_loc8_,param1.boundingData[0] + param2.boundingData[2]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(param1.location3D.x,param1.location3D.y,_loc12_,_loc6_,param1.boundingData[1] + param2.boundingData[0]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(param1.location3D.x,param1.location3D.y,param2.location3D.x,param2.location3D.y,param1.boundingData[1] + param2.boundingData[1]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(param1.location3D.x,param1.location3D.y,_loc4_,_loc8_,param1.boundingData[1] + param2.boundingData[2]))
         {
            return true;
         }
         var _loc9_:int = param1.location3D.x + class_3895.javaDiv(Direction360.getBaseVectorXComponent(param1.direction360.intValue()) * param1.boundingData[4] / 256);
         var _loc7_:int = param1.location3D.y + class_3895.javaDiv(Direction360.getBaseVectorYComponent(param1.direction360.intValue()) * param1.boundingData[4] / 256);
         if(Location3D.isInDistanceStatic(_loc9_,_loc7_,_loc12_,_loc6_,param1.boundingData[2] + param2.boundingData[0]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(_loc9_,_loc7_,param2.location3D.x,param2.location3D.y,param1.boundingData[2] + param2.boundingData[1]))
         {
            return true;
         }
         if(Location3D.isInDistanceStatic(_loc9_,_loc7_,_loc4_,_loc8_,param1.boundingData[2] + param2.boundingData[2]))
         {
            return true;
         }
         return false;
      }
      
      protected static function absoluteValue(param1:int) : int
      {
         if(param1 < 0)
         {
            return -param1;
         }
         return param1;
      }
   }
}

