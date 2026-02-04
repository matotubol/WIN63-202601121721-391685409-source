package com.sulake.habbo.navigator
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Util
   {
      
      private static var CUT_TO_WIDTH:CutToWidth = new CutToWidth();
      
      private static var CUT_TO_HEIGHT:class_4017 = new class_4017();
      
      public function Util()
      {
         super();
      }
      
      public static function remove(param1:Array, param2:Object) : int
      {
         var _loc3_:int = int(param1.indexOf(param2));
         if(_loc3_ >= 0)
         {
            param1.splice(_loc3_,1);
         }
         return _loc3_;
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
      
      public static function hasVisibleChildren(param1:class_1812) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:class_1741 = null;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_.visible)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
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
      
      public static function moveChildrenToRow(param1:class_1812, param2:Array, param3:int, param4:int, param5:int) : void
      {
         var _loc7_:class_1741 = null;
         for each(var _loc6_ in param2)
         {
            _loc7_ = param1.getChildByName(_loc6_);
            if(_loc7_ != null && _loc7_.visible)
            {
               _loc7_.x = param3;
               _loc7_.y = param4;
               param3 += _loc7_.width + param5;
            }
         }
      }
      
      public static function moveChildrenToColumn(param1:class_1812, param2:Array, param3:int, param4:int) : void
      {
         var _loc6_:class_1741 = null;
         for each(var _loc5_ in param2)
         {
            _loc6_ = param1.getChildByName(_loc5_);
            if(_loc6_ != null && _loc6_.visible && _loc6_.height > 0)
            {
               _loc6_.y = param3;
               param3 += _loc6_.height + param4;
            }
         }
      }
      
      public static function layoutChildrenInArea(param1:class_1812, param2:int, param3:int, param4:int = 0, param5:int = 0) : void
      {
         var _loc8_:int = 0;
         var _loc9_:class_1741 = null;
         var _loc6_:int = param5;
         var _loc7_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < param1.numChildren)
         {
            _loc9_ = param1.getChildAt(_loc8_);
            if(_loc9_.visible)
            {
               if(_loc6_ > 0 && _loc6_ + _loc9_.width > param2)
               {
                  _loc6_ = 0;
                  _loc7_ += param3;
               }
               _loc9_.x = _loc6_;
               _loc9_.y = _loc7_;
               _loc6_ += _loc9_.width + param4;
            }
            _loc8_++;
         }
      }
      
      public static function setProc(param1:class_1812, param2:String, param3:Function) : void
      {
         var _loc4_:class_1741 = param1.findChildByName(param2);
         _loc4_.setParamFlag(1,true);
         _loc4_.procedure = param3;
      }
      
      public static function setProcDirectly(param1:class_1741, param2:Function) : void
      {
         param1.setParamFlag(1,true);
         param1.procedure = param2;
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null || param1.length < 1)
         {
            return param1;
         }
         while(param1.charAt(0) == " ")
         {
            param1 = param1.substring(1);
         }
         while(param1.charAt(param1.length - 1) == " ")
         {
            param1 = param1.substring(0,param1.length - 1);
         }
         return param1;
      }
      
      public static function cutTextToWidth(param1:ITextWindow, param2:String, param3:int) : void
      {
         param1.text = param2;
         if(param1.textWidth <= param3)
         {
            return;
         }
         CUT_TO_WIDTH.beforeSearch(param2,param1,param3);
         binarySearch(CUT_TO_WIDTH,param2.length - 1);
      }
      
      public static function binarySearch(param1:class_3858, param2:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         while(_loc3_ < param2)
         {
            _loc5_ = _loc3_ + Math.floor((param2 - _loc3_) / 2);
            _loc4_ = param1.test(_loc5_);
            if(_loc4_)
            {
               param2 = _loc5_ - 1;
            }
            else
            {
               _loc6_ = Math.max(_loc6_,_loc5_);
               _loc3_ = _loc5_ + 1;
            }
         }
         param1.test(_loc6_);
      }
      
      public static function containsMouse(param1:class_1741) : Boolean
      {
         var _loc2_:Point = new Point();
         param1.getRelativeMousePosition(_loc2_);
         return _loc2_.x >= 0 && _loc2_.y >= 0 && _loc2_.x < param1.width && _loc2_.y < param1.height;
      }
   }
}

