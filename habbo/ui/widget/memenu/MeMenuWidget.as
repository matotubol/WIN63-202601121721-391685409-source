package com.sulake.habbo.ui.widget.memenu
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.MeMenuWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetAvatarEditorUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDanceUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetHabboClubUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetMiniMailUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPurseUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSettingsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetToolbarClickedUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetTutorialEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEffectsUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUserInfoUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetWaveUpdateEvent;
   import com.sulake.habbo.ui.widget.memenu.chatsettings.MeMenuChatSettingsView;
   import com.sulake.habbo.ui.widget.memenu.soundsettings.MeMenuSoundSettingsView;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMeMenuMessage;
   import com.sulake.habbo.utils.WindowToggle;
   import com.sulake.habbo.window.class_38;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MeMenuWidget extends RoomWidgetBase
   {
      
      public static const MAIN_VIEW:String = "me_menu_top_view";
      
      public static const MY_CLOTHES_VIEW:String = "me_menu_my_clothes_view";
      
      public static const const_889:String = "me_menu_dance_moves_view";
      
      public static const const_830:String = "me_menu_settings_view";
      
      public static const SOUND_SETTINGS_VIEW:String = "me_menu_sound_settings";
      
      public static const CHAT_SETTINGS_VIEW:String = "me_menu_chat_settings";
      
      private static const DEFAULT_VIEW_LOCATION_BOTTOM:Point = new Point(95,440);
      
      private var var_78:IMeMenuView;
      
      private var var_30:class_1812;
      
      private var var_3242:int = 0;
      
      private var var_4858:int = 0;
      
      private var var_5246:int = 0;
      
      private var var_4691:Boolean = false;
      
      private var var_3796:int = 0;
      
      private var var_3239:Boolean = false;
      
      private var var_4634:Boolean = false;
      
      private var var_1037:Boolean = false;
      
      private var var_3864:Boolean = false;
      
      private var var_4314:int = 0;
      
      private var var_1798:Boolean = false;
      
      private var _config:class_16;
      
      private var var_1270:int;
      
      public function MeMenuWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_16)
      {
         super(param1,param2,param3,param4);
         _config = param5;
         if(ExternalInterface.available)
         {
            var_3864 = param5.getBoolean("client.minimail.embed.enabled");
         }
         (param1 as MeMenuWidgetHandler).widget = this;
         changeView("me_menu_top_view");
         hide();
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         hide();
         if(var_78 != null)
         {
            var_78.dispose();
            var_78 = null;
         }
         var_30 = null;
         _config = null;
         super.dispose();
      }
      
      public function get handler() : MeMenuWidgetHandler
      {
         return var_41 as MeMenuWidgetHandler;
      }
      
      override public function get mainWindow() : class_1741
      {
         return var_30;
      }
      
      private function get mainContainer() : class_1812
      {
         var _loc1_:IAsset = null;
         if(var_30 == null)
         {
            _loc1_ = _assets.getAssetByName("memenu");
            if(_loc1_)
            {
               var_30 = windowManager.buildFromXML(_loc1_.content as XML) as class_1812;
            }
         }
         if(var_30)
         {
            return var_30.findChildByTag("MAIN_CONTENT") as class_1812;
         }
         return null;
      }
      
      public function changeView(param1:String) : void
      {
         var _loc2_:IMeMenuView = null;
         switch(param1)
         {
            case "me_menu_top_view":
               _loc2_ = new MeMenuMainView(config);
               break;
            case "me_menu_dance_moves_view":
               _loc2_ = new MeMenuDanceView();
               break;
            case "me_menu_settings_view":
               _loc2_ = new MeMenuSettingsMenuView();
               break;
            case "me_menu_sound_settings":
               _loc2_ = new MeMenuSoundSettingsView();
               break;
            case "me_menu_chat_settings":
               _loc2_ = new MeMenuChatSettingsView();
               break;
            default:
               class_21.log("Me Menu Change view: unknown view: " + param1);
         }
         if(_loc2_ != null)
         {
            if(var_78)
            {
               var_78.dispose();
               var_78 = null;
            }
            var_78 = _loc2_;
            var_78.init(this,param1);
            mainContainer.removeChildAt(0);
            mainContainer.addChildAt(var_78.window,0);
            var_30.visible = true;
            var_30.activate();
         }
         updateSize();
      }
      
      public function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Rectangle = null;
         if(var_78 && var_78.window && var_30)
         {
            _loc1_ = 5;
            var_78.window.position = new Point(_loc1_,_loc1_);
            mainContainer.width = var_78.window.width + _loc1_ * 2;
            mainContainer.height = var_78.window.height + _loc1_ * 2;
            if(_config.getBoolean("simple.memenu.enabled") && handler && handler.container && handler.container.toolbar)
            {
               _loc2_ = handler.container.toolbar.getRect();
               var_30.x = _loc2_.right + _loc1_;
               var_30.y = _loc2_.bottom - var_30.height;
            }
            else
            {
               var_30.x = DEFAULT_VIEW_LOCATION_BOTTOM.x;
               var_30.y = DEFAULT_VIEW_LOCATION_BOTTOM.y - mainContainer.height;
            }
         }
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWMMUE_new_mini_mail",onMiniMailUpdate);
         param1.addEventListener("RWMMUE_unread_mini_mail",onMiniMailUpdate);
         param1.addEventListener("RWUE_WAVE",onWaveEvent);
         param1.addEventListener("RWUE_DANCE",onDanceEvent);
         param1.addEventListener("RWUEUE_UPDATE_EFFECTS",onUpdateEffects);
         param1.addEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED",onToolbarClicked);
         param1.addEventListener("RWUE_AVATAR_EDITOR_CLOSED",onAvatarEditorClosed);
         param1.addEventListener("RWUE_HIDE_AVATAR_EDITOR",onHideAvatarEditor);
         param1.addEventListener("RWROUE_OBJECT_DESELECTED",onAvatarDeselected);
         param1.addEventListener("RWBIUE_HABBO_CLUB",onHabboClubEvent);
         param1.addEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.addEventListener("RWSUE_SETTINGS",onSettingsUpdate);
         param1.addEventListener("HHTPNUFWE_AE_STARTED",onTutorialEvent);
         param1.addEventListener("HHTPNUFWE_AE_HIGHLIGHT",onTutorialEvent);
         param1.addEventListener("RWPUE_CREDIT_BALANCE",onCreditBalance);
         param1.addEventListener("RWREUE_NORMAL_MODE",onNormalMode);
         param1.addEventListener("RWREUE_GAME_MODE",onGameMode);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWUE_WAVE",onWaveEvent);
         param1.removeEventListener("RWUE_DANCE",onDanceEvent);
         param1.removeEventListener("RWUEUE_UPDATE_EFFECTS",onUpdateEffects);
         param1.removeEventListener("RWUE_REQUEST_ME_MENU_TOOLBAR_CLICKED",onToolbarClicked);
         param1.removeEventListener("RWROUE_OBJECT_DESELECTED",onAvatarDeselected);
         param1.removeEventListener("RWBIUE_HABBO_CLUB",onHabboClubEvent);
         param1.removeEventListener("RWUE_AVATAR_EDITOR_CLOSED",onHideAvatarEditor);
         param1.removeEventListener("RWUE_HIDE_AVATAR_EDITOR",onAvatarEditorClosed);
         param1.removeEventListener("RWUIUE_OWN_USER",onUserInfo);
         param1.removeEventListener("RWSUE_SETTINGS",onSettingsUpdate);
         param1.removeEventListener("HHTPNUFWE_AE_HIGHLIGHT",onTutorialEvent);
         param1.removeEventListener("HHTPNUFWE_AE_STARTED",onTutorialEvent);
         param1.removeEventListener("RWPUE_CREDIT_BALANCE",onCreditBalance);
         param1.removeEventListener("RWREUE_NORMAL_MODE",onNormalMode);
         param1.removeEventListener("RWREUE_NORMAL_MODE",onGameMode);
      }
      
      public function hide(param1:RoomWidgetRoomObjectUpdateEvent = null) : void
      {
         if(var_78 != null)
         {
            var_30.removeChild(var_78.window);
            var_78.dispose();
            var_78 = null;
         }
         var_30.visible = false;
         var_1037 = false;
      }
      
      private function onUserInfo(param1:RoomWidgetUserInfoUpdateEvent) : void
      {
         var_1270 = param1.webID;
      }
      
      private function onSettingsUpdate(param1:RoomWidgetSettingsUpdateEvent) : void
      {
         if(!var_1037)
         {
            return;
         }
         if(var_78.window.name == "me_menu_sound_settings")
         {
            (var_78 as MeMenuSoundSettingsView).updateSettings(param1);
         }
      }
      
      private function onTutorialEvent(param1:RoomWidgetTutorialEvent) : void
      {
         switch(param1.type)
         {
            case "HHTPNUFWE_AE_HIGHLIGHT":
               class_21.log("* MeMenuWidget: onHighlightClothesIcon " + var_1037 + " view: " + var_78.window.name);
               if(var_1037 != true || var_78.window.name != "me_menu_top_view")
               {
                  return;
               }
               (var_78 as MeMenuMainView).setIconAssets("clothes_icon","me_menu_top_view","clothes_highlighter_blue");
               break;
            case "HHTPNUFWE_AE_STARTED":
               hide();
         }
      }
      
      private function onToolbarClicked(param1:RoomWidgetToolbarClickedUpdateEvent) : void
      {
         if(var_1037)
         {
            if(var_30 != null && WindowToggle.isHiddenByOtherWindows(var_30))
            {
               var_30.activate();
               return;
            }
            var_1037 = false;
         }
         else
         {
            var_1037 = true;
         }
         if(var_1037)
         {
            var _loc2_:RoomWidgetMeMenuMessage = new RoomWidgetMeMenuMessage("RWMMM_MESSAGE_ME_MENU_OPENED");
            if(messageListener != null)
            {
               messageListener.processWidgetMessage(null);
            }
            changeView("me_menu_top_view");
         }
         else
         {
            hide();
         }
      }
      
      private function onUpdateEffects(param1:RoomWidgetUpdateEffectsUpdateEvent) : void
      {
         var_3239 = false;
         for each(var _loc2_ in param1.effects)
         {
            if(_loc2_.isInUse)
            {
               var_3239 = true;
            }
         }
      }
      
      private function onAvatarDeselected(param1:Event) : void
      {
         if(var_78 != null && var_78.window.name != "me_menu_my_clothes_view")
         {
            hide();
         }
      }
      
      private function onAvatarEditorClosed(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_78 != null && var_78.window.name == "me_menu_my_clothes_view")
         {
            changeView("me_menu_top_view");
         }
      }
      
      private function onHideAvatarEditor(param1:RoomWidgetAvatarEditorUpdateEvent) : void
      {
         if(var_78 != null && var_78.window.name == "me_menu_my_clothes_view")
         {
            changeView("me_menu_top_view");
         }
      }
      
      private function onWaveEvent(param1:RoomWidgetWaveUpdateEvent) : void
      {
         class_21.log("[MeMenuWidget] Wave Event received");
      }
      
      private function onMiniMailUpdate(param1:RoomWidgetMiniMailUpdateEvent) : void
      {
         if(var_78)
         {
            var_78.updateUnseenItemCount("minimail",handler.container.messenger.getUnseenMiniMailMessageCount());
         }
      }
      
      private function onDanceEvent(param1:RoomWidgetDanceUpdateEvent) : void
      {
         class_21.log("[MeMenuWidget] Dance Event received, style: " + param1.style);
      }
      
      private function onHabboClubEvent(param1:RoomWidgetHabboClubUpdateEvent) : void
      {
         var _loc2_:* = param1.daysLeft != var_3242;
         var_3242 = param1.daysLeft;
         var_4858 = param1.periodsLeft;
         var_5246 = param1.pastPeriods;
         var_4691 = param1.allowClubDances;
         _loc2_ ||= param1.clubLevel != var_3796;
         var_3796 = param1.clubLevel;
         if(_loc2_)
         {
            if(var_78 != null)
            {
               changeView(var_78.window.name);
            }
         }
      }
      
      private function onCreditBalance(param1:RoomWidgetPurseUpdateEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_4314 = param1.balance;
         localizations.registerParameter("widget.memenu.credits","credits",var_4314.toString());
      }
      
      private function onNormalMode(param1:RoomWidgetRoomEngineUpdateEvent) : void
      {
         var_1798 = false;
      }
      
      private function onGameMode(param1:RoomWidgetRoomEngineUpdateEvent) : void
      {
         var_1798 = true;
      }
      
      public function get allowHabboClubDances() : Boolean
      {
         return var_4691;
      }
      
      public function get isHabboClubActive() : Boolean
      {
         return var_3242 > 0;
      }
      
      public function get habboClubDays() : int
      {
         return var_3242;
      }
      
      public function get habboClubPeriods() : int
      {
         return var_4858;
      }
      
      public function get habboClubLevel() : int
      {
         return var_3796;
      }
      
      public function get isMinimailEnabled() : Boolean
      {
         return var_3864;
      }
      
      public function get config() : class_16
      {
         return _config;
      }
      
      public function get hasEffectOn() : Boolean
      {
         return var_3239;
      }
      
      public function get isDancing() : Boolean
      {
         return var_4634;
      }
      
      public function set isDancing(param1:Boolean) : void
      {
         var_4634 = param1;
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get unreadMiniMailMessageCount() : int
      {
         return handler.container.messenger.getUnseenMiniMailMessageCount();
      }
      
      override public function release() : void
      {
         hide();
         super.release();
      }
   }
}

