package com.sulake.core.utils
{
   import flash.utils.ByteArray;
   
   public interface class_25
   {
      
      function clearCache() : void;
      
      function localFilePath(param1:String) : String;
      
      function cacheFilePath(param1:String) : String;
      
      function loadLocalBitmapData(param1:String, param2:Function) : void;
      
      function cacheFileExists(param1:String) : Boolean;
      
      function localFileExists(param1:String) : Boolean;
      
      function readCache(param1:String) : ByteArray;
      
      function readCacheAsync(param1:String, param2:Function) : void;
      
      function writeCache(param1:String, param2:ByteArray) : void;
      
      function writeCacheAsync(param1:String, param2:ByteArray) : void;
      
      function deleteCacheDirectory(param1:String) : void;
      
      function swapObjectToDisk(param1:Object) : int;
      
      function swapObjectFromDisk(param1:int) : Object;
   }
}

