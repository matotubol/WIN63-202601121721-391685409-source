package com.sulake.habbo.game.snowwar.utils
{
   import com.sulake.core.runtime.class_13;
   
   public class Direction360 implements class_13
   {
      
      private static const const_506:Number = 1;
      
      public static const N:int = 0;
      
      public static const NE:int = 45;
      
      public static const E:int = 90;
      
      public static const SE:int = 135;
      
      public static const S:int = 180;
      
      public static const SW:int = 225;
      
      public static const W:int = 270;
      
      public static const NW:int = 315;
      
      private static var var_2322:Array = [[0,4,8,13,17,22,26,31,35,40,44,48,53,57,61,66,70,74,79,83,87,91,95,100,104,108,112,116,120,124,127,131,135,139,143,146,150,154,157,161,164,167,171,174,177,181,184,187,190,193,196,198,201,204,207,209,212,214,217,219,221,223,226,228,230,232,233,235,237,238,240,242,243,244,246,247,248,249,250,251,252,252,253,254,254,255,255,255,255,255,256,255,255,255,255,255,254,254,253,252,252,251,250,249,248,247,246,244,243,242,240,238,237,235,233,232,230,228,226,223,221,219,217,214,212,209,207,204,201,198,196,193,190,187,184,181,177,174,171,167,164,161,157,154,150,146,143,139,135,131,127,124,120,116,112,108,104,100,95,91,87,83,79,74,70,66,61,57,53,48,44,40,35,31,26,22,17,13,8,4,0,-4,-8,-13,-17,-22,-26,-31,-35,-40,-44,-48,-53,-57,-61,-66,-70,-74,-79,-83,-87,-91,-95,-100,-104,-108,-112,-116,-120,-124,-128,-131,-135,-139,-143,-146,-150,-154,-157,-161,-164,-167,-171,-174,-177,-181,-184,-187,-190,-193,-196,-198,-201,-204,-207,-209,-212,-214,-217,-219,-221,-223,-226,-228,-230
      ,-232,-233,-235,-237,-238,-240,-242,-243,-244,-246,-247,-248,-249,-250,-251,-252,-252,-253,-254,-254,-255,-255,-255,-255,-255,-256,-255,-255,-255,-255,-255,-254,-254,-253,-252,-252,-251,-250,-249,-248,-247,-246,-244,-243,-242,-240,-238,-237,-235,-233,-232,-230,-228,-226,-223,-221,-219,-217,-214,-212,-209,-207,-204,-201,-198,-196,-193,-190,-187,-184,-181,-177,-174,-171,-167,-164,-161,-157,-154,-150,-146,-143,-139,-135,-131,-128,-124,-120,-116,-112,-108,-104,-100,-95,-91,-87,-83,-79,-74,-70,-66,-61,-57,-53,-48,-44,-40,-35,-31,-26,-22,-17,-13,-8,-4],[-256,-255,-255,-255,-255,-255,-254,-254,-253,-252,-252,-251,-250,-249,-248,-247,-246,-244,-243,-242,-240,-238,-237,-235,-233,-232,-230,-228,-226,-223,-221,-219,-217,-214,-212,-209,-207,-204,-201,-198,-196,-193,-190,-187,-184,-181,-177,-174,-171,-167,-164,-161,-157,-154,-150,-146,-143,-139,-135,-131,-128,-124,-120,-116,-112,-108,-104,-100,-95,-91,-87,-83,-79,-74,-70,-66,-61,-57,-53,-48,-44,-40,-35,-31,-26,-22,-17,-13,-8,-4,0,4,8,13,17,22,26,31,35
      ,40,44,48,53,57,61,66,70,74,79,83,87,91,95,100,104,108,112,116,120,124,127,131,135,139,143,146,150,154,157,161,164,167,171,174,177,181,184,187,190,193,196,198,201,204,207,209,212,214,217,219,221,223,226,228,230,232,233,235,237,238,240,242,243,244,246,247,248,249,250,251,252,252,253,254,254,255,255,255,255,255,256,255,255,255,255,255,254,254,253,252,252,251,250,249,248,247,246,244,243,242,240,238,237,235,233,232,230,228,226,223,221,219,217,214,212,209,207,204,201,198,196,193,190,187,184,181,177,174,171,167,164,161,157,154,150,146,143,139,135,131,128,124,120,116,112,108,104,100,95,91,87,83,79,74,70,66,61,57,53,48,44,40,35,31,26,22,17,13,8,4,0,-4,-8,-13,-17,-22,-26,-31,-35,-40,-44,-48,-53,-57,-61,-66,-70,-74,-79,-83,-87,-91,-95,-100,-104,-108,-112,-116,-120,-124,-128,-131,-135,-139,-143,-146,-150,-154,-157,-161,-164,-167,-171,-174,-177,-181,-184,-187,-190,-193,-196,-198,-201,-204,-207,-209,-212,-214,-217,-219,-221,-223,-226,-228,-230,-232,-233,-235,-237,-238,-240,-242,-243,-244,-246,-247,-248
      ,-249,-250,-251,-252,-252,-253,-254,-254,-255,-255,-255,-255,-255]];
      
      private static var componentToAngleArray:Array = [0,0,0,1,1,1,1,2,2,2,2,2,3,3,3,3,4,4,4,4,4,5,5,5,5,6,6,6,6,6,7,7,7,7,8,8,8,8,8,9,9,9,9,10,10,10,10,10,11,11,11,11,12,12,12,12,12,13,13,13,13,13,14,14,14,14,15,15,15,15,15,16,16,16,16,16,17,17,17,17,17,18,18,18,18,18,19,19,19,19,19,20,20,20,20,20,21,21,21,21,21,22,22,22,22,22,23,23,23,23,23,24,24,24,24,24,24,25,25,25,25,25,26,26,26,26,26,26,27,27,27,27,27,28,28,28,28,28,28,29,29,29,29,29,29,30,30,30,30,30,30,31,31,31,31,31,31,32,32,32,32,32,32,33,33,33,33,33,33,34,34,34,34,34,34,34,35,35,35,35,35,35,36,36,36,36,36,36,36,37,37,37,37,37,37,37,38,38,38,38,38,38,38,39,39,39,39,39,39,39,39,40,40,40,40,40,40,40,41,41,41,41,41,41,41,41,42,42,42,42,42,42,42,42,43,43,43,43,43,43,43,43,44,44,44,44,44,44,44,44,44,45,45,45,45,45];
      
      private var var_471:int = 0;
      
      private var var_1134:Boolean = false;
      
      public function Direction360(param1:int)
      {
         super();
         var_471 = param1;
      }
      
      public static function validateDirection360Value(param1:int) : int
      {
         if(param1 > 359)
         {
            param1 %= 360;
         }
         else if(param1 < 0)
         {
            param1 = 360 + param1 % 360;
         }
         return param1;
      }
      
      public static function direction360ValueToDirection8(param1:int) : Direction8
      {
         return Direction8.getDirection8(Direction8.validateDirection8Value(class_3895.javaDiv(validateDirection360Value(param1 - 22) / 45) + 1));
      }
      
      public static function direction8ToDirection360Value(param1:Direction8) : int
      {
         switch(param1.intValue())
         {
            case 0:
               return 0;
            case 1:
               return 45;
            case 2:
               return 90;
            case 3:
               return 135;
            case 4:
               return 180;
            case 5:
               return 225;
            case 6:
               return 270;
            case 7:
               return 315;
            default:
               return -1;
         }
      }
      
      public static function getBaseVectorXComponent(param1:int) : int
      {
         param1 = validateDirection360Value(param1);
         return var_2322[0][param1];
      }
      
      public static function getBaseVectorYComponent(param1:int) : int
      {
         param1 = validateDirection360Value(param1);
         return var_2322[1][param1];
      }
      
      public static function getAngleFromComponents(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         if(absoluteValue(param1) <= absoluteValue(param2))
         {
            if(param2 == 0)
            {
               param2 = 1;
            }
            param1 *= 256;
            _loc3_ = class_3895.javaDiv(param1 / param2);
            if(_loc3_ < 0)
            {
               _loc3_ = -_loc3_;
            }
            if(_loc3_ > 255)
            {
               _loc3_ = 255;
            }
            if(param2 < 0)
            {
               if(param1 > 0)
               {
                  return componentToAngleArray[_loc3_];
               }
               return 360 - componentToAngleArray[_loc3_];
            }
            if(param1 > 0)
            {
               return 180 - componentToAngleArray[_loc3_];
            }
            return 180 + componentToAngleArray[_loc3_];
         }
         if(param1 == 0)
         {
            param1 = 1;
         }
         param2 *= 256;
         _loc3_ = class_3895.javaDiv(param2 / param1);
         if(_loc3_ < 0)
         {
            _loc3_ = -_loc3_;
         }
         if(_loc3_ > 255)
         {
            _loc3_ = 255;
         }
         if(param2 < 0)
         {
            if(param1 > 0)
            {
               return 90 - componentToAngleArray[_loc3_];
            }
            return 270 + componentToAngleArray[_loc3_];
         }
         if(param1 > 0)
         {
            return 90 + componentToAngleArray[_loc3_];
         }
         return 270 - componentToAngleArray[_loc3_];
      }
      
      public static function absoluteValue(param1:int) : int
      {
         if(param1 < 0)
         {
            return -param1;
         }
         return param1;
      }
      
      private static function getAngleAtan(param1:int, param2:int) : int
      {
         return int(Math.atan2(param1,param2 * 57.295 + 0.5));
      }
      
      public function dispose() : void
      {
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function intValue() : int
      {
         return var_471;
      }
      
      public function setIntValue(param1:int) : void
      {
         var_471 = validateDirection360Value(param1);
      }
      
      public function rotateDirection(param1:int) : void
      {
         var_471 += param1;
         var_471 = validateDirection360Value(var_471);
      }
      
      public function toString() : String
      {
         return "[" + var_471 + "]";
      }
      
      public function direction8Value() : Direction8
      {
         return direction360ValueToDirection8(var_471);
      }
      
      public function getBaseVectorXComponent() : int
      {
         return var_2322[0][var_471];
      }
      
      public function getBaseVectorYComponent() : int
      {
         return var_2322[1][var_471];
      }
   }
}

