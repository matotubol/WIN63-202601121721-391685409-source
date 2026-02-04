package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.alias.AssetAliasCollection;
   import flash.display.BitmapData;
   
   public class BlockedAvatarImage extends AvatarImage
   {
      
      internal static var _fullImageCache:class_55 = new class_55();
      
      public function BlockedAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String, param5:EffectAssetDownloadManager)
      {
         super(param1,param2,param3,param4,param5,null);
      }
      
      override public function dispose() : void
      {
         if(!var_1134)
         {
            if(_cache)
            {
               _cache.dispose();
               _cache = null;
            }
            var_74 = null;
            _assets = null;
            var_183 = null;
            var_975 = null;
            var_597 = null;
            var_289 = null;
            if(!var_1100 && var_48)
            {
               var_48.dispose();
            }
            var_48 = null;
            var_721 = null;
            var_1134 = true;
         }
      }
      
      override protected function getFullImage(param1:String) : BitmapData
      {
         return _fullImageCache[param1];
      }
      
      override protected function cacheFullImage(param1:String, param2:BitmapData) : void
      {
         if(_fullImageCache.getValue(param1))
         {
            (_fullImageCache.getValue(param1) as BitmapData).dispose();
            _fullImageCache.remove(param1);
         }
         _fullImageCache[param1] = param2;
      }
      
      override public function appendAction(param1:String, ... rest) : Boolean
      {
         var _loc3_:String = null;
         if(rest != null && rest.length > 0)
         {
            _loc3_ = rest[0];
         }
         switch(param1)
         {
            case "posture":
               switch(_loc3_)
               {
                  case "lay":
                  case "mv":
                  case "std":
                  case "swim":
                  case "float":
                  case "sit":
                     super.appendAction.apply(null,[param1].concat(rest));
               }
               break;
            case "fx":
            case "dance":
            case "wave":
            case "sign":
            case "cri":
            case "usei":
            case "blow":
               super.addActionData.apply(null,[param1].concat(rest));
         }
         return true;
      }
      
      override public function isBlocked() : Boolean
      {
         return true;
      }
   }
}

