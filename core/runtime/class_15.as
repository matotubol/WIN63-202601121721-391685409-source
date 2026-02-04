package com.sulake.core.runtime
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.utils.class_47;
   import flash.display.DisplayObjectContainer;
   import flash.events.IEventDispatcher;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   [SecureSWF(rename="true")]
   public interface class_15 extends IUnknown
   {
      
      function get assets() : class_40;
      
      function get events() : IEventDispatcher;
      
      function get root() : class_15;
      
      function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : Boolean;
      
      function getLastErrorMessage() : String;
      
      function debug(param1:String) : void;
      
      function getLastDebugMessage() : String;
      
      function warning(param1:String) : void;
      
      function getLastWarningMessage() : String;
      
      function get displayObjectContainer() : DisplayObjectContainer;
      
      function loadFromFile(param1:URLRequest, param2:LoaderContext) : class_47;
      
      function attachComponent(param1:class_17, param2:Array) : void;
      
      function detachComponent(param1:class_17) : void;
      
      function prepareComponent(param1:Class, param2:uint = 0, param3:ApplicationDomain = null) : IUnknown;
      
      function prepareAssetLibrary(param1:XML, param2:Class) : Boolean;
      
      function registerUpdateReceiver(param1:class_31, param2:uint) : void;
      
      function removeUpdateReceiver(param1:class_31) : void;
      
      function toXMLString(param1:uint = 0) : String;
      
      function get configuration() : class_16;
      
      function set configuration(param1:class_16) : void;
      
      function addLinkEventTracker(param1:ILinkEventTracker) : void;
      
      function removeLinkEventTracker(param1:ILinkEventTracker) : void;
      
      function createLinkEvent(param1:String) : void;
      
      function get linkEventTrackers() : Vector.<ILinkEventTracker>;
   }
}

