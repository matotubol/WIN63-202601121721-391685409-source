package com.sulake.habbo.inventory
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.ISelectorWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.utils.class_1897;
   
   public class Util
   {
      
      public function Util()
      {
         super();
      }
      
      public static function disableButton(param1:class_1741, param2:Boolean) : void
      {
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      public static function disableSection(param1:class_1741, param2:Boolean = true) : void
      {
         var _loc3_:class_1812 = null;
         var _loc4_:int = 0;
         if(param1.tags.indexOf("DO_NOT_DISABLE") != -1)
         {
            return;
         }
         var _loc5_:Number = param2 ? 0.5 : 1;
         if(!(param1 is class_1775))
         {
            if(param1 is class_1812 || param1 is IItemListWindow || param1 is ISelectorWindow)
            {
               if(param1 is class_1897)
               {
                  for each(var _loc6_ in (param1 as class_1897).children)
                  {
                     disableSection(_loc6_,param2);
                  }
               }
               else if(param1 is class_1812)
               {
                  _loc3_ = param1 as class_1812;
                  _loc4_ = 0;
                  while(_loc4_ < _loc3_.numChildren)
                  {
                     disableSection(_loc3_.getChildAt(_loc4_),param2);
                     _loc4_++;
                  }
               }
            }
            else
            {
               param1.blend = _loc5_;
            }
         }
         if(param2)
         {
            param1.disable();
         }
         else
         {
            param1.enable();
         }
      }
      
      public static function moveAllChildrenToColumn(param1:class_1812, param2:int, param3:Boolean = false, param4:int = 0) : void
      {
         var _loc5_:int = 0;
         var _loc6_:class_1741 = null;
         _loc5_ = 0;
         while(_loc5_ < param1.numChildren)
         {
            _loc6_ = param1.getChildAt(_loc5_);
            if(_loc6_ != null && _loc6_.visible && _loc6_.height > 0)
            {
               if(param4 < _loc6_.y && param3)
               {
                  param4 = _loc6_.y;
               }
               else
               {
                  _loc6_.y = param4;
               }
               param4 += _loc6_.height + param2;
            }
            _loc5_++;
         }
      }
      
      public static function getLowestPoint(param1:class_1812) : int
      {
         var _loc2_:int = 0;
         var _loc4_:class_1741 = null;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc4_ = param1.getChildAt(_loc2_);
            if(_loc4_.visible && _loc4_.height > 0)
            {
               _loc3_ = Math.max(_loc3_,_loc4_.y + _loc4_.height);
            }
            _loc2_++;
         }
         return _loc3_;
      }
   }
}

