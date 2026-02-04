package com.sulake.habbo.room.utils
{
   [SecureSWF(rename="true")]
   public class class_1934
   {
      
      private var var_936:Vector.<Number>;
      
      private var var_2450:Vector.<Boolean>;
      
      private var var_1993:Vector.<Boolean>;
      
      private var _width:int = 0;
      
      private var var_385:int = 0;
      
      public function class_1934(param1:int, param2:int)
      {
         super();
         _width = param1;
         var_385 = param2;
         var_936 = new Vector.<Number>(param1 * param2);
         var_2450 = new Vector.<Boolean>(param1 * param2);
         var_1993 = new Vector.<Boolean>(param1 * param2);
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get height() : int
      {
         return var_385;
      }
      
      public function dispose() : void
      {
         var_936 = null;
         var_2450 = null;
         var_1993 = null;
         _width = 0;
         var_385 = 0;
      }
      
      private function validPosition(param1:int, param2:int) : Boolean
      {
         return param1 >= 0 && param1 < _width && param2 >= 0 && param2 < var_385;
      }
      
      public function getTileHeight(param1:int, param2:int) : Number
      {
         return validPosition(param1,param2) ? var_936[param2 * _width + param1] : 0;
      }
      
      public function setTileHeight(param1:int, param2:int, param3:Number) : void
      {
         if(validPosition(param1,param2))
         {
            var_936[param2 * _width + param1] = param3;
         }
      }
      
      public function setStackingBlocked(param1:int, param2:int, param3:Boolean) : void
      {
         if(validPosition(param1,param2))
         {
            var_2450[param2 * _width + param1] = param3;
         }
      }
      
      public function setIsRoomTile(param1:int, param2:int, param3:Boolean) : void
      {
         if(validPosition(param1,param2))
         {
            var_1993[param2 * _width + param1] = param3;
         }
      }
      
      public function validateLocation(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:Boolean, param10:Number = -1) : Boolean
      {
         var _loc13_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         if(!validPosition(param1,param2) || !validPosition(param1 + param3 - 1,param2 + param4 - 1))
         {
            return false;
         }
         if(param5 < 0 || param5 >= _width)
         {
            param5 = 0;
         }
         if(param6 < 0 || param6 >= var_385)
         {
            param6 = 0;
         }
         param7 = Math.min(param7,_width - param5);
         param8 = Math.min(param8,var_385 - param6);
         if(param10 == -1)
         {
            param10 = getTileHeight(param1,param2);
         }
         _loc13_ = param2;
         while(_loc13_ < param2 + param4)
         {
            _loc11_ = param1;
            while(_loc11_ < param1 + param3)
            {
               if(_loc11_ < param5 || _loc11_ >= param5 + param7 || _loc13_ < param6 || _loc13_ >= param6 + param8)
               {
                  _loc12_ = _loc13_ * _width + _loc11_;
                  if(param9)
                  {
                     if(!var_1993[_loc12_])
                     {
                        return false;
                     }
                  }
                  else if(var_2450[_loc12_] || !var_1993[_loc12_] || Math.abs(var_936[_loc12_] - param10) > 0.01)
                  {
                     return false;
                  }
               }
               _loc11_++;
            }
            _loc13_++;
         }
         return true;
      }
   }
}

