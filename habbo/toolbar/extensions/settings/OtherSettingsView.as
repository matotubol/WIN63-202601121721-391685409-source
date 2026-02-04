package com.sulake.habbo.toolbar.extensions.settings
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1885;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import package_113.class_3100;
   import package_12.class_2891;
   import package_12.class_3307;
   
   public class OtherSettingsView
   {
      
      private var _window:class_1812;
      
      private var _toolbar:HabboToolbar;
      
      public function OtherSettingsView(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
         createWindow();
      }
      
      public function dispose() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
      }
      
      private function createWindow() : void
      {
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("me_menu_other_settings_xml") as XmlAsset;
         _window = _toolbar.windowManager.buildFromXML(_loc3_.content as XML) as class_1812;
         _window.procedure = onButtonClicked;
         if(_toolbar.getBoolean("chat.disable_old_chat"))
         {
            _window.findChildByName("prefer_old_chat").visible = false;
         }
         class_1885(_window.findChildByName("prefer_old_chat_checkbox")).isSelected = _toolbar.freeFlowChat.isDisabledInPreferences;
         class_1885(_window.findChildByName("ignore_room_invites_checkbox")).isSelected = _toolbar.messenger.getRoomInvitesIgnored();
         class_1885(_window.findChildByName("disable_wired_whisper_checkbox")).isSelected = _toolbar.roomEvents.wiredWhisperDisabled;
         _window.findChildByName("disable_room_camera_follow").visible = _toolbar.getBoolean("room.camera.follow_user");
         if(_toolbar.getBoolean("room.camera.follow_user"))
         {
            class_1885(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected = _toolbar.sessionDataManager.isRoomCameraFollowDisabled;
         }
         var _loc1_:Boolean = _toolbar.getBoolean("sms.identity.verification.enabled");
         var _loc5_:* = _toolbar.getInteger("phone.verification.status",0) == 2;
         var _loc2_:* = _toolbar.getInteger("phone.collection.status",0) == 2;
         var _loc6_:Boolean = _toolbar.getBoolean("sms.identity.verification.button.enabled");
         var _loc4_:* = _toolbar.getInteger("phone.collection.status",0) == 0;
         var _loc7_:Boolean = _loc1_ && !_loc5_ && (_loc2_ || _loc6_ && _loc4_);
         _window.findChildByName("btn_reset_phone_number_collection").visible = _loc7_;
      }
      
      private function onButtonClicked(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         var _loc3_:String = param2.name;
         switch(_loc3_)
         {
            case "back_btn":
               dispose();
               break;
            case "prefer_old_chat_checkbox":
               _toolbar.freeFlowChat.isDisabledInPreferences = class_1885(_window.findChildByName("prefer_old_chat_checkbox")).isSelected;
               if(!_toolbar.freeFlowChat.isDisabledInPreferences)
               {
                  if(_toolbar.roomUI.chatContainer != null && _toolbar.freeFlowChat.displayObject != null)
                  {
                     _toolbar.roomUI.chatContainer.setDisplayObject(_toolbar.freeFlowChat.displayObject);
                  }
                  break;
               }
               _toolbar.freeFlowChat.clear();
               break;
            case "ignore_room_invites_checkbox":
               _toolbar.messenger.setRoomInvitesIgnored(class_1885(_window.findChildByName("ignore_room_invites_checkbox")).isSelected);
               _toolbar.connection.send(new class_3307(_toolbar.messenger.getRoomInvitesIgnored()));
               break;
            case "disable_wired_whisper_checkbox":
               var _loc5_:Boolean = Boolean(class_1885(_window.findChildByName("disable_wired_whisper_checkbox")).isSelected);
               _toolbar.roomEvents.wiredWhisperDisabled = false;
               break;
            case "disable_room_camera_follow_checkbox":
               var _loc4_:Boolean = Boolean(class_1885(_window.findChildByName("disable_room_camera_follow_checkbox")).isSelected);
               _toolbar.connection.send(new class_2891(false));
               _toolbar.sessionDataManager.setRoomCameraFollowDisabled(false);
               break;
            case "btn_reset_phone_number_collection":
               _window.findChildByName("btn_reset_phone_number_collection").visible = false;
               _toolbar.connection.send(new class_3100());
         }
      }
      
      public function get window() : class_1812
      {
         return _window;
      }
   }
}

