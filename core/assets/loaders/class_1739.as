package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.class_13;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public interface class_1739 extends IEventDispatcher, class_13
   {
      
      function get url() : String;
      
      function get content() : Object;
      
      function get bytes() : ByteArray;
      
      function get mimeType() : String;
      
      function get bytesLoaded() : uint;
      
      function get bytesTotal() : uint;
      
      function get errorCode() : uint;
      
      function get id() : int;
      
      function load(param1:URLRequest) : void;
   }
}

