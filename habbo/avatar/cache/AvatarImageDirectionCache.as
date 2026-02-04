package com.sulake.habbo.avatar.cache
{
   import com.sulake.habbo.avatar.AvatarImageBodyPartContainer;
   import com.sulake.habbo.avatar.AvatarImagePartContainer;
   import flash.utils.Dictionary;
   
   public class AvatarImageDirectionCache
   {
      
      private static const KEY_SEPARATOR:String = "/";
      
      private static const NO_FRAMES_KEY:String = "-";
      
      private var var_1120:Vector.<AvatarImagePartContainer>;
      
      private var var_602:Dictionary;
      
      private var _keyCache:Dictionary;
      
      public function AvatarImageDirectionCache(param1:Vector.<AvatarImagePartContainer>)
      {
         super();
         var_602 = new Dictionary();
         var_1120 = param1;
         _keyCache = new Dictionary();
      }
      
      public function dispose() : void
      {
         for each(var _loc1_ in var_602)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         var_602 = null;
         var_1120 = null;
         _keyCache = null;
      }
      
      public function getPartList() : Vector.<AvatarImagePartContainer>
      {
         return var_1120;
      }
      
      public function getImageContainer(param1:int) : AvatarImageBodyPartContainer
      {
         var _loc2_:String = getCacheKey(param1);
         return var_602[_loc2_];
      }
      
      public function updateImageContainer(param1:AvatarImageBodyPartContainer, param2:int) : void
      {
         var _loc3_:String = getCacheKey(param2);
         if(var_602[_loc3_])
         {
            var _loc4_:AvatarImageBodyPartContainer = var_602[_loc3_] as AvatarImageBodyPartContainer;
            if(_loc4_)
            {
               null.dispose();
            }
         }
         var_602[_loc3_] = param1;
      }
      
      private function getCacheKey(param1:int) : String
      {
         var _loc4_:int = 0;
         if(var_1120 == null || var_1120.length == 0)
         {
            return "-";
         }
         var _loc2_:String = _keyCache[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         var _loc5_:AvatarImagePartContainer = var_1120[0] as AvatarImagePartContainer;
         _loc2_ = _loc5_.getCacheableKey(param1);
         var _loc3_:int = int(var_1120.length);
         _loc4_ = 1;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = var_1120[_loc4_] as AvatarImagePartContainer;
            _loc2_ += "/" + _loc5_.getCacheableKey(param1);
            _loc4_++;
         }
         _keyCache[param1] = _loc2_;
         return _loc2_;
      }
   }
}

