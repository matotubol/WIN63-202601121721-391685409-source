package com.sulake.habbo.avatar.alias
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.avatar.class_49;
   import flash.utils.Dictionary;
   
   public class AssetAliasCollection
   {
      
      private var _assets:AssetLibraryCollection;
      
      private var _aliases:Dictionary;
      
      private var _avatarRenderManager:class_49;
      
      private var var_1796:Object;
      
      public function AssetAliasCollection(param1:class_49, param2:AssetLibraryCollection)
      {
         super();
         _avatarRenderManager = param1;
         _aliases = new Dictionary();
         _assets = param2;
         var_1796 = {};
      }
      
      public function dispose() : void
      {
         _assets = null;
         _aliases = null;
      }
      
      public function reset() : void
      {
         var_1796 = {};
         init();
      }
      
      public function onAvatarAssetsLibraryReady(param1:String) : void
      {
         var _loc3_:String = null;
         var _loc2_:AssetAlias = null;
         var _loc4_:class_40 = _assets.getAssetLibraryByPartialUrl("/" + param1 + ".swf");
         if(_loc4_)
         {
            for each(var _loc5_ in _loc4_.manifest..alias)
            {
               _loc3_ = String(_loc5_.@name);
               _loc2_ = new AssetAlias(_loc5_);
               _aliases[_loc3_] = _loc2_;
            }
         }
      }
      
      public function init() : void
      {
         var _loc4_:String = null;
         var _loc2_:AssetAlias = null;
         var _loc3_:Array = _assets.getManifests();
         for each(var _loc1_ in _loc3_)
         {
            for each(var _loc5_ in _loc1_..alias)
            {
               _loc4_ = String(_loc5_.@name);
               _loc2_ = new AssetAlias(_loc5_);
               _aliases[_loc4_] = _loc2_;
            }
         }
      }
      
      public function addAlias(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc6_:XML = <alias name="" link="" fliph="0" flipv="0" />;
         _loc6_.@name = param1;
         _loc6_.@link = param2;
         var _loc5_:AssetAlias = new AssetAlias(_loc6_);
         _aliases[param1] = _loc5_;
      }
      
      public function hasAlias(param1:String) : Boolean
      {
         var _loc2_:AssetAlias = _aliases[param1] as AssetAlias;
         return _loc2_ != null;
      }
      
      public function getAssetName(param1:String) : String
      {
         var _loc4_:AssetAlias = null;
         var _loc2_:String = param1;
         var _loc3_:int = 5;
         while(hasAlias(_loc2_) && _loc3_ >= 0)
         {
            _loc4_ = _aliases[_loc2_] as AssetAlias;
            _loc2_ = _loc4_.link;
            _loc3_--;
         }
         return _loc2_;
      }
      
      public function getAssetByName(param1:String) : IAsset
      {
         param1 = getAssetName(param1);
         if(var_1796[param1])
         {
            return null;
         }
         var _loc2_:IAsset = _assets.getAssetByName(param1);
         if(_loc2_ == null && !var_1796[param1])
         {
            var_1796[param1] = true;
         }
         return _loc2_;
      }
   }
}

