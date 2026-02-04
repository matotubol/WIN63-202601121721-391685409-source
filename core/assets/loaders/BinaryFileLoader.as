package com.sulake.core.assets.loaders
{
   import com.sulake.core.utils.class_2187;
   import flash.events.Event;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class BinaryFileLoader extends class_1740 implements class_1739
   {
      
      protected var var_989:String;
      
      protected var var_230:String;
      
      protected var var_24:Object;
      
      protected var var_75:URLLoader;
      
      private var var_197:int;
      
      public function BinaryFileLoader(param1:String, param2:URLRequest = null, param3:int = -1)
      {
         super();
         var_989 = param2?.url;
         var_230 = param1;
         var_75 = new URLLoader();
         var_75.dataFormat = "binary";
         var_75.addEventListener("complete",loadEventHandler);
         var_75.addEventListener("unload",loadEventHandler);
         var_75.addEventListener("httpStatus",loadEventHandler);
         var_75.addEventListener("progress",loadEventHandler);
         var_75.addEventListener("ioError",loadEventHandler);
         var_75.addEventListener("securityError",securityErrorEventHandler);
         var_197 = param3;
         if(param2 != null)
         {
            load(param2);
         }
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get content() : Object
      {
         return var_24 ? var_24 : (var_75 ? var_75.data : null);
      }
      
      public function get bytes() : ByteArray
      {
         var _loc1_:ByteArray = null;
         if(var_75)
         {
            if(var_75.data is ByteArray)
            {
               return var_75.data;
            }
            if(var_75.data is String)
            {
               _loc1_ = new ByteArray();
               _loc1_.writeUTFBytes(var_75.data);
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get mimeType() : String
      {
         return var_230;
      }
      
      public function get bytesLoaded() : uint
      {
         return var_75 ? var_75.bytesLoaded : 0;
      }
      
      public function get bytesTotal() : uint
      {
         return var_75 ? var_75.bytesTotal : 0;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function load(param1:URLRequest) : void
      {
         var_989 = param1.url;
         var_24 = null;
         var_461 = 0;
         var_75.dataFormat = "binary";
         var_24 = class_2187.method_20(param1.url) as String;
         if(var_24)
         {
            var _loc2_:Timer = new Timer(10,1);
            null.addEventListener("timer",timerEventHandler);
            null.start();
            return;
         }
         var_75.load(param1);
      }
      
      override protected function retry() : Boolean
      {
         if(!_disposed)
         {
            if(++var_461 <= var_4169)
            {
               try
               {
                  var_75.close();
               }
               catch(e:Error)
               {
               }
               var_75.load(new URLRequest(var_989 + (var_989.indexOf("?") == -1 ? "?" : "&") + "retry=" + var_461));
               return true;
            }
         }
         return false;
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            super.dispose();
            var_75.removeEventListener("complete",loadEventHandler);
            var_75.removeEventListener("unload",loadEventHandler);
            var_75.removeEventListener("httpStatus",loadEventHandler);
            var_75.removeEventListener("progress",loadEventHandler);
            var_75.removeEventListener("ioError",loadEventHandler);
            var_75.removeEventListener("securityError",securityErrorEventHandler);
            try
            {
               var_75.close();
            }
            catch(e:Error)
            {
            }
            var_75 = null;
            var_230 = null;
            var_24 = null;
            var_989 = null;
         }
      }
      
      private function securityErrorEventHandler(param1:SecurityErrorEvent) : void
      {
         if(!_disposed)
         {
            loadEventHandler(param1);
         }
      }
      
      private function timerEventHandler(param1:TimerEvent) : void
      {
         var _loc2_:Timer = param1.target as Timer;
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.removeEventListener("timer",timerEventHandler);
         }
         if(!_disposed)
         {
            loadEventHandler(new Event("complete"));
         }
      }
   }
}

