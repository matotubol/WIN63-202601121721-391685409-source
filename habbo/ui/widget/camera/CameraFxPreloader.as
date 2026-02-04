package com.sulake.habbo.ui.widget.camera
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class CameraFxPreloader
   {
      
      private static var ASSETS:Dictionary;
      
      private static var instance:CameraFxPreloader;
      
      private static var _urls:Array;
      
      private static var var_1639:String;
      
      private var var_75:Loader;
      
      private var var_3923:Boolean = false;
      
      public function CameraFxPreloader()
      {
         super();
         var_75 = new Loader();
         var_75.contentLoaderInfo.addEventListener("complete",assetLoaded);
         var_75.contentLoaderInfo.addEventListener("ioError",loadFailed);
         loadNextImage();
      }
      
      public static function init(param1:String, param2:Array) : void
      {
         if(!instance)
         {
            ASSETS = new Dictionary();
            var_1639 = param1;
            _urls = param2;
            instance = new CameraFxPreloader();
         }
      }
      
      public static function preloadFinished() : Boolean
      {
         return instance != null ? instance.var_3923 : false;
      }
      
      public static function getImage(param1:String) : BitmapData
      {
         return ASSETS != null ? ASSETS[param1] : null;
      }
      
      private function loadNextImage() : void
      {
         var _loc1_:String = null;
         if(_urls.length > 0)
         {
            _loc1_ = var_1639 + "Habbo-Stories/" + _urls[0] + ".png";
            var_75.load(new URLRequest(_loc1_));
         }
         else
         {
            var_3923 = true;
         }
      }
      
      private function assetLoaded(param1:Event) : void
      {
         ASSETS[_urls.shift()] = Bitmap(var_75.content).bitmapData.clone();
         loadNextImage();
      }
      
      private function loadFailed(param1:Event) : void
      {
         class_21.log("Camera Fx preloading failed for " + var_75.contentLoaderInfo.loaderURL);
         _urls.shift();
         loadNextImage();
      }
   }
}

