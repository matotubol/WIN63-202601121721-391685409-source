package com.sulake.habbo.avatar.cache
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.actions.class_2501;
   
   public class AvatarImageBodyPartCache
   {
      
      private var _cache:class_55;
      
      private var var_886:class_2501;
      
      private var var_2882:int;
      
      private var _disposed:Boolean;
      
      public function AvatarImageBodyPartCache()
      {
         super();
         _cache = new class_55();
      }
      
      public function setAction(param1:class_2501, param2:int) : void
      {
         if(var_886 == null)
         {
            var_886 = param1;
         }
         var _loc3_:AvatarImageActionCache = getActionCache(var_886);
         if(_loc3_ != null)
         {
            _loc3_.setLastAccessTime(param2);
         }
         var_886 = param1;
      }
      
      public function dispose() : void
      {
         var _loc1_:Array = null;
         var _loc3_:AvatarImageActionCache = null;
         if(_disposed)
         {
            return;
         }
         if(_cache)
         {
            _loc1_ = _cache.getKeys();
            for each(var _loc2_ in _loc1_)
            {
               _loc3_ = _cache.getValue(_loc2_) as AvatarImageActionCache;
               if(_loc3_)
               {
                  _loc3_.dispose();
               }
            }
            _cache.dispose();
            _cache = null;
         }
         var_886 = null;
         var_2882 = 0;
         _disposed = true;
      }
      
      public function disposeActions(param1:int, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc5_:AvatarImageActionCache = null;
         var _loc6_:* = null;
         if(_cache == null || _disposed)
         {
            return;
         }
         var _loc4_:Array = _cache.getKeys();
         for each(_loc6_ in _loc4_)
         {
            _loc5_ = _cache.getValue(_loc6_) as AvatarImageActionCache;
            if(_loc5_ != null)
            {
               _loc3_ = _loc5_.getLastAccessTime();
               if(param2 - _loc3_ >= param1)
               {
                  _loc5_.dispose();
                  _cache.remove(_loc6_);
               }
            }
         }
      }
      
      public function getAction() : class_2501
      {
         return var_886;
      }
      
      public function setDirection(param1:int) : void
      {
         var_2882 = param1;
      }
      
      public function getDirection() : int
      {
         return var_2882;
      }
      
      public function getActionCache(param1:class_2501 = null) : AvatarImageActionCache
      {
         if(!var_886)
         {
            return null;
         }
         if(param1 == null)
         {
            param1 = var_886;
         }
         if(param1.overridingAction != null)
         {
            return _cache.getValue(param1.overridingAction) as AvatarImageActionCache;
         }
         return _cache.getValue(param1.id) as AvatarImageActionCache;
      }
      
      public function updateActionCache(param1:class_2501, param2:AvatarImageActionCache) : void
      {
         if(param1.overridingAction != null)
         {
            _cache.add(param1.overridingAction,param2);
         }
         else
         {
            _cache.add(param1.id,param2);
         }
      }
      
      private function debugInfo(param1:String) : void
      {
      }
   }
}

