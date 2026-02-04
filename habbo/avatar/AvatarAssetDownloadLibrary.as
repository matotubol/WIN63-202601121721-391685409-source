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
   
   public class AvatarAssetDownloadLibrary extends EventDispatcherWrapper
   {
      
      private static var STATE_IDLE:int = 0;
      
      private static var STATE_DOWNLOADING:int = 1;
      
      private static var STATE_READY:int = 2;
      
      private var var_61:int;
      
      private var _libraryName:String;
      
      private var var_3940:String;
      
      private var _downloadUrl:String;
      
      private var _assets:class_40;
      
      private var var_1086:Boolean;
      
      public function AvatarAssetDownloadLibrary(param1:String, param2:String, param3:String, param4:class_40, param5:String)
      {
         super();
         var_61 = STATE_IDLE;
         _assets = param4;
         _libraryName = param1;
         var_3940 = param2;
         _downloadUrl = param3 + param5;
         _downloadUrl = _downloadUrl.replace("%libname%",_libraryName);
         _downloadUrl = _downloadUrl.replace("%revision%",var_3940);
         var _loc6_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         var _loc7_:class_40 = _loc6_.getAssetLibraryByUrl(_libraryName + ".swf");
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
         var_61 = STATE_READY;
         var _loc2_:class_47 = param1.target as class_47;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         class_23.error("Could not load avatar asset library " + _libraryName + " from URL " + _downloadUrl + " HTTP status " + param1.status + " bytes loaded " + param1.bytesLoaded + "/" + param1.bytesTotal,false,2);
         dispatchEvent(new Event("complete"));
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:class_47 = param1.target as class_47;
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_COMPLETE",onLoaderComplete);
         _loc2_.removeEventListener("LIBRARY_LOADER_EVENT_ERROR",onLoaderError);
         var_61 = STATE_READY;
         dispatchEvent(new Event("complete"));
      }
      
      public function get libraryName() : String
      {
         return _libraryName;
      }
      
      public function get isReady() : Boolean
      {
         return var_61 == STATE_READY;
      }
      
      public function purge() : void
      {
         var _loc1_:AssetLibraryCollection = _assets as AssetLibraryCollection;
         if(!_loc1_)
         {
            return;
         }
         var _loc2_:class_40 = _loc1_.getAssetLibraryByUrl(_downloadUrl);
         if(_loc2_)
         {
            _loc1_.removeAssetLibrary(_loc2_);
            _loc2_.dispose();
            var_61 = STATE_IDLE;
         }
      }
      
      public function get isMandatory() : Boolean
      {
         return var_1086;
      }
      
      public function set isMandatory(param1:Boolean) : void
      {
         var_1086 = param1;
      }
      
      public function toString() : String
      {
         var _loc1_:String = _libraryName;
         return _loc1_ + (isReady ? "[x]" : "[ ]");
      }
   }
}

