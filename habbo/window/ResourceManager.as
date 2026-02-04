package com.sulake.habbo.window
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.class_3067;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class ResourceManager implements IResourceManager
   {
      
      private var _disposed:Boolean;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var _assetReceivers:Dictionary = new Dictionary();
      
      public function ResourceManager(param1:HabboWindowManagerComponent)
      {
         super();
         _windowManager = param1;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function retrieveAsset(param1:String, param2:class_3067) : void
      {
         var _loc3_:AssetLoaderStruct = null;
         if(param1 == null || param1.length == 0)
         {
            return;
         }
         var _loc7_:String = resolveAssetName(param1);
         if(_loc7_ == null)
         {
            return;
         }
         var _loc8_:IAsset = _windowManager.assets.getAssetByName(_loc7_);
         if(_loc8_ == null)
         {
            if(_loc7_.substr(0,7) == "http://" || _loc7_.substr(0,8) == "https://")
            {
               try
               {
                  _loc3_ = _windowManager.assets.loadAssetFromFile(_loc7_,new URLRequest(_loc7_));
                  if(_loc3_ != null && !_loc3_.disposed)
                  {
                     if(_assetReceivers[_loc7_] == null)
                     {
                        _assetReceivers[_loc7_] = [];
                     }
                     if(param2 != null)
                     {
                        _assetReceivers[_loc7_].push(param2);
                     }
                     _loc3_.addEventListener("AssetLoaderEventComplete",passAssetToCallback);
                  }
               }
               catch(error:Error)
               {
                  var _loc5_:BitmapDataAsset = _windowManager.assets.getAssetByName("missing_image_icon") as BitmapDataAsset;
                  var _loc4_:BitmapData = _loc5_.content as BitmapData;
                  var _loc6_:BitmapDataAsset = new BitmapDataAsset(null);
                  _loc6_.setUnknownContent(null.clone());
                  param2.receiveAsset(null,_loc7_);
               }
            }
         }
         else if(param2 != null)
         {
            param2.receiveAsset(_loc8_,_loc7_);
         }
      }
      
      private function passAssetToCallback(param1:AssetLoaderEvent = null) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ == null || _assetReceivers[_loc3_.assetName] == null)
         {
            return;
         }
         var _loc4_:IAsset = _windowManager.assets.getAssetByName(_loc3_.assetName);
         for each(var _loc2_ in _assetReceivers[_loc3_.assetName])
         {
            if(_loc2_ != null && !_loc2_.disposed)
            {
               _loc2_.receiveAsset(_loc4_,_loc4_.url);
            }
         }
         delete _assetReceivers[_loc3_.assetName];
      }
      
      public function isSameAsset(param1:String, param2:String) : Boolean
      {
         return param2 == resolveAssetName(param1);
      }
      
      private function resolveAssetName(param1:String) : String
      {
         return _windowManager.interpolate(param1);
      }
      
      public function createAsset(param1:String, param2:Class, param3:Object) : IAsset
      {
         var _loc4_:IAsset = new param2(_windowManager.assets.getAssetTypeDeclarationByClass(param2));
         _windowManager.assets.setAsset(param1,_loc4_);
         _loc4_.setUnknownContent(param3);
         return _loc4_;
      }
      
      public function removeAsset(param1:String) : void
      {
         var _loc2_:String = resolveAssetName(param1);
         _windowManager.assets.removeAsset(_windowManager.assets.getAssetByName(_loc2_));
      }
   }
}

