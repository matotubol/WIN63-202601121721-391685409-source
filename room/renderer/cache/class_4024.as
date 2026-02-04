package com.sulake.room.renderer.cache
{
   import com.sulake.core.utils.class_55;
   import com.sulake.room.renderer.utils.class_4036;
   import flash.display.BitmapData;
   
   [SecureSWF(rename="true")]
   public class class_4024
   {
      
      private var var_618:class_55;
      
      private var var_719:int = 0;
      
      private var var_1338:int = 0;
      
      private var var_3623:int = 0;
      
      private var var_2394:int = 0;
      
      public function class_4024(param1:int, param2:int, param3:int = 1)
      {
         super();
         var_618 = new class_55();
         var_1338 = param1 * 1024 * 1024;
         var_3623 = param2 * 1024 * 1024;
         var_2394 = param3 * 1024 * 1024;
         if(var_2394 < 0)
         {
            var_2394 = 0;
         }
      }
      
      public function get memUsage() : int
      {
         return var_719;
      }
      
      public function get memLimit() : int
      {
         return var_1338;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         if(var_618 != null)
         {
            _loc1_ = var_618.getKeys();
            for each(var _loc2_ in _loc1_)
            {
               if(!removeItem(_loc2_))
               {
                  class_21.log("Failed to remove item " + _loc2_ + " from room canvas bitmap cache!");
               }
            }
            var_618.dispose();
            var_618 = null;
         }
      }
      
      public function compress() : void
      {
         var _loc1_:Array = null;
         var _loc2_:class_4099 = null;
         var _loc3_:int = 0;
         if(memUsage > memLimit)
         {
            _loc1_ = var_618.getValues();
            _loc1_.sortOn("useCount",16);
            _loc1_.reverse();
            _loc3_ = _loc1_.length - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = _loc1_[_loc3_] as class_4099;
               if(_loc2_.useCount > 1)
               {
                  break;
               }
               removeItem(_loc2_.name);
               _loc3_--;
            }
            increaseMemoryLimit();
         }
      }
      
      private function increaseMemoryLimit() : void
      {
         var_1338 += var_2394;
         if(var_1338 > var_3623)
         {
            var_1338 = var_3623;
         }
      }
      
      private function removeItem(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:class_4099 = var_618.getValue(param1) as class_4099;
         if(_loc2_ != null)
         {
            if(_loc2_.useCount <= 1)
            {
               var_618.remove(_loc2_.name);
               var_719 -= _loc2_.memUsage;
               _loc2_.dispose();
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function getBitmapData(param1:String) : class_4036
      {
         var _loc2_:class_4099 = var_618.getValue(param1) as class_4099;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc3_:class_4036 = _loc2_.bitmapData;
         if(_loc3_ != null && _loc3_.disposed)
         {
            var_618.remove(_loc2_.name);
            var_719 -= _loc2_.memUsage;
            _loc2_.dispose();
            return null;
         }
         return _loc3_;
      }
      
      public function addBitmapData(param1:String, param2:class_4036) : void
      {
         if(param2 == null || param2.width <= 0 || param2.height <= 0)
         {
            return;
         }
         if(param2.disposed)
         {
            return;
         }
         var _loc3_:class_4099 = var_618.getValue(param1) as class_4099;
         if(_loc3_ != null)
         {
            if(_loc3_.bitmapData == param2)
            {
               return;
            }
            var _loc4_:BitmapData = _loc3_.bitmapData;
            if(_loc4_ != null)
            {
               var_719 -= null.width * null.height * 4;
            }
            _loc3_.bitmapData = param2;
         }
         else
         {
            _loc3_ = new class_4099(param2,param1);
            var_618.add(param1,_loc3_);
         }
         var_719 += param2.width * param2.height * 4;
      }
   }
}

