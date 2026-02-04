package com.sulake.core.assets.loaders
{
   import flash.media.Sound;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class SoundFileLoader extends class_1740 implements class_1739
   {
      
      protected var var_989:String;
      
      protected var var_230:String;
      
      protected var var_229:Sound;
      
      private var var_197:int;
      
      public function SoundFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_989 = param2?.url;
         var_230 = param1;
         var_229 = new Sound(null,null);
         var_229.addEventListener("id3",loadEventHandler);
         var_229.addEventListener("open",loadEventHandler);
         var_229.addEventListener("complete",loadEventHandler);
         var_229.addEventListener("ioError",loadEventHandler);
         var_229.addEventListener("progress",loadEventHandler);
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
         return var_229;
      }
      
      public function get bytes() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         var_229.extract(_loc1_,var_229.length);
         return _loc1_;
      }
      
      public function get mimeType() : String
      {
         return var_230;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_229 ? var_229.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return var_229 ? var_229.bytesTotal : 0;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            var_229.removeEventListener("id3",loadEventHandler);
            var_229.removeEventListener("open",loadEventHandler);
            var_229.removeEventListener("complete",loadEventHandler);
            var_229.removeEventListener("ioError",loadEventHandler);
            var_229.removeEventListener("progress",loadEventHandler);
            var_229 = null;
            var_230 = null;
            var_989 = null;
            super.dispose();
         }
      }
      
      public function load(param1:URLRequest) : void
      {
         var_989 = param1.url;
         var_229.load(param1,null);
      }
   }
}

