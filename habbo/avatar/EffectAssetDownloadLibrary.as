package com.sulake.habbo.avatar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.class_23;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_47;
   import com.sulake.core.utils.class_54;
   import flash.events.Event;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import com.sulake.habbo.communication.messages.incoming.moderation.class_2217;
   
   public class EffectAssetDownloadLibrary extends EventDispatcherWrapper implements class_2217
   {
      
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_DOWNLOADING:int = 1;
      
      private static var STATE_READY:int = 2;
      
      private var var_61:int;
      
      private var _name:String;
      
      private var var_3940:String;
      
      private var _downloadUrl:String;
      
      private var _assets:class_40;
      
      private var var_2040:XML;
      
      public function EffectAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:class_40, param5:String)
      {
         super();
         var_61 = STATE_IDLE;
         _assets = param4;
         _name = param1;
         var_3940 = param2;
         _downloadUrl = param3 + param5;
         _downloadUrl = _downloadUrl.replace("%libname%",_name);
         _downloadUrl = _downloadUrl.replace("%revision%",var_3940);
         var _loc6_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         var _loc7_:class_40 = _loc6_.getAssetLibraryByUrl(_name + ".swf");
         if(_loc7_ != null)
         {
            var_61 = STATE_READY;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function startDownloading() : void
      {
         var_61 = STATE_DOWNLOADING;
         var _loc1_:URLRequest = new URLRequest(_downloadUrl);
         var _loc2_:class_47 = new class_47();
         _assets.loadFromFile(_loc2_,true);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.addEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         _loc2_.load(_loc1_);
      }
      
      private function onLoaderError(param1:class_54) : void
      {
         class_23.error("Could not load effect asset library " + _name + " from URL " + _downloadUrl + " HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal,false,2);
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc5_:ByteArray = null;
         var _loc3_:ByteArray = null;
         var _loc2_:class_47 = param1.target as class_47;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         var _loc4_:Object = (_loc2_.resource as Object).animation;
         if(_loc4_ is XML)
         {
            var_2040 = _loc4_ as XML;
         }
         else if(_loc4_ is Class)
         {
            _loc5_ = new (_loc4_ as Class)() as ByteArray;
            var_2040 = new XML(_loc5_.readUTFBytes(_loc5_.length));
         }
         else if(_loc4_ is ByteArray)
         {
            _loc3_ = _loc4_ as ByteArray;
            var_2040 = new XML(_loc3_.readUTFBytes(_loc3_.length));
         }
         var_61 = STATE_READY;
         dispatchEvent(new Event("complete"));
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get isReady() : Boolean
      {
         return var_61 == STATE_READY;
      }
      
      public function toString() : String
      {
         var _loc1_:String = _name;
         return _loc1_ + (isReady ? "[x]" : "[ ]");
      }
      
      public function get animation() : XML
      {
         return var_2040;
      }
   }
}

