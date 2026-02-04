package com.sulake.habbo.phonenumber
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class VerificationCodeInputMinimizedView
   {
      
      private static const BG_COLOR_LIGHT:uint = 4286084205;
      
      private static const BG_COLOR_DARK:uint = 4283781966;
      
      private var var_59:HabboPhoneNumber;
      
      private var _window:class_1741;
      
      public function VerificationCodeInputMinimizedView(param1:HabboPhoneNumber)
      {
         super();
         var_59 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window)
         {
            _window.removeEventListener("WME_CLICK",onClicked);
            _window.dispose();
            _window = null;
         }
         var_59 = null;
      }
      
      public function get window() : class_1741
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            return;
         }
         _window = var_59.windowManager.buildFromXML(XML(var_59.assets.getAssetByName("phonenumber_verify_minimized_xml").content));
         _window.addEventListener("WME_CLICK",onClicked);
         _window.addEventListener("WME_OVER",onContainerMouseOver);
         _window.addEventListener("WME_OUT",onContainerMouseOut);
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
      
      private function onClicked(param1:WindowMouseEvent) : void
      {
         var_59.setVerifyViewMinimized(false);
      }
      
      private function onContainerMouseOver(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4286084205;
      }
      
      private function onContainerMouseOut(param1:WindowMouseEvent) : void
      {
         IRegionWindow(_window).findChildByTag("BGCOLOR").color = 4283781966;
      }
   }
}

