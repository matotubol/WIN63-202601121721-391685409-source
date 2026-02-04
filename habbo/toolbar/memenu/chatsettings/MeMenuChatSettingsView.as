package com.sulake.habbo.toolbar.memenu.chatsettings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.MeMenuSettingsMenuView;
   
   public class MeMenuChatSettingsView
   {
      
      private var var_16:MeMenuSettingsMenuView;
      
      private var _window:class_1812;
      
      private var var_140:ToolbarView;
      
      public function MeMenuChatSettingsView()
      {
         super();
      }
      
      public function init(param1:MeMenuSettingsMenuView, param2:ToolbarView) : void
      {
         var_16 = param1;
         var_140 = param2;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         var _loc1_:class_1885 = _window.findChildByName("prefer_old_chat_checkbox") as class_1885;
         var_16.window.visible = true;
         var_16.widget.toolbar.freeFlowChat.isDisabledInPreferences = _loc1_ != null && Boolean(_loc1_.isSelected);
         _window.dispose();
         _window = null;
         var_16 = null;
      }
      
      private function createWindow() : void
      {
         var _loc2_:XmlAsset = var_16.widget.toolbar.assets.getAssetByName("me_menu_chat_settings_xml") as XmlAsset;
         _window = var_16.widget.toolbar.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         _window.x = var_140.window.width + 10;
         _window.y = var_140.window.bottom - _window.height;
         var_16.window.visible = false;
         var _loc3_:int = 0;
         var _loc1_:class_1741 = null;
         while(0 < _window.numChildren)
         {
            _loc1_ = _window.getChildAt(0);
            null.addEventListener("WME_CLICK",onButtonClicked);
            _loc3_++;
         }
         class_1885(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = var_16.widget.toolbar.freeFlowChat.isDisabledInPreferences;
      }
      
      private function onButtonClicked(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "back_btn":
               dispose();
               break;
            case "prefer_old_chat_checkbox":
               var_16.widget.toolbar.freeFlowChat.isDisabledInPreferences = class_1885(_window.findChildByName("prefer_old_chat_checkbox")).isSelected;
               if(!var_16.widget.toolbar.freeFlowChat.isDisabledInPreferences)
               {
                  if(var_16.widget.toolbar.roomUI.chatContainer != null)
                  {
                     var_16.widget.toolbar.roomUI.chatContainer.setDisplayObject(var_16.widget.toolbar.freeFlowChat.displayObject);
                  }
                  break;
               }
               var_16.widget.toolbar.freeFlowChat.clear();
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

