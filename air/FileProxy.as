package com.sulake.air
{
   import com.sulake.core.utils.class_25;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileStream;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class FileProxy implements class_25
   {
      
      private static const LOCAL_FILE_PATH:String = "local_include/";
      
      private static const CACHE_PATH:String = "com.sulake.habbo/";
      
      private static const SWAP_FILE_PATH:String = "com.sulake.habbo/swap/swap_";
      
      private static var var_4164:int = 0;
      
      private var var_1117:Dictionary;
      
      public function FileProxy()
      {
         super();
      }
      
      private static function resolveFileFromLocalPath(param1:String) : String
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:int = int(param1.indexOf("local_include/"));
         if(_loc2_ != -1)
         {
            return param1.substr(_loc2_ + "local_include/".length);
         }
         return param1;
      }
      
      public function dispose() : void
      {
         var_1117 = null;
      }
      
      public function clearCache() : void
      {
         deleteCacheDirectory("");
      }
      
      public function localFilePath(param1:String) : String
      {
         var _loc2_:File = File.applicationDirectory.resolvePath("local_include/" + param1);
         return _loc2_.url;
      }
      
      public function cacheFilePath(param1:String) : String
      {
         var _loc2_:File = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
         return _loc2_.url;
      }
      
      public function loadLocalBitmapData(param1:String, param2:Function) : void
      {
         addCallback(param1,param2);
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener("complete",onLocalFileComplete);
         _loc3_.contentLoaderInfo.addEventListener("error",onLocalFileError);
         _loc3_.contentLoaderInfo.addEventListener("ioError",onLocalFileError);
         _loc3_.load(new URLRequest(localFilePath(param1)));
      }
      
      public function cacheFileExists(param1:String) : Boolean
      {
         var _loc2_:File = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return false;
            }
            _loc2_ = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
            if(_loc2_ && _loc2_.exists)
            {
               return true;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      public function localFileExists(param1:String) : Boolean
      {
         var _loc2_:File = null;
         try
         {
            _loc2_ = File.applicationDirectory.resolvePath("local_include/" + param1);
            if(_loc2_ && _loc2_.exists)
            {
               return true;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      public function readCache(param1:String) : ByteArray
      {
         var _loc2_:File = null;
         var _loc4_:ByteArray = null;
         var _loc3_:FileStream = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return null;
            }
            _loc2_ = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
            if(!_loc2_ || !_loc2_.exists)
            {
               return null;
            }
            class_21.log("[FileProxy] Read file " + _loc2_.nativePath);
            _loc4_ = new ByteArray();
            _loc3_ = new FileStream();
            _loc3_.open(_loc2_,"read");
            _loc3_.readBytes(_loc4_);
            _loc3_.close();
            return _loc4_;
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] File reading error: " + e);
         }
         return null;
      }
      
      public function readCacheAsync(param1:String, param2:Function) : void
      {
         var file:File;
         var stream:FileStream;
         var path:String = param1;
         var callback:Function = param2;
         try
         {
            if(!File.cacheDirectory)
            {
               callback(null);
               return;
            }
            file = File.cacheDirectory.resolvePath("com.sulake.habbo/" + path);
            if(!file || !file.exists)
            {
               callback(null);
               return;
            }
            class_21.log("[FileProxy] Read file " + file.nativePath);
            stream = new FileStream();
            stream.openAsync(file,"read");
            stream.addEventListener("complete",function(param1:Event):void
            {
               var _loc2_:ByteArray = new ByteArray();
               stream.readBytes(_loc2_);
               callback(_loc2_);
               stream.close();
            });
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] File reading error: " + e);
            callback(null);
         }
      }
      
      public function writeCache(param1:String, param2:ByteArray) : void
      {
         var _loc3_:File = null;
         var _loc4_:FileStream = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return;
            }
            _loc3_ = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
            _loc4_ = new FileStream();
            _loc4_.open(_loc3_,"write");
            _loc4_.writeBytes(param2);
            _loc4_.close();
            class_21.log("[FileProxy] Wrote file " + _loc3_.nativePath);
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] File writing error: " + e);
         }
      }
      
      public function writeCacheAsync(param1:String, param2:ByteArray) : void
      {
         var _loc3_:File = null;
         var _loc4_:FileStream = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return;
            }
            _loc3_ = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
            _loc4_ = new FileStream();
            _loc4_.openAsync(_loc3_,"write");
            _loc4_.writeBytes(param2);
            _loc4_.close();
            class_21.log("[FileProxy] Wrote file " + _loc3_.nativePath);
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] File writing error: " + e);
         }
      }
      
      public function deleteCacheDirectory(param1:String) : void
      {
         var _loc2_:File = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return;
            }
            _loc2_ = File.cacheDirectory.resolvePath("com.sulake.habbo/" + param1);
            if(_loc2_.exists && Boolean(_loc2_.isDirectory))
            {
               _loc2_.deleteDirectory(true);
               class_21.log("[FileProxy] Deleted directory " + _loc2_.nativePath);
            }
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] File deleting error: " + e);
         }
      }
      
      private function onLocalFileComplete(param1:Event) : void
      {
         var _loc2_:String = resolveFileFromLocalPath(param1.target.url);
         var _loc3_:BitmapData = (param1.target.content as Bitmap).bitmapData;
         doCallbacks(_loc2_,_loc3_);
      }
      
      private function onLocalFileError(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = resolveFileFromLocalPath(param1.target.url);
         if(param1.type == "ioError")
         {
            _loc3_ = "IOError: " + (param1 as IOErrorEvent).text;
         }
         else if(param1 is ErrorEvent)
         {
            _loc3_ = "Error: " + (param1 as ErrorEvent).errorID + "(" + _loc2_ + ")";
         }
         else
         {
            _loc3_ = param1.toString();
         }
         class_21.log("[FileProxy] Error when accessing local file! " + _loc3_);
         doCallbacks(_loc2_,null);
      }
      
      private function addCallback(param1:String, param2:Function) : void
      {
         if(!var_1117)
         {
            var_1117 = new Dictionary();
         }
         var _loc3_:Array = var_1117[param1];
         if(!_loc3_)
         {
            _loc3_ = [];
            var_1117[param1] = _loc3_;
         }
         _loc3_.push(param2);
      }
      
      private function doCallbacks(param1:String, param2:BitmapData) : void
      {
         if(!var_1117)
         {
            return;
         }
         var _loc4_:Array = var_1117[param1];
         if(!_loc4_)
         {
            return;
         }
         for each(var _loc3_ in _loc4_)
         {
            if(_loc3_ != null)
            {
               if(param2)
               {
                  _loc3_(param2.clone());
               }
               else
               {
                  _loc3_(null);
               }
            }
         }
         if(param2)
         {
            param2.dispose();
         }
         delete var_1117[param1];
      }
      
      public function swapObjectToDisk(param1:Object) : int
      {
         var _loc2_:File = null;
         var _loc3_:FileStream = null;
         var _loc4_:int = -1;
         try
         {
            if(File.cacheDirectory)
            {
               _loc4_ = ++var_4164;
               _loc2_ = File.cacheDirectory.resolvePath("com.sulake.habbo/swap/swap_" + _loc4_);
               _loc3_ = new FileStream();
               _loc3_.open(_loc2_,"write");
               _loc3_.writeObject(param1);
               _loc3_.close();
            }
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] Swap in error: " + e);
            _loc4_ = -1;
         }
         return _loc4_;
      }
      
      public function swapObjectFromDisk(param1:int) : Object
      {
         var _loc2_:String = null;
         var _loc3_:File = null;
         var _loc4_:FileStream = null;
         var _loc5_:Object = null;
         try
         {
            if(!File.cacheDirectory)
            {
               return null;
            }
            _loc2_ = "com.sulake.habbo/swap/swap_" + param1;
            _loc3_ = File.cacheDirectory.resolvePath(_loc2_);
            if(!_loc3_ || !_loc3_.exists)
            {
               return null;
            }
            _loc4_ = new FileStream();
            _loc4_.open(_loc3_,"read");
            _loc5_ = _loc4_.readObject();
            _loc4_.close();
            _loc3_.deleteFileAsync();
            return _loc5_;
         }
         catch(e:Error)
         {
            class_21.log("[FileProxy] Swap out error: " + e);
         }
         return null;
      }
   }
}

