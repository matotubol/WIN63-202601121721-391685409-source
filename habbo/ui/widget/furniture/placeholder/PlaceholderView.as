package com.sulake.habbo.ui.widget.furniture.placeholder
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.window.class_38;
   import flash.geom.Rectangle;
   
   public class PlaceholderView
   {
      
      private var var_909:class_40;
      
      private var _windowManager:class_38;
      
      private var _window:class_1812;
      
      public function PlaceholderView(param1:class_40, param2:class_38)
      {
         super();
         var_909 = param1;
         _windowManager = param2;
      }
      
      public function dispose() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function toggleWindow() : void
      {
         if(_window != null && Boolean(_window.visible))
         {
            hideWindow();
         }
         else
         {
            showWindow();
         }
      }
      
      public function showWindow() : void
      {
         if(_window == null)
         {
            createWindow();
         }
         if(_window == null)
         {
            return;
         }
         _window.visible = true;
         _window.x = 200;
      }
      
      private function createWindow() : void
      {
         var _loc2_:XmlAsset = var_909.getAssetByName("placeholder") as XmlAsset;
         if(_loc2_ == null || _loc2_.content == null)
         {
            return;
         }
         _window = _windowManager.createWindow("habbohelp_window","",4,0,0x020000 | 1,new Rectangle(-300,300,10,10),null) as class_1812;
         _window.buildFromXML(_loc2_.content as XML);
         _window.tags.push("habbo_help_window");
         _window.background = true;
         _window.color = 33554431;
         var _loc1_:class_1741 = _window.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.procedure = onWindowClose;
         }
      }
      
      public function hideWindow() : void
      {
         if(_window != null)
         {
            _window.visible = false;
         }
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideWindow();
      }
   }
}

