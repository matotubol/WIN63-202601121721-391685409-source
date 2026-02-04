package com.sulake.core
{
   import com.sulake.core.runtime.class_12;
   import com.sulake.core.runtime.class_19;
   import com.sulake.core.runtime.class_20;
   import com.sulake.core.runtime.class_52;
   import flash.display.DisplayObjectContainer;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   [SecureSWF(rename="true")]
   public final class class_23
   {
      
      public static const CORE_SETUP_FRAME_UPDATE_SIMPLE:uint = 0;
      
      public static const CORE_SETUP_FRAME_UPDATE_COMPLEX:uint = 1;
      
      public static const CORE_SETUP_FRAME_UPDATE_PROFILER:uint = 2;
      
      public static const CORE_SETUP_FRAME_UPDATE_EXPERIMENT:uint = 4;
      
      public static const CORE_SETUP_FRAME_UPDATE_MASK:uint = 15;
      
      public static const CORE_SETUP_DEBUG:uint = 15;
      
      public static const ERROR_CATEGORY_DOWNLOAD_CONFIGURATION:int = 1;
      
      public static const ERROR_CATEGORY_DOWNLOAD_LIBRARY:int = 2;
      
      public static const ERROR_CATEGORY_DOWNLOAD_CRITICAL_ASSET:int = 3;
      
      public static const ERROR_CATEGORY_PREPARE_COMPONENT:int = 4;
      
      public static const ERROR_CATEGORY_COMPONENT_RESOURCE_LOAD_ERROR:int = 5;
      
      public static const ERROR_CATEGORY_INTERFACE_AVAILABILITY:int = 6;
      
      public static const ERROR_CATEGORY_PRODUCT_DATA:int = 7;
      
      public static const ERROR_CATEGORY_DOWNLOAD_LOCALIZATION:int = 8;
      
      public static const ERROR_CATEGORY_FINALIZE_PRELOADING:int = 9;
      
      public static const ERROR_CATEGORY_INITIALIZE_CORE:int = 10;
      
      public static const ERROR_CATEGORY_DOWNLOAD_FONT:int = 11;
      
      public static const ERROR_CATEGORY_FURNIDATA_DOWNLOAD:int = 12;
      
      public static const ERROR_CATEGORY_DOWNLOAD_EXTERNAL_VARIABLES:int = 20;
      
      public static const ERROR_CATEGORY_DOWNLOAD_EXTERNAL_VARIABLES_OVERRIDE:int = 21;
      
      public static const ERROR_CATEGORY_COMMMUNICATION_INIT:int = 29;
      
      public static const ERROR_CATEGORY_CONNECT_TO_PROXY:int = 30;
      
      public static const ERROR_UNCAUGHT_ERROR:int = 40;
      
      public static const ERROR_CATEGORY_INTENTIONAL_DEBUG_CRASH:int = 99;
      
      private static var var_287:class_19;
      
      public function class_23()
      {
         super();
      }
      
      public static function get version() : String
      {
         return "0.0.3";
      }
      
      public static function get instance() : class_19
      {
         return var_287;
      }
      
      public static function instantiate(param1:DisplayObjectContainer, param2:uint, param3:class_12 = null, param4:Dictionary = null) : class_19
      {
         if(var_287 == null)
         {
            var_287 = new class_20(param1,param3 ?? new class_52(),param2,param4);
         }
         return var_287;
      }
      
      public static function error(param1:String, param2:Boolean, param3:int = -1, param4:Error = null) : void
      {
         if(var_287)
         {
            var_287.error(param1,param2,param3,param4);
         }
      }
      
      public static function warning(param1:String) : void
      {
         if(var_287)
         {
            var_287.warning(param1);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.logWarn",param1);
         }
      }
      
      public static function debug(param1:String) : void
      {
         if(var_287)
         {
            var_287.debug(param1);
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("FlashExternalInterface.logDebug",param1);
         }
      }
      
      public static function crash(param1:String, param2:int, param3:Error = null) : void
      {
         if(var_287)
         {
            var_287.error(param1,true,param2,param3);
         }
      }
      
      public static function purge() : void
      {
         if(var_287)
         {
            var_287.purge();
         }
      }
      
      public static function dispose() : void
      {
         if(var_287 != null)
         {
            var_287.dispose();
            var_287 = null;
         }
      }
   }
}

