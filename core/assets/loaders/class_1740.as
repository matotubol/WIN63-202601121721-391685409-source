package com.sulake.core.assets.loaders
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   
   internal class class_1740 extends EventDispatcherWrapper implements class_13
   {
      
      public static const NONE:uint = 0;
      
      public static const IO_ERROR:uint = 1;
      
      public static const const_304:uint = 2;
      
      protected var _status:int = 0;
      
      protected var var_461:int = 0;
      
      protected var var_4169:int = 2;
      
      protected var var_2759:uint = 0;
      
      public function class_1740()
      {
         super();
      }
      
      public function get errorCode() : uint
      {
         return var_2759;
      }
      
      protected function loadEventHandler(param1:Event) : void
      {
         switch(param1.type)
         {
            case "httpStatus":
               _status = HTTPStatusEvent(param1).status;
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventStatus",_status));
               break;
            case "complete":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventComplete",_status));
               break;
            case "unload":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventUnload",_status));
               break;
            case "open":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventOpen",_status));
               break;
            case "progress":
               dispatchEvent(new AssetLoaderEvent("AssetLoaderEventProgress",_status));
               break;
            case "ioError":
               var_2759 = 1;
               if(!retry())
               {
                  dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError",_status));
               }
               break;
            case "securityError":
               var_2759 = 2;
               if(!retry())
               {
                  dispatchEvent(new AssetLoaderEvent("AssetLoaderEventError",_status));
               }
         }
      }
      
      protected function retry() : Boolean
      {
         return false;
      }
   }
}

