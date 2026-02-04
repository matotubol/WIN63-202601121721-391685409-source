package com.sulake.core.window.utils
{
   public class ChildEntityArray extends class_4076 implements IChildEntityArray
   {
      
      public function ChildEntityArray()
      {
         super();
      }
      
      public function removeChild(param1:class_2142) : class_2142
      {
         var _loc2_:int = int(var_120.indexOf(param1));
         if(_loc2_ < 0)
         {
            return null;
         }
         var_120.splice(_loc2_,1);
         return param1;
      }
      
      public function addChild(param1:class_2142) : class_2142
      {
         var_120.push(param1);
         return param1;
      }
      
      public function addChildAt(param1:class_2142, param2:int) : class_2142
      {
         var_120.splice(param2,0,param1);
         return param1;
      }
      
      public function removeChildAt(param1:int) : class_2142
      {
         var _loc2_:class_2142 = var_120[param1];
         if(_loc2_ != null)
         {
            var_120.splice(param1,1);
            return _loc2_;
         }
         return null;
      }
      
      public function setChildIndex(param1:class_2142, param2:int) : void
      {
         var _loc3_:int = int(var_120.indexOf(param1));
         if(_loc3_ > -1 && param2 != _loc3_)
         {
            var_120.splice(_loc3_,1);
            var_120.splice(param2,0,param1);
         }
      }
      
      public function swapChildren(param1:class_2142, param2:class_2142) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:class_2142 = null;
         var _loc4_:int = 0;
         if(param1 != null && param2 != null && param1 != param2)
         {
            _loc3_ = int(var_120.indexOf(param1));
            if(_loc3_ < 0)
            {
               return;
            }
            _loc6_ = int(var_120.indexOf(param2));
            if(_loc6_ < 0)
            {
               return;
            }
            if(_loc6_ < _loc3_)
            {
               _loc5_ = param1;
               param1 = param2;
               param2 = _loc5_;
               _loc4_ = _loc3_;
               _loc3_ = _loc6_;
               _loc6_ = _loc4_;
            }
            var_120.splice(_loc6_,1);
            var_120.splice(_loc3_,1);
            var_120.splice(_loc3_,0,param2);
            var_120.splice(_loc6_,0,param1);
         }
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
         swapChildren(var_120[param1],var_120[param2]);
      }
   }
}

