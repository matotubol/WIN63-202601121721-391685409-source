package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.external.ExternalInterface;
   
   public class MeMenuSettingsMenuView implements IMeMenuView
   {
      
      private var var_16:MeMenuWidget;
      
      private var _window:class_1812;
      
      public function MeMenuSettingsMenuView()
      {
         super();
      }
      
      public function init(param1:MeMenuWidget, param2:String) : void
      {
         var_16 = param1;
         createWindow(param2);
      }
      
      public function dispose() : void
      {
         var_16 = null;
         if(_window)
         {
            _window.dispose();
            _window = null;
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      private function createWindow(param1:String) : void
      {
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("memenu_settings_menu") as XmlAsset;
         if(_loc2_)
         {
            _window = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         }
         if(_window == null)
         {
            throw new Error("Failed to construct settings window from XML!");
         }
         _window.name = param1;
         _window.procedure = eventHandler;
         if(!ExternalInterface.available || var_16.config.getProperty("has.identity") != "1")
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
               var_16.hide();
               break;
            case "sound_settings":
               var_16.changeView("me_menu_sound_settings");
               break;
            case "chat_settings":
               var_16.changeView("me_menu_chat_settings");
               break;
            case "back":
               var_16.changeView("me_menu_top_view");
         }
      }
      
      public function updateUnseenItemCount(param1:String, param2:int) : void
      {
      }
   }
}

