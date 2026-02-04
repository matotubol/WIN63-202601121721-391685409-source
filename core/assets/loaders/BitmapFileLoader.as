package com.sulake.core.assets.loaders
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.PNGEncoderOptions;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class BitmapFileLoader extends class_1740 implements class_1739
   {
      
      protected var var_989:String;
      
      protected var var_230:String;
      
      protected var var_75:Loader;
      
      protected var var_1938:LoaderContext;
      
      private var var_197:int = -1;
      
      public function BitmapFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_989 = param2?.url;
         var_230 = param1;
         var_75 = new Loader();
         var_1938 = new LoaderContext();
         var_1938.checkPolicyFile = false;
         var_75.contentLoaderInfo.addEventListener("complete",completeEventHandler);
         var_75.contentLoaderInfo.addEventListener("unload",loadEventHandler);
         var_75.contentLoaderInfo.addEventListener("httpStatus",loadEventHandler);
         var_75.contentLoaderInfo.addEventListener("progress",loadEventHandler);
         var_75.contentLoaderInfo.addEventListener("ioError",loadEventHandler);
         var_75.contentLoaderInfo.addEventListener("securityError",loadEventHandler);
         var_197 = param3;
         if(param2 != null && param2.url != null)
         {
            var_75.load(param2,var_1938);
         }
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get content() : Object
      {
         return var_75 ? var_75.content : null;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc2_:Bitmap = content as Bitmap;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:BitmapData = _loc2_.bitmapData;
         return _loc1_.encode(_loc1_.rect,new PNGEncoderOptions());
      }
      
      public function get mimeType() : String
      {
         return var_230;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_75 ? var_75.contentLoaderInfo.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return var_75 ? var_75.contentLoaderInfo.bytesTotal : 0;
      }
      
      public function get loaderContext() : LoaderContext
      {
         return var_1938;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_989 = param1.url;
         var_461 = 0;
         var_75.load(param1,var_1938);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++var_461 <= var_4169)
            {
               try
               {
                  var_75.close();
                  var_75.unload();
               }
               catch(e:Error)
               {
               }
               var_75.load(new URLRequest(var_989 + (var_989.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_461),var_1938);
               return true;
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_75.contentLoaderInfo.removeEventListener("complete",completeEventHandler);
            var_75.contentLoaderInfo.removeEventListener("unload",loadEventHandler);
            var_75.contentLoaderInfo.removeEventListener("httpStatus",loadEventHandler);
            var_75.contentLoaderInfo.removeEventListener("progress",loadEventHandler);
            var_75.contentLoaderInfo.removeEventListener("ioError",loadEventHandler);
            var_75.contentLoaderInfo.removeEventListener("securityError",loadEventHandler);
            try
            {
               var_75.close();
            }
            catch(e:*)
            {
            }
            var_75.unload();
            var_75 = null;
            var_230 = null;
            var_989 = null;
         }
      }
      
      private function completeEventHandler(param1:Event) : void
      {
         loadEventHandler(param1);
      }
   }
}

