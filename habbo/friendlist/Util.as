package com.sulake.habbo.friendlist
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import flash.geom.Rectangle;
   
   public class Util
   {
      
      public function Util()
      {
         super();
      }
      
      public static function remove(param1:Array, param2:Object) : void
      {
         var _loc3_:int = int(param1.indexOf(param2));
         if(_loc3_ >= 0)
         {
            param1.splice(_loc3_,1);
         }
      }
      
      public static function getLowestPoint(param1:class_1812) : int
      {
         var _loc2_:int = 0;
         var _loc4_:class_1741 = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible)
            {
               var _loc3_:int = Math.max(0,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return 0;
      }
      
      public static function getRightmostPoint(param1:class_1812) : int
      {
         var _loc2_:int = 0;
         var _loc4_:class_1741 = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible)
            {
               var _loc3_:int = Math.max(0,_loc4_.x + _loc4_.width);
            }
            _loc2_++;
         }
         return 0;
      }
      
      public static function arrayToString(param1:Array, param2:String = ", ", param3:String = "") : String
      {
         var _loc4_:String = "";
         for each(var _loc5_ in param1)
         {
            if(_loc4_ != "")
            {
               _loc4_ += param2;
            }
            _loc4_ += param3 + _loc5_ + param3;
         }
         return _loc4_;
      }
      
      public static function print(param1:String, param2:class_1741) : void
      {
         var _loc3_:int = 0;
         class_21.log(param1 + param2 + " (" + param2.width + ", " + param2.height + "), " + param2.getParamFlag(16));
         var _loc4_:class_1812 = param2 as class_1812;
         if(_loc4_ != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc4_.numChildren)
            {
               print(param1 + "-",_loc4_.getChildAt(_loc3_));
               _loc3_++;
            }
         }
      }
      
      public static function hideChildren(param1:class_1812) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            param1.getChildAt(_loc2_).visible = false;
            _loc2_++;
         }
      }
      
      public static function getLocationRelativeTo(param1:class_1741, param2:int, param3:int) : Rectangle
      {
         if(param1 == null)
         {
            return new Rectangle(300,200,param2,param3);
         }
         var _loc4_:int = param1.width - param2;
         var _loc5_:int = param1.height - param3;
         return new Rectangle(param1.x + 0.5 * _loc4_,param1.y + 0.5 * _loc5_,param2,param3);
      }
      
      public static function layoutChildrenInArea(param1:class_1812, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc7_:class_1741 = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < param1.numChildren)
         {
            _loc7_ = param1.getChildAt(_loc6_);
            if(_loc7_.visible)
            {
               if(_loc4_ > 0 && _loc4_ + _loc7_.width > param2)
               {
                  _loc4_ = 0;
                  _loc5_ += param3;
               }
               _loc7_.x = _loc4_;
               _loc7_.y = _loc5_;
               _loc4_ += _loc7_.width;
            }
            _loc6_++;
         }
      }
   }
}

