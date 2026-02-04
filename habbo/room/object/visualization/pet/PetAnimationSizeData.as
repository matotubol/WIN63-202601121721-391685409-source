package com.sulake.habbo.room.object.visualization.pet
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.room.object.visualization.data.*;
   import com.sulake.room.utils.class_2119;
   
   public class PetAnimationSizeData extends AnimationSizeData
   {
      
      public static const const_388:int = -1;
      
      private var var_1399:class_55 = new class_55();
      
      private var var_1177:class_55 = new class_55();
      
      private var _defaultPosture:String;
      
      public function PetAnimationSizeData(param1:int, param2:int)
      {
         super(param1,param2);
      }
      
      public function definePostures(param1:XML) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(class_2119.checkRequiredAttributes(param1,["defaultPosture"]))
         {
            _defaultPosture = param1.@defaultPosture;
         }
         else
         {
            _defaultPosture = null;
         }
         var _loc3_:Array = ["id","animationId"];
         var _loc4_:XMLList = param1.posture;
         var _loc5_:int = 0;
         while(0 < _loc4_.length())
         {
            var _loc2_:XML = _loc4_[0];
            if(!class_2119.checkRequiredAttributes(null,_loc3_))
            {
               return false;
            }
            var _loc6_:String = String(null.@id);
            var _loc7_:int = int(null.@animationId);
            var_1399.add(null,0);
            if(_defaultPosture == null)
            {
               _defaultPosture = null;
            }
            _loc5_++;
         }
         if(var_1399.getValue(_defaultPosture) == null)
         {
            return false;
         }
         return true;
      }
      
      public function defineGestures(param1:XML) : Boolean
      {
         var _loc2_:int = 0;
         var _loc7_:XML = null;
         var _loc3_:String = null;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         var _loc4_:Array = ["id","animationId"];
         var _loc6_:XMLList = param1.gesture;
         _loc2_ = 0;
         while(_loc2_ < _loc6_.length())
         {
            _loc7_ = _loc6_[_loc2_];
            if(!class_2119.checkRequiredAttributes(_loc7_,_loc4_))
            {
               return false;
            }
            _loc3_ = String(_loc7_.@id);
            _loc5_ = int(_loc7_.@animationId);
            var_1177.add(_loc3_,_loc5_);
            _loc2_++;
         }
         return true;
      }
      
      public function getAnimationForPosture(param1:String) : int
      {
         if(var_1399.getValue(param1) == null)
         {
            param1 = _defaultPosture;
         }
         return var_1399.getValue(param1);
      }
      
      public function getGestureDisabled(param1:String) : Boolean
      {
         if(param1 == "ded")
         {
            return true;
         }
         return false;
      }
      
      public function getAnimationForGesture(param1:String) : int
      {
         if(var_1177.getValue(param1) == null)
         {
            return -1;
         }
         return var_1177.getValue(param1);
      }
      
      public function getPostureForAnimation(param1:int, param2:Boolean) : String
      {
         if(param1 >= 0 && param1 < var_1399.length)
         {
            return var_1399.getKey(param1);
         }
         return param2 ? _defaultPosture : null;
      }
      
      public function getGestureForAnimation(param1:int) : String
      {
         if(param1 >= 0 && param1 < var_1177.length)
         {
            return var_1177.getKey(param1);
         }
         return null;
      }
      
      public function getGestureForAnimationId(param1:int) : String
      {
         for each(var _loc2_ in var_1177.getKeys())
         {
            if(var_1177.getValue(_loc2_) == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getPostureCount() : int
      {
         return var_1399.length;
      }
      
      public function getGestureCount() : int
      {
         return var_1177.length;
      }
   }
}

