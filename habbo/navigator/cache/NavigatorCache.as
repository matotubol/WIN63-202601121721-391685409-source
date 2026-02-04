package com.sulake.habbo.navigator.cache
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import package_25.class_1995;
   
   public class NavigatorCache
   {
      
      private static const EXPIRATION_TIME:Number = 4000;
      
      private var _entriesByKey:Dictionary;
      
      public function NavigatorCache()
      {
         super();
         _entriesByKey = new Dictionary();
      }
      
      public function put(param1:String, param2:class_1995) : void
      {
         removeExpiredEntries();
         var _loc3_:Number = getTimer();
         _entriesByKey[param1] = new NavigatorCacheEntry(param1,param2,_loc3_,expiresAt(_loc3_));
      }
      
      public function getEntry(param1:String) : class_1995
      {
         var _loc2_:NavigatorCacheEntry = _entriesByKey[param1];
         if(_loc2_ != null)
         {
            if(_loc2_.hasExpired(getTimer()))
            {
               delete _entriesByKey[param1];
               return null;
            }
            return _loc2_.payload;
         }
         return null;
      }
      
      public function removeEntry(param1:String) : void
      {
         delete _entriesByKey[param1];
      }
      
      private function removeExpiredEntries() : void
      {
         var _loc3_:String = null;
         var _loc2_:NavigatorCacheEntry = null;
         for(var _loc1_ in _entriesByKey)
         {
            _loc3_ = String(_loc1_);
            _loc2_ = _entriesByKey[_loc3_];
            if(_loc2_ == null || _loc2_.hasExpired(getTimer()))
            {
               delete _entriesByKey[_loc3_];
            }
         }
      }
      
      private function expiresAt(param1:Number) : Number
      {
         return param1 + 4000;
      }
   }
}

