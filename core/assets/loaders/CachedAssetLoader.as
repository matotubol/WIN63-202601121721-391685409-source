package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class CachedAssetLoader extends EventDispatcherWrapper implements class_1739
   {
      
      private var var_989:String;
      
      private var _content:Object;
      
      private var var_4676:String;
      
      private var var_1028:ByteArray;
      
      private var var_197:int;
      
      public function CachedAssetLoader(param1:String, param2:String, param3:Object, param4:ByteArray = null, param5:int = -1)
      {
         super();
         var_989 = param1;
         var_4676 = param2;
         _content = param3;
         var_197 = param5;
         var_1028 = param4 ?? buildBytes(param3);
         if(var_1028 != null)
         {
            var_1028.position = 0;
         }
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get content() : Object
      {
         return _content;
      }
      
      public function get bytes() : ByteArray
      {
         return var_1028;
      }
      
      public function get mimeType() : String
      {
         return var_4676;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_1028 ? var_1028.length : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return var_1028 ? var_1028.length : 0;
      }
      
      public function get errorCode() : uint
      {
         return 0;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function load(param1:URLRequest) : void
      {
         if(param1 != null)
         {
            var_989 = param1.url;
         }
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            _content = null;
            var_1028 = null;
            super.dispose();
         }
      }
      
      private function buildBytes(param1:Object) : ByteArray
      {
         if(param1 is ByteArray)
         {
            return param1 as ByteArray;
         }
         var _loc2_:ByteArray = new ByteArray();
         if(param1 is XML)
         {
            _loc2_.writeUTFBytes(XML(param1).toXMLString());
         }
         else if(param1 != null)
         {
            _loc2_.writeUTFBytes(String(param1));
         }
         return _loc2_;
      }
   }
}

