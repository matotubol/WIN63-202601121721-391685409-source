package com.sulake.core.runtime
{
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public interface class_16 extends IUnknown
   {
      
      function propertyExists(param1:String) : Boolean;
      
      function getProperty(param1:String, param2:Dictionary = null) : String;
      
      function setProperty(param1:String, param2:String, param3:Boolean = false, param4:Boolean = false) : void;
      
      function getBoolean(param1:String) : Boolean;
      
      function getInteger(param1:String, param2:int) : int;
      
      function interpolate(param1:String) : String;
      
      function updateUrlProtocol(param1:String) : String;
   }
}

