package com.sulake.habbo.communication
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class ApiRequest
   {
      
      public static const ERROR_TYPE_INVALID_CAPTCHA:String = "invalid-captcha";
      
      private var var_254:class_2080;
      
      private var var_2153:URLRequest;
      
      private var _uri:String;
      
      private var var_1188:String;
      
      private var _currentStatus:int;
      
      public function ApiRequest(param1:String, param2:String)
      {
         super();
         _uri = param2;
         var_1188 = param1;
      }
      
      public function get uri() : String
      {
         return _uri;
      }
      
      public function get requestMethod() : String
      {
         return var_1188;
      }
      
      public function dispose() : void
      {
         var_254 = null;
         var_2153 = null;
         _uri = null;
         var_1188 = null;
         _currentStatus = 0;
      }
      
      public function makeRequest(param1:class_2080, param2:URLRequest) : void
      {
         param2.method = var_1188;
         var_2153 = param2;
         var_254 = param1;
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "text";
         configureListeners(_loc3_);
         try
         {
            class_21.log("[ApiRequest] Make request: " + param2.url + " for " + _uri);
            _loc3_.load(param2);
         }
         catch(error:Error)
         {
            class_21.log("[ApiRequest] Unable to load requested document.");
         }
      }
      
      private function configureListeners(param1:IEventDispatcher) : void
      {
         param1.addEventListener("complete",completeHandler);
         param1.addEventListener("open",openHandler);
         param1.addEventListener("progress",progressHandler);
         param1.addEventListener("securityError",securityErrorHandler);
         param1.addEventListener("httpStatus",httpStatusHandler);
         param1.addEventListener("ioError",ioErrorHandler);
      }
      
      private function removeListeners(param1:IEventDispatcher) : void
      {
         param1.removeEventListener("complete",completeHandler);
         param1.removeEventListener("open",openHandler);
         param1.removeEventListener("progress",progressHandler);
         param1.removeEventListener("securityError",securityErrorHandler);
         param1.removeEventListener("httpStatus",httpStatusHandler);
         param1.removeEventListener("ioError",ioErrorHandler);
      }
      
      private function completeHandler(param1:Event) : void
      {
         var _loc5_:String = null;
         var _loc6_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Object = null;
         var _loc7_:Boolean = false;
         var _loc4_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc4_);
         if(var_254)
         {
            _loc5_ = _loc4_.data as String;
            _loc6_ = _loc5_ && (_loc5_.charAt(0) == "{" || _loc5_.charAt(0) == "[");
            _loc2_ = _loc5_ && _loc5_.charAt(0) == "<";
            try
            {
               if(_loc6_)
               {
                  _loc3_ = JSON.parse(_loc5_);
               }
               else if(_loc2_)
               {
                  _loc3_ = new XML(_loc5_);
               }
               if(_currentStatus >= 400 || _loc6_ && _loc3_.error != null)
               {
                  _loc7_ = false;
                  if(_loc6_)
                  {
                     _loc7_ = _loc3_.error == "invalid-captcha" || _loc3_.message == "invalid-captcha";
                  }
                  var_254.apiError(_uri,_currentStatus,_loc6_ ? _loc3_.error : "",_loc3_,_loc7_);
               }
               else
               {
                  var_254.apiResponse(_uri,_loc3_);
               }
            }
            catch(e:Error)
            {
               class_21.log("JSON parsing for API Request message failed. Data: " + _loc4_.data + " Error: " + e.errorID,e.name,e.message,e.getStackTrace());
               var_254.apiRawResponse(_uri,_loc4_.data);
            }
         }
      }
      
      private function openHandler(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function progressHandler(param1:ProgressEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
      }
      
      private function securityErrorHandler(param1:SecurityErrorEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         class_21.log("[ApiRequest] securityErrorHandler: " + param1);
         if(var_254 != null)
         {
            var_254.apiError(_uri,-1,"securityError",null);
         }
         removeListeners(_loc2_);
      }
      
      private function httpStatusHandler(param1:HTTPStatusEvent) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.target);
         _currentStatus = param1.status;
         switch(param1.status)
         {
            default:
               class_21.log("[ApiRequest - " + param1.status + "] httpStatusHandler: undhandled. " + _uri,var_1188,var_2153.url);
               break;
            case 404:
               class_21.log("[ApiRequest - 404] httpStatusHandler: Resource does not exist. " + _uri,var_1188,var_2153.url);
               break;
            case 409:
               class_21.log("[ApiRequest - 409] httpStatusHandler: Conflict. " + _uri,var_1188,var_2153.url,_loc2_);
               break;
            case 500:
               class_21.log("[ApiRequest - 500] httpStatusHandler: Internal server error. " + _uri,var_1188,_loc2_);
               break;
            case 200:
            case 403:
         }
      }
      
      private function ioErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc5_:URLLoader = URLLoader(param1.target);
         removeListeners(_loc5_);
         if(var_254 != null)
         {
            var _loc3_:Object = {"message":_loc5_.data};
            var _loc4_:Boolean = false;
            if(_loc5_.data)
            {
               try
               {
                  var _loc6_:String = _loc5_.data;
                  var _loc7_:Boolean = _loc6_ && (null.charAt(0) == "{" || null.charAt(0) == "[");
                  var _loc2_:Boolean = Boolean(null);
                  _loc3_ = _loc5_.data;
               }
               catch(e:Error)
               {
                  class_21.log("JSON parsing for Api Request ioError. Data: " + _loc5_.data);
               }
            }
            var_254.apiError(_uri,-2,"ioError",null,false);
         }
      }
   }
}

