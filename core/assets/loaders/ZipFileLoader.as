package com.sulake.core.assets.loaders
{
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   
   public class ZipFileLoader extends class_1740 implements class_1739
   {
      
      protected var var_989:String;
      
      protected var var_230:String;
      
      protected var var_231:URLStream;
      
      protected var var_24:ByteArray;
      
      private var var_197:int;
      
      public function ZipFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_989 = param2?.url;
         var_230 = param1;
         var_231 = new URLStream();
         var_231.addEventListener("complete",loadEventHandler);
         var_231.addEventListener("httpStatus",loadEventHandler);
         var_231.addEventListener("ioError",loadEventHandler);
         var_231.addEventListener("open",loadEventHandler);
         var_231.addEventListener("progress",loadEventHandler);
         var_231.addEventListener("securityError",loadEventHandler);
         var_197 = param3;
         if(param2 != null)
         {
            this.load(param2);
         }
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get content() : Object
      {
         return var_24 ? var_24 : var_231;
      }
      
      public function get bytes() : ByteArray
      {
         if(var_24)
         {
            return var_24;
         }
         var _loc1_:ByteArray = new ByteArray();
         var_231.readBytes(_loc1_);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return var_230;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_231.bytesAvailable;
      }
      
      public function get bytesTotal() : uint
      {
         return var_231.bytesAvailable;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_989 = param1.url;
         var_231.load(param1);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_231.removeEventListener("complete",loadEventHandler);
            var_231.removeEventListener("httpStatus",loadEventHandler);
            var_231.removeEventListener("ioError",loadEventHandler);
            var_231.removeEventListener("open",loadEventHandler);
            var_231.removeEventListener("progress",loadEventHandler);
            var_231.removeEventListener("securityError",loadEventHandler);
            var_231.close();
            var_231 = null;
            var_230 = null;
            var_989 = null;
         }
      }
   }
}

