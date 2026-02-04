package com.sulake.habbo.toolbar.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.toolbar.ToolbarView;
   import com.sulake.habbo.toolbar.memenu.chatsettings.MeMenuChatSettingsView;
   import com.sulake.habbo.toolbar.memenu.soundsettings.MeMenuSoundSettingsView;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView
   {
      
      private var var_16:MeMenuController;
      
      private var _window:class_1812;
      
      private var var_140:ToolbarView;
      
      private var var_2102:MeMenuSoundSettingsView;
      
      private var var_1809:MeMenuChatSettingsView;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuController, param2:ToolbarView) : void
      {
         var_140 = param2;
         var_16 = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(var_2102 != null)
         {
            var_2102.dispose();
            var_2102 = null;
         }
         if(var_1809 != null)
         {
            var_1809.dispose();
            var_1809 = null;
         }
         var_16 = null;
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function createWindow() : void
      {
         var _loc1_:XmlAsset = var_16.toolbar.assets.getAssetByName("me_menu_settings_menu_xml") as XmlAsset;
         if(_loc1_)
         {
            _window = var_16.toolbar.windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.procedure = eventHandler;
         _window.x = var_140.window.width + 10;
         _window.y = var_140.window.bottom - _window.height;
         if(!ExternalInterface.available || var_16.toolbar.getProperty("has.identity") != "1")
         {
            _window.findChildByName("character_settings").disable();
         }
         else
         {
            _window.findChildByName("identity_text").visible = false;
         }
         _window.findChildByName("chat_settings").visible = true;
      }
      
      private function eventHandler(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "character_settings":
               HabboWebTools.openAvatars();
               break;
            case "sound_settings":
               var_2102 = new MeMenuSoundSettingsView();
               var_2102.init(this,var_140);
               _window.visible = false;
               break;
            case "chat_settings":
               var_1809 = new MeMenuChatSettingsView();
               var_1809.init(this,var_140);
               break;
            case "back":
               var_16.window.visible = true;
               dispose();
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
      
      public function get widget() : MeMenuController
      {
         return var_16;
      }
   }
}

