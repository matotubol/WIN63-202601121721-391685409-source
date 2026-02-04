package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.class_55;
   import flash.utils.getTimer;
   
   public class AvatarImageActionCache
   {
      
      private var _cache:class_55;
      
      private var _lastAccessTime:int;
      
      public function AvatarImageActionCache()
      {
         super();
         _cache = new class_55();
         setLastAccessTime(getTimer());
      }
      
      public function dispose() : void
      {
         debugInfo("[dispose]");
         if(_cache != null)
         {
            for each(var _loc1_ in _cache)
            {
               _loc1_.dispose();
            }
            _cache.dispose();
            _cache = null;
         }
         _lastAccessTime = 0;
      }
      
      public function getDirectionCache(param1:int) : AvatarImageDirectionCache
      {
         var _loc2_:String = param1.toString();
         return _cache.getValue(_loc2_) as AvatarImageDirectionCache;
      }
      
      public function updateDirectionCache(param1:int, param2:AvatarImageDirectionCache) : void
      {
         var _loc3_:String = param1.toString();
         _cache.add(_loc3_,param2);
      }
      
      public function setLastAccessTime(param1:int) : void
      {
         _lastAccessTime = param1;
      }
      
      public function getLastAccessTime() : int
      {
         return _lastAccessTime;
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}

