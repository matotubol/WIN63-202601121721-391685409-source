package com.sulake.habbo.catalog.club
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   
   public class VipBenefitsWindow implements class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var _window:class_1812;
      
      public function VipBenefitsWindow(param1:HabboCatalog)
      {
         super();
         _window = param1.utils.createWindow("vip_benefits") as class_1812;
         _window.findChildByName("header_button_close").addEventListener("WME_CLICK",onClose);
         _window.center();
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(_window != null)
            {
               _window.dispose();
               _window = null;
            }
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         dispose();
      }
   }
}

