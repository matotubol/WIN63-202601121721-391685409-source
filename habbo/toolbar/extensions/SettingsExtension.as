package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import com.sulake.habbo.toolbar.extensions.settings.OtherSettingsView;
   import com.sulake.habbo.toolbar.extensions.settings.SoundSettingsView;
   import com.sulake.habbo.toolbar.extensions.settings.WordFilterSettingsView;
   import com.sulake.habbo.utils.HabboWebTools;
   
   public class SettingsExtension implements class_13
   {
      
      private static const SPACING:int = 3;
      
      private static const PADDING:int = 7;
      
      private var _toolbar:HabboToolbar;
      
      private var _window:class_1812;
      
      private var var_34:Vector.<class_1741> = new Vector.<class_1741>();
      
      private var _disposed:Boolean = false;
      
      public function SettingsExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         _window = _toolbar.windowManager.buildFromXML(param1.assets.getAssetByName("settings_xml").content as XML) as class_1812;
         _window.procedure = windowProcedure;
         addButton("avatar_settings",_toolbar.localization.getLocalization("widget.memenu.settings.character","Avatar settings"));
         addButton("privacy",_toolbar.localization.getLocalization("title.privacy.settings","Privacy settings"));
         addButton("sound",_toolbar.localization.getLocalization("widget.memenu.settings.audio","Sound settings"));
         addButton("chat",_toolbar.localization.getLocalization("widget.memenu.settings.other","Other settings"));
         var _loc2_:Boolean = _toolbar.getBoolean("user.custom.filter.enabled");
         if(_loc2_)
         {
            addButton("word_filter",_toolbar.localization.getLocalization("word_filter.settings.title","Word filter"));
         }
         param1.extensionView.attachExtension("settings",_window,1);
         _window.visible = false;
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _toolbar = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      private function addButton(param1:String, param2:String) : void
      {
         var _loc3_:class_1812 = _toolbar.windowManager.buildFromXML(_toolbar.assets.getAssetByName("setting_category_xml").content as XML) as class_1812;
         _window.addChild(_loc3_);
         _loc3_.findChildByName("button_label").caption = param2;
         if(var_34.length > 0)
         {
            _loc3_.y = var_34[var_34.length - 1].bottom + 3;
         }
         else
         {
            _loc3_.y = 7;
         }
         _loc3_.x = 7;
         _loc3_.name = param1;
         _loc3_.procedure = windowProcedure;
         var_34.push(_loc3_);
         _window.height = var_34[var_34.length - 1].bottom + 7;
      }
      
      private function openSoundSettingsWindow() : void
      {
         var _loc2_:SoundSettingsView = new SoundSettingsView(_toolbar);
         var _loc1_:class_1812 = _toolbar.windowManager.getDesktop(1);
         _loc1_.addChild(_loc2_.window);
         _loc2_.window.x = _loc1_.width - _loc2_.window.width - 200;
      }
      
      private function openChatSettingsWindow() : void
      {
         var _loc2_:OtherSettingsView = new OtherSettingsView(_toolbar);
         var _loc1_:class_1812 = _toolbar.windowManager.getDesktop(1);
         _loc1_.addChild(_loc2_.window);
         _loc2_.window.x = _loc1_.width - _loc2_.window.width - 200;
      }
      
      private function openWordFilterWindow() : void
      {
         var _loc1_:WordFilterSettingsView = new WordFilterSettingsView(_toolbar);
         var _loc2_:class_1812 = _toolbar.windowManager.getDesktop(1);
         _loc2_.addChild(_loc1_.window);
         _loc1_.window.x = _loc2_.width - _loc1_.window.width - 200;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         switch(param2.name)
         {
            case "avatar_settings":
               HabboWebTools.openAvatars();
               _toolbar.toggleSettingVisibility();
               break;
            case "privacy":
               HabboWebTools.openPrivacy();
               _toolbar.toggleSettingVisibility();
               break;
            case "sound":
               openSoundSettingsWindow();
               _toolbar.toggleSettingVisibility();
               break;
            case "chat":
               openChatSettingsWindow();
               _toolbar.toggleSettingVisibility();
               break;
            case "word_filter":
               openWordFilterWindow();
               _toolbar.toggleSettingVisibility();
         }
      }
   }
}

