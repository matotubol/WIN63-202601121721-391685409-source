package com.sulake.habbo.navigator.mainview
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.navigator.class_42;
   import flash.display.BitmapData;
   import flash.net.URLRequest;
   
   public class OfficialRoomImageLoader implements class_13
   {
      
      private var _navigator:class_42;
      
      private var var_2063:String;
      
      private var var_989:String;
      
      private var var_1016:class_2251;
      
      private var _disposed:Boolean;
      
      public function OfficialRoomImageLoader(param1:class_42, param2:String, param3:class_2251)
      {
         super();
         _navigator = param1;
         var_2063 = param2;
         var_1016 = param3;
         var _loc4_:String = _navigator.getProperty("image.library.url");
         var_989 = _loc4_ + var_2063;
         class_21.log("[OFFICIAL ROOM ICON IMAGE DOWNLOADER] : " + var_989);
      }
      
      public function startLoad() : void
      {
         var _loc1_:URLRequest = null;
         var _loc2_:AssetLoaderStruct = null;
         if(_navigator.assets.hasAsset(var_2063))
         {
            setImage();
         }
         else
         {
            _loc1_ = new URLRequest(var_989);
            _loc2_ = _navigator.assets.loadAssetFromFile(var_2063,_loc1_,"image/gif");
            _loc2_.addEventListener("AssetLoaderEventComplete",onImageReady);
            _loc2_.addEventListener("AssetLoaderEventError",onLoadError);
         }
      }
      
      private function onImageReady(param1:AssetLoaderEvent) : void
      {
         if(_disposed)
         {
            return;
         }
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ == null)
         {
            class_21.log("Loading pic from url: " + var_989 + " failed. loaderStruct == null");
            return;
         }
         setImage();
      }
      
      private function setImage() : void
      {
         var _loc1_:BitmapData = null;
         if(_navigator && !_navigator.disposed && var_1016 && !var_1016.disposed)
         {
            _loc1_ = _navigator.getButtonImage(var_2063,"");
            if(_loc1_)
            {
               var_1016.disposesBitmap = false;
               var_1016.bitmap = _loc1_;
               var_1016.width = _loc1_.width;
               var_1016.height = _loc1_.height;
               var_1016.visible = true;
            }
            else
            {
               class_21.log("OfficialRoomImageLoader - Image not found: " + var_2063);
            }
         }
         dispose();
      }
      
      private function onLoadError(param1:AssetLoaderEvent) : void
      {
         class_21.log("Error loading image: " + var_989 + ", " + param1);
         dispose();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_1016 = null;
         _navigator = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

