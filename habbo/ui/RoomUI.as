package com.sulake.habbo.ui
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.advertisement.class_56;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.advertisement.events.InterstitialEvent;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.freeflowchat.style.class_2244;
   import com.sulake.habbo.friendbar.IHabboFriendBar;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.friendbar.events.FriendBarResizeEvent;
   import com.sulake.habbo.friendbar.view.class_1962;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.groups.class_140;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.IHabboNewNavigator;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.room.events.RoomEngineZoomEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.events.SessionDataEvent;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   import com.sulake.habbo.ui.widget.RoomWidgetFactory;
   import com.sulake.habbo.ui.widget.enums.AvatarExpressionEnum;
   import com.sulake.habbo.ui.widget.events.HideRoomWidgetEvent;
   import com.sulake.habbo.ui.widget.events.RoomDesktopMouseZoomEnableEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.*;
   import com.sulake.room.utils.RoomId;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import package_16.class_1774;
   import package_64.class_2121;
   
   public class RoomUI extends class_17 implements IRoomUI, class_31
   {
      
      private static var var_4627:Array = ["RWE_INFOSTAND","RWE_CHAT_INPUT_WIDGET","RWE_ME_MENU","RWE_CHAT_WIDGET","RWE_EXTERNAL_IMAGE","RWE_CAMERA","RWE_ROOM_TOOLS","RWE_FURNITURE_CONTEXT_MENU"];
      
      private var _windowManager:class_38;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var var_1797:IRoomWidgetFactory;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _friendList:class_258;
      
      private var _avatarRenderManager:class_48;
      
      private var _inventory:class_61;
      
      private var _toolbar:IHabboToolbar;
      
      private var _navigator:class_41;
      
      private var _newNavigator:IHabboNewNavigator;
      
      private var _habboGroupsManager:class_140;
      
      private var _avatarEditor:class_141;
      
      private var _catalog:IHabboCatalog;
      
      private var _adManager:class_56;
      
      private var _localization:class_27;
      
      private var _habboHelp:IHabboHelp;
      
      private var _messenger:class_46;
      
      private var _moderation:IHabboModeration;
      
      private var _soundManager:class_544;
      
      private var _gameManager:class_45;
      
      private var _friendBar:IHabboFriendBar;
      
      private var _friendBarView:class_1962;
      
      private var _landingView:IHabboLandingView;
      
      private var _questEngine:class_498;
      
      private var _freeFlowChat:class_51;
      
      private var _communication:class_57;
      
      private var var_22:RoomDesktop;
      
      private var var_1358:Dictionary;
      
      private var var_5263:int = -1;
      
      private var var_509:Boolean;
      
      private var var_3757:int;
      
      private var _habboTracking:class_53;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_3026:Boolean = false;
      
      private var _isInRoom:Boolean = false;
      
      private var _perkAllowancesMessageEvent:IMessageEvent;
      
      public function RoomUI(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         var_1797 = new RoomWidgetFactory(this);
         var_1358 = new Dictionary();
         registerUpdateReceiver(this,0);
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         }),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },true,[{
            "type":"REE_ENGINE_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_INITIALIZED",
            "callback":roomEventHandler
         },{
            "type":"REE_OBJECTS_INITIALIZED",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_DISPOSED",
            "callback":roomEventHandler
         },{
            "type":"REE_NORMAL_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_GAME_MODE",
            "callback":roomEngineEventHandler
         },{
            "type":"REE_ENTRANCE_AFTER_SPECTATE",
            "callback":roomEventHandler
         },{
            "type":"REDSE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REE_ROOM_ZOOM",
            "callback":roomEventHandler
         },{
            "type":"ROHSLCEE_ROOM_BACKGROUND_COLOR",
            "callback":roomEventHandler
         },{
            "type":"REOE_SELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_DESELECTED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_ADDED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REMOVED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_PLACED",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_MOVE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_ROTATE",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_REQUEST_PICKUP",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_ENTER",
            "callback":roomObjectEventHandler
         },{
            "type":"REOE_MOUSE_LEAVE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_WIDGET",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_OPEN_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_CLOSE_FURNI_CONTEXT_MENU",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CREDITFURNI",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_STICKIE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PRESENT",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TROPHY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_TEASER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ECOTRONBOX",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLACEHOLDER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_FURNI_DOUBLE_CLICK",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_SHOW",
            "callback":roomObjectEventHandler
         },{
            "type":"RERAE_TOOLTIP_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REMOVE_DIMMER",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_CLOTHING_CHANGE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_PLAYLIST_EDITOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_MANNEQUIN",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BACKGROUND_COLOR",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_UPDATE_STATE_AREA_HIDE",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_INVENTORY",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_USE_PRODUCT_FROM_ROOM",
            "callback":roomObjectEventHandler
         },{
            "type":"ROSM_JUKEBOX_DISPOSE",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_INTERNAL_LINK",
            "callback":roomObjectEventHandler
         },{
            "type":"RETWE_REQUEST_ROOM_LINK",
            "callback":roomObjectEventHandler
         }]),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },true,[{
            "type":"RSE_CREATED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_STARTED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ENDED",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSE_ROOM_DATA",
            "callback":roomSessionStateEventHandler
         },{
            "type":"RSCE_CHAT_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSCE_FLOOD_EVENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSUBE_BADGES",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DOORBELL",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_REJECTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_ACCEPTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_PRESENT_OPENED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_REQUESTED",
            "callback":roomSessionEventHandler
         },{
            "type":"RSOPPE_OPEN_PET_PACKAGE_RESULT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSEME_KICKED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_PETS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_MAX_NUMBER_OF_OWN_PETS",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_NO_FREE_TILES_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_PET",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_HOTEL",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOTS_FORBIDDEN_IN_FLAT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_LIMIT_REACHED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSEME_BOT_NAME_NOT_ACCEPTED",
            "callback":roomSessionDialogEventHandler
         },{
            "type":"RSQE_QUEUE_STATUS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_CONTENT",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_ERROR",
            "callback":roomSessionEventHandler
         },{
            "type":"RSPE_POLL_OFFER",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESTION_ANSWERED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_QUESION_FINSIHED",
            "callback":roomSessionEventHandler
         },{
            "type":"RWPUW_NEW_QUESTION",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDPE_PRESETS",
            "callback":roomSessionEventHandler
         },{
            "type":"RSFRE_FRIEND_REQUEST",
            "callback":roomSessionEventHandler
         },{
            "type":"rsudue_user_data_updated",
            "callback":roomSessionEventHandler
         },{
            "type":"RSDE_DANCE",
            "callback":roomSessionEventHandler
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         },true,[{
            "type":"SDTWE_PURCHASABLE_STYLES_UPDATED",
            "callback":sessionDataEventHandler
         }]),new ComponentDependency(new IIDHabboFriendList(),function(param1:class_258):void
         {
            _friendList = param1;
         }),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderManager = param1;
         }),new ComponentDependency(new IIDHabboInventory(),function(param1:class_61):void
         {
            _inventory = param1;
         }),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         }),new ComponentDependency(new IIDHabboNavigator(),function(param1:class_41):void
         {
            _navigator = param1;
         }),new ComponentDependency(new IIDHabboNewNavigator(),function(param1:IHabboNewNavigator):void
         {
            _newNavigator = param1;
         }),new ComponentDependency(new IIDHabboGroupsManager(),function(param1:class_140):void
         {
            _habboGroupsManager = param1;
         }),new ComponentDependency(new IIDHabboAvatarEditor(),function(param1:class_141):void
         {
            _avatarEditor = param1;
         }),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         }),new ComponentDependency(new IIDHabboAdManager(),function(param1:class_56):void
         {
            _adManager = param1;
         },true,[{
            "type":"AE_INTERSTITIAL_NOT_SHOWN",
            "callback":interstitialNotAvailableEventHandler
         },{
            "type":"AE_INTERSTITIAL_COMPLETE",
            "callback":interstitialCompleteEventHandler
         },{
            "type":"AE_INTERSTITIAL_SHOW",
            "callback":interstitialShowEventHandler
         },{
            "type":"AE_ROOM_AD_SHOW",
            "callback":adEventHandler
         }]),new ComponentDependency(new IIDHabboLocalizationManager(),function(param1:class_27):void
         {
            _localization = param1;
         }),new ComponentDependency(new IIDHabboHelp(),function(param1:IHabboHelp):void
         {
            _habboHelp = param1;
         }),new ComponentDependency(new IIDHabboModeration(),function(param1:IHabboModeration):void
         {
            _moderation = param1;
         }),new ComponentDependency(new IIDHabboSoundManager(),function(param1:class_544):void
         {
            _soundManager = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         }),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _userDefinedRoomEvents = param1;
         }),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _habboTracking = param1;
         }),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_45):void
         {
            _gameManager = param1;
         },true,[{
            "type":"gce_game_chat",
            "callback":gameEventHandler
         }]),new ComponentDependency(new IIDHabboFriendBar(),function(param1:IHabboFriendBar):void
         {
            _friendBar = param1;
         }),new ComponentDependency(new IIDHabboFriendBarView(),function(param1:class_1962):void
         {
            _friendBarView = param1;
         },true,[{
            "type":"FBE_BAR_RESIZE_EVENT",
            "callback":bottomBarResizeHandler
         }]),new ComponentDependency(new IIDHabboLandingView(),function(param1:IHabboLandingView):void
         {
            _landingView = param1;
         }),new ComponentDependency(new IIDHabboQuestEngine(),function(param1:class_498):void
         {
            _questEngine = param1;
         }),new ComponentDependency(new IIDHabboMessenger(),function(param1:class_46):void
         {
            _messenger = param1;
         }),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         _perkAllowancesMessageEvent = _communication.addHabboConnectionMessageEvent(new class_2121(onPerkAllowances));
      }
      
      override public function dispose() : void
      {
         var _loc1_:IRoomWidget = null;
         if(disposed)
         {
            return;
         }
         if(var_1797 != null)
         {
            var_1797.dispose();
            var_1797 = null;
         }
         if(_communication != null)
         {
            _communication.removeHabboConnectionMessageEvent(_perkAllowancesMessageEvent);
            _perkAllowancesMessageEvent = null;
         }
         disposeDesktop();
         if(var_1358 != null)
         {
            for(var _loc2_ in var_1358)
            {
               _loc1_ = var_1358[_loc2_];
               _loc1_.dispose();
            }
            var_1358 = null;
         }
         removeUpdateReceiver(this);
         super.dispose();
      }
      
      private function roomSessionStateEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RSE_CREATED":
               createDesktop(param1.session);
               if(param1.session.isGameSession)
               {
                  if(_toolbar)
                  {
                     _toolbar.setToolbarState("HTE_STATE_HIDDEN");
                  }
                  if(_friendBar)
                  {
                     _friendBar.visible = false;
                  }
                  if(_landingView)
                  {
                     _landingView.disable();
                  }
               }
               break;
            case "RSE_STARTED":
               if(_toolbar)
               {
                  defineToolbarState(param1.session);
               }
               if(_landingView)
               {
                  _landingView.disable();
               }
               break;
            case "RSE_ROOM_DATA":
               defineToolbarState(param1.session);
               break;
            case "RSE_ENDED":
               if(param1.session != null)
               {
                  disposeDesktop();
                  if(param1.session.isGameSession)
                  {
                     _friendBar.visible = true;
                     if(_gameManager)
                     {
                        _gameManager.onSnowWarArenaSessionEnded();
                     }
                     break;
                  }
                  if(param1.openLandingPage)
                  {
                     if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
                     {
                        if(_navigator.enteredGuestRoomData && _navigator.enteredGuestRoomData.doorMode == 4)
                        {
                           _navigator.goToHomeRoom();
                           break;
                        }
                        context.createLinkEvent("navigator/goto/predefined_noob_lobby");
                        break;
                     }
                     if(_landingView)
                     {
                        _landingView.activate();
                     }
                  }
               }
         }
      }
      
      private function defineToolbarState(param1:IRoomSession) : void
      {
         if(getBoolean("nux.lobbies.enabled") && _sessionDataManager.isRealNoob)
         {
            if(param1 && param1.isNoobRoom)
            {
               _toolbar.setToolbarState("HTE_STATE_NOOB_NOT_HOME");
            }
            else
            {
               _toolbar.setToolbarState("HETE_STATE_NOOB_HOME");
            }
         }
         else
         {
            _toolbar.setToolbarState("HTE_STATE_ROOM_VIEW");
         }
      }
      
      private function roomSessionEventHandler(param1:RoomSessionEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(param1.session != null)
         {
            if(var_22 != null)
            {
               var_22.processEvent(param1);
            }
         }
      }
      
      private function sessionDataEventHandler(param1:SessionDataEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(desktop != null)
         {
            desktop.processEvent(param1);
         }
      }
      
      private function roomSessionDialogEventHandler(param1:RoomSessionEvent) : void
      {
         var errorMessage:String;
         var event:RoomSessionEvent = param1;
         var errorTitle:String = "${error.title}";
         switch(event.type)
         {
            case "RSEME_MAX_PETS":
               errorMessage = "${room.error.max_pets}";
               break;
            case "RSEME_MAX_NUMBER_OF_OWN_PETS":
               errorMessage = "${room.error.max_own_pets}";
               break;
            case "RSEME_KICKED":
               errorMessage = "${room.error.kicked}";
               errorTitle = "${generic.alert.title}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.pets.forbidden_in_hotel}";
               break;
            case "RSEME_PETS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.pets.forbidden_in_flat}";
               break;
            case "RSEME_NO_FREE_TILES_FOR_PET":
               errorMessage = "${room.error.pets.no_free_tiles}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_PET":
               errorMessage = "${room.error.pets.selected_tile_not_free}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_HOTEL":
               errorMessage = "${room.error.bots.forbidden_in_hotel}";
               break;
            case "RSEME_BOTS_FORBIDDEN_IN_FLAT":
               errorMessage = "${room.error.bots.forbidden_in_flat}";
               break;
            case "RSEME_BOT_LIMIT_REACHED":
               errorMessage = "${room.error.max_bots}";
               break;
            case "RSEME_SELECTED_TILE_NOT_FREE_FOR_BOT":
               errorMessage = "${room.error.bots.selected_tile_not_free}";
               break;
            case "RSEME_BOT_NAME_NOT_ACCEPTED":
               errorMessage = "${room.error.bots.name.not.accepted}";
               break;
            default:
               return;
         }
         _windowManager.alert(errorTitle,errorMessage,0,function(param1:class_1750, param2:class_1758):void
         {
            param1.dispose();
         });
      }
      
      private function interstitialShowEventHandler(param1:InterstitialEvent) : void
      {
         if(var_22 != null)
         {
            var_22.processEvent(param1);
         }
         var_509 = true;
      }
      
      public function triggerbottomBarResize() : void
      {
         bottomBarResizeHandler(new FriendBarResizeEvent());
      }
      
      private function bottomBarResizeHandler(param1:FriendBarResizeEvent) : void
      {
         if(var_22 != null)
         {
            var_22.processEvent(param1);
         }
      }
      
      private function interstitialNotAvailableEventHandler(param1:InterstitialEvent) : void
      {
         var_509 = false;
      }
      
      private function interstitialCompleteEventHandler(param1:InterstitialEvent) : void
      {
         var_509 = false;
         if(param1.status == "complete")
         {
            _communication.connection.send(new class_1774());
         }
         if(var_22 != null)
         {
            var_22.processEvent(param1);
            var _loc2_:IRoomSession = _roomSessionManager.getSession(_roomEngine.activeRoomId);
         }
      }
      
      private function adEventHandler(param1:AdEvent) : void
      {
         if(var_22 != null)
         {
            var_22.processEvent(param1);
         }
      }
      
      private function onPerkAllowances(param1:class_2121) : void
      {
         var _loc2_:Timer = null;
         if(_freeFlowChat && !_freeFlowChat.isDisabledInPreferences && _isInRoom && !var_3026)
         {
            _loc2_ = new Timer(250,1);
            _loc2_.addEventListener("timerComplete",delayedAddToStageFreeFlowChat);
            _loc2_.start();
         }
         if(_isInRoom)
         {
            if(var_22 != null)
            {
               var_22.processEvent(new RoomDesktopMouseZoomEnableEvent(param1.getParser().isPerkAllowed("MOUSE_ZOOM")));
            }
         }
      }
      
      private function delayedAddToStageFreeFlowChat(param1:TimerEvent) : void
      {
         if(var_22 && _freeFlowChat.displayObject)
         {
            var_22.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
            var_3026 = true;
         }
      }
      
      private function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:IRoomSession = null;
         if(param1.type == "REE_GAME_MODE" || param1.type == "REE_NORMAL_MODE")
         {
            if(var_22 != null)
            {
               var_22.roomEngineEventHandler(param1);
            }
         }
         if(param1.roomId == var_3757)
         {
            if(param1.type == "REE_OBJECTS_INITIALIZED")
            {
               if(var_509)
               {
                  _loc2_ = _roomSessionManager.getSession(var_3757);
                  if(_loc2_ != null)
                  {
                     _loc2_.sendAvatarExpressionMessage(AvatarExpressionEnum.const_19.ordinal);
                  }
               }
               var_509 = false;
            }
            else if(param1.type == "REE_DISPOSED")
            {
               var_509 = false;
            }
         }
      }
      
      private function roomEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:int = 0;
         if(_roomEngine == null)
         {
            return;
         }
         if(var_22 == null)
         {
            if(_roomSessionManager == null)
            {
               return;
            }
            var _loc4_:IRoomSession = _roomSessionManager.getSession(param1.roomId);
            if(_loc4_ != null)
            {
               createDesktop(null);
            }
         }
         if(var_22 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "REE_INITIALIZED":
               _loc2_ = getActiveCanvasId(param1.roomId);
               var_22.createRoomView(_loc2_);
               if(_roomEngine != null && !RoomId.isRoomPreviewerId(param1.roomId))
               {
                  _roomEngine.setActiveRoom(param1.roomId);
                  var_22.initCameraLocation(_loc2_);
               }
               createDesktopWidget("RWE_CHAT_WIDGET");
               if(_freeFlowChat && !_freeFlowChat.isDisabledInPreferences)
               {
                  var_3026 = true;
                  if(_freeFlowChat.displayObject != null)
                  {
                     var_22.layoutManager.getChatContainer().setDisplayObject(_freeFlowChat.displayObject);
                  }
               }
               createDesktopWidget("RWE_INFOSTAND");
               createDesktopWidget("RWE_LOCATION_WIDGET");
               createDesktopWidget("RWE_ROOM_TOOLS");
               if(!var_22.session.isSpectatorMode)
               {
                  createDesktopWidget("RWE_ME_MENU");
                  createDesktopWidget("RWE_CHAT_INPUT_WIDGET");
                  createDesktopWidget("RWE_FRIEND_REQUEST");
                  if(getBoolean("avatar.widget.enabled"))
                  {
                     createDesktopWidget("RWE_AVATAR_INFO");
                  }
               }
               createDesktopWidget("RWE_FURNI_PLACEHOLDER");
               createDesktopWidget("RWE_FURNI_CREDIT_WIDGET");
               createDesktopWidget("RWE_FURNI_STICKIE_WIDGET");
               createDesktopWidget("RWE_FURNI_PRESENT_WIDGET");
               createDesktopWidget("RWE_FURNI_TROPHY_WIDGET");
               createDesktopWidget("RWE_FURNI_ECOTRONBOX_WIDGET");
               createDesktopWidget("RWE_FURNI_PET_PACKAGE_WIDGET");
               createDesktopWidget("RWE_DOORBELL");
               createDesktopWidget("RWE_ROOM_POLL");
               createDesktopWidget("RWE_ROOM_DIMMER");
               createDesktopWidget("RWE_CLOTHING_CHANGE");
               createDesktopWidget("RWE_CONVERSION_TRACKING");
               if(!getBoolean("memenu.effects.widget.disabled"))
               {
                  createDesktopWidget("RWE_EFFECTS");
               }
               createDesktopWidget("RWE_MANNEQUIN");
               createDesktopWidget("RWE_ROOM_BACKGROUND_COLOR");
               createDesktopWidget("RWE_AREA_HIDE");
               createDesktopWidget("RWE_CUSTOM_USER_NOTIFICATION");
               createDesktopWidget("RWE_FURNI_CHOOSER");
               createDesktopWidget("RWE_USER_CHOOSER");
               createDesktopWidget("RWE_PLAYLIST_EDITOR_WIDGET");
               createDesktopWidget("RWE_SPAMWALL_POSTIT_WIDGET");
               createDesktopWidget("RWE_FURNITURE_CONTEXT_MENU");
               createDesktopWidget("RWE_CAMERA");
               createDesktopWidget("RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING");
               createDesktopWidget("RWE_FRIEND_FURNI_CONFIRM");
               createDesktopWidget("RWE_FRIEND_FURNI_ENGRAVING");
               createDesktopWidget("RWE_HIGH_SCORE_DISPLAY");
               createDesktopWidget("RWE_INTERNAL_LINK");
               createDesktopWidget("RWE_CUSTOM_STACK_HEIGHT");
               createDesktopWidget("RWE_YOUTUBE");
               createDesktopWidget("RWE_RENTABLESPACE");
               createDesktopWidget("RWE_VIMEO");
               createDesktopWidget("RWE_EXTERNAL_IMAGE");
               createDesktopWidget("RWE_UI_HELP_BUBBLE");
               createDesktopWidget("RWE_WORD_QUIZZ");
               createDesktopWidget("RWE_ROOM_THUMBNAIL_CAMERA");
               createDesktopWidget("RWE_ROOM_LINK");
               createDesktopWidget("RWE_CRAFTING");
               _isInRoom = true;
               break;
            case "REE_ENTRANCE_AFTER_SPECTATE":
               desktop.enterAfterSpectate();
               desktop.disposeWidget("RWE_ROOM_QUEUE");
               desktop.createWidget("RWE_ME_MENU");
               desktop.createWidget("RWE_CHAT_INPUT_WIDGET");
               desktop.createWidget("RWE_FRIEND_REQUEST");
               if(getBoolean("avatar.widget.enabled"))
               {
                  desktop.createWidget("RWE_AVATAR_INFO");
               }
               break;
            case "REE_DISPOSED":
               disposeDesktop();
               _isInRoom = false;
               break;
            case "REE_ROOM_COLOR":
               var _loc5_:RoomEngineRoomColorEvent = param1 as RoomEngineRoomColorEvent;
               if(_loc5_ != null)
               {
                  if(null.bgOnly)
                  {
                     var_22.setRoomViewColor(16777215,255);
                     break;
                  }
                  var_22.setRoomViewColor(null.color,null.brightness);
               }
               break;
            case "REE_ROOM_ZOOM":
               var _loc3_:RoomEngineZoomEvent = param1 as RoomEngineZoomEvent;
               break;
            case "REDSE_ROOM_COLOR":
               var_22.processEvent(param1);
               break;
            case "ROHSLCEE_ROOM_BACKGROUND_COLOR":
               var _loc6_:RoomEngineHSLColorEnableEvent = RoomEngineHSLColorEnableEvent(param1);
               if(!_loc6_.enable)
               {
                  var_22.setRoomBackgroundColor(0,0,0);
                  break;
               }
               var_22.setRoomBackgroundColor(null.hue,null.saturation,null.lightness);
         }
      }
      
      private function createDesktopWidget(param1:String) : void
      {
         if(var_22 == null)
         {
            return;
         }
         var _loc4_:Boolean = false;
         var _loc3_:IRoomWidget = null;
         if(var_4627.indexOf(param1) != -1)
         {
            _loc4_ = true;
            _loc3_ = var_1358[param1];
         }
         var _loc2_:IRoomWidget = var_22.createWidget(param1,_loc4_,_loc3_);
         if(_loc4_ && _loc3_ == null && _loc2_ != null)
         {
            var_1358[param1] = _loc2_;
         }
      }
      
      private function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         if(_roomEngine == null)
         {
            return;
         }
         if(var_22 != null)
         {
            var_22.roomObjectEventHandler(param1);
         }
      }
      
      private function gameEventHandler(param1:Event) : void
      {
         if(var_22)
         {
            var_22.processEvent(param1);
         }
      }
      
      public function createDesktop(param1:IRoomSession) : IRoomDesktop
      {
         if(disposed || param1 == null)
         {
            return null;
         }
         if(_roomEngine == null)
         {
            return null;
         }
         if(var_22 != null)
         {
            return var_22;
         }
         var_22 = new RoomDesktop(param1,assets,_communication.connection);
         var_22.roomEngine = _roomEngine;
         var_22.windowManager = _windowManager;
         var_22.roomWidgetFactory = var_1797;
         var_22.sessionDataManager = _sessionDataManager;
         var_22.roomSessionManager = _roomSessionManager;
         var_22.communicationManager = _communication;
         var_22.friendList = _friendList;
         var_22.avatarRenderManager = _avatarRenderManager;
         var_22.inventory = _inventory;
         var_22.messenger = _messenger;
         var_22.toolbar = _toolbar;
         var_22.navigator = _newNavigator.legacyNavigator;
         var_22.habboGroupsManager = _habboGroupsManager;
         var_22.avatarEditor = _avatarEditor;
         var_22.catalog = _catalog;
         var_22.adManager = _adManager;
         var_22.localization = _localization;
         var_22.habboHelp = _habboHelp;
         var_22.moderation = _moderation;
         var_22.config = this;
         var_22.soundManager = _soundManager;
         var_22.habboTracking = _habboTracking;
         var_22.userDefinedRoomEvents = _userDefinedRoomEvents;
         var_22.gameManager = _gameManager;
         var_22.questEngine = _questEngine;
         var_22.freeFlowChat = _freeFlowChat;
         var _loc2_:XmlAsset = assets.getAssetByName("room_desktop_layout_xml") as XmlAsset;
         if(_loc2_ != null)
         {
            var_22.layout = _loc2_.content as XML;
         }
         createDesktopWidget("RWE_LOADINGBAR");
         createDesktopWidget("RWE_ROOM_QUEUE");
         var_22.init();
         var_22.requestInterstitial();
         var_509 = false;
         var_3757 = param1.roomId;
         return var_22;
      }
      
      public function get chatContainer() : class_1970
      {
         if(!var_22 || !var_22.layoutManager)
         {
            return null;
         }
         return var_22.layoutManager.getChatContainer();
      }
      
      public function disposeDesktop() : void
      {
         var _loc1_:int = 0;
         if(var_22 != null)
         {
            _loc1_ = var_22.getWidgetState("RWE_USER_CHOOSER");
            if(_loc1_ != -1)
            {
               var_5263 = _loc1_;
            }
            var_22.dispose();
            var_22 = null;
            var_509 = false;
         }
      }
      
      public function getActiveCanvasId(param1:int) : int
      {
         return 1;
      }
      
      public function update(param1:uint) : void
      {
         if(var_22 != null)
         {
            var_22.update();
         }
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_22 != null)
         {
            var_22.visible = param1;
         }
      }
      
      public function hideWidget(param1:String) : void
      {
         if(var_22 != null)
         {
            var_22.processEvent(new HideRoomWidgetEvent(param1));
         }
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         if(var_22 != null)
         {
            var_22.showGamePlayerName(param1,param2,param3,param4);
         }
      }
      
      public function mouseEventPositionHasContextMenu(param1:MouseEvent) : Boolean
      {
         if(var_22 != null)
         {
            return var_22.mouseEventPositionHasInputEventWindow(param1,0);
         }
         return false;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents
      {
         return _userDefinedRoomEvents;
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function get habboTracking() : class_53
      {
         return _habboTracking;
      }
      
      public function get habboGroupsManager() : class_140
      {
         return _habboGroupsManager;
      }
      
      public function get friendBarView() : class_1962
      {
         return _friendBarView;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get chatStyleLibrary() : class_2244
      {
         if(_freeFlowChat)
         {
            return _freeFlowChat.chatStyleLibrary;
         }
         return null;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get desktop() : IRoomDesktop
      {
         return var_22;
      }
   }
}

