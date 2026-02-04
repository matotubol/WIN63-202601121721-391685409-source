package com.sulake.air
{
   import com.sulake.habbo.utils.air.INativeApplicationProxy;
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.SoundMixer;
   
   public class NativeApplicationProxy extends EventDispatcher implements INativeApplicationProxy
   {
      
      public static var isDeactivated:Boolean;
      
      public static var isSuspended:Boolean;
      
      public function NativeApplicationProxy()
      {
         super();
         SoundMixer.audioPlaybackMode = "ambient";
         NativeApplication.nativeApplication.addEventListener("activate",onApplicationActivate);
         NativeApplication.nativeApplication.addEventListener("deactivate",onApplicationDeactivate);
         NativeApplication.nativeApplication.addEventListener("suspend",onApplicationSuspend);
      }
      
      public function dispose() : void
      {
         NativeApplication.nativeApplication.removeEventListener("activate",onApplicationActivate);
         NativeApplication.nativeApplication.removeEventListener("deactivate",onApplicationDeactivate);
         NativeApplication.nativeApplication.removeEventListener("suspend",onApplicationSuspend);
      }
      
      public function allowBackgroundExecution(param1:Boolean) : void
      {
         NativeApplication.nativeApplication.executeInBackground = param1;
      }
      
      private function onApplicationActivate(param1:Event) : void
      {
         this.dispatchEvent(new Event("NAE_application_active"));
         isDeactivated = false;
         isSuspended = false;
      }
      
      private function onApplicationSuspend(param1:Event) : void
      {
         this.dispatchEvent(new Event("NAE_application_suspend"));
         isSuspended = true;
      }
      
      private function onApplicationDeactivate(param1:Event) : void
      {
         this.dispatchEvent(new Event("NAE_application_deactive"));
         isDeactivated = true;
      }
   }
}

