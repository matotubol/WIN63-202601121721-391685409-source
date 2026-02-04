package com.sulake.habbo.roomevents.wired_menu.tabs.tab_monitor
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2052;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.roomevents.wired_menu.WiredMenuController;
   import com.sulake.habbo.window.class_38;
   import package_97.class_4089;
   
   public class WiredErrorInfoView implements class_13
   {
      
      private var _disposed:Boolean;
      
      private var _window:class_1812;
      
      private var var_55:WiredMenuController;
      
      private var _windowManager:class_38;
      
      public function WiredErrorInfoView(param1:WiredMenuController)
      {
         super();
         var_55 = param1;
         _windowManager = param1.windowManager;
         _window = _windowManager.buildFromXML(XML(param1.assets.getAssetByName("error_info_view_xml").content),1) as class_1812;
         closeButton.addEventListener("WME_CLICK",onWindowClose);
      }
      
      public function initialize(param1:class_4089) : void
      {
         errorName.text = param1.errorName;
         typeIcon.assetUri = "icon_wired_" + param1.category.toLowerCase() + "_png";
         errorText.text = var_55.localizationManager.getLocalization("wiredmenu.error_info." + param1.errorId);
         _window.height = contentsContainer.height + 48;
      }
      
      public function show() : void
      {
         var _loc1_:class_2052 = null;
         _window.x = Math.max(_window.x,0);
         _window.y = Math.max(_window.y,0);
         if(_windowManager != null && _window != null && _window.parent == null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.addChild(_window);
            }
         }
         _window.activate();
      }
      
      private function hide() : void
      {
         var _loc1_:class_2052 = null;
         if(_windowManager != null && _window != null && _window.parent != null)
         {
            _loc1_ = _windowManager.getDesktop(1);
            if(_loc1_ != null)
            {
               _loc1_.removeChild(_window);
            }
         }
      }
      
      private function onWindowClose(param1:class_1758) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hide();
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         hide();
         _window.dispose();
         _window = null;
         _windowManager = null;
         var_55 = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function get closeButton() : class_1741
      {
         return _window.findChildByName("header_button_close");
      }
      
      private function get errorName() : ITextWindow
      {
         return _window.findChildByName("error_name") as ITextWindow;
      }
      
      private function get errorText() : ITextWindow
      {
         return _window.findChildByName("error_text") as ITextWindow;
      }
      
      private function get contentsContainer() : class_1812
      {
         return _window.findChildByName("contents") as class_1812;
      }
      
      private function get typeIcon() : IStaticBitmapWrapperWindow
      {
         return _window.findChildByName("type_icon") as IStaticBitmapWrapperWindow;
      }
   }
}

