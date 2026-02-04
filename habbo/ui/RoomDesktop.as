package com.sulake.habbo.ui
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.events.EventDispatcherWrapper;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IToolTipWindow;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.advertisement.class_56;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.groups.class_140;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.messenger.class_46;
   import com.sulake.habbo.moderation.IHabboModeration;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectPlacedEvent;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.handler.*;
   import com.sulake.habbo.ui.widget.IRoomWidget;
   import com.sulake.habbo.ui.widget.IRoomWidgetMessageListener;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.avatarinfo.AvatarInfoWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetLoadingBarUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotForceOpenContextMenuEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRentableBotSkillListUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomEngineUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectPlaceEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomViewUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetFurniToWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.events.RoomContentLoadedEvent;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.ColorTransitioner;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.BitmapFilter;
   import flash.filters.BlurFilter;
   import flash.filters.DisplacementMapFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import package_110.class_2388;
   import package_110.class_2982;
   import package_184.class_3191;
   import package_184.class_3314;
   
   public class RoomDesktop implements IRoomDesktop, IRoomWidgetMessageListener, IRoomWidgetHandlerContainer
   {
      
      public static const STATE_UNDEFINED:int = -1;
      
      private static const RESIZE_UPDATE_TIMEOUT_MS:int = 1000;
      
      private static const SCALE_UPDATE_TIMEOUT_MS:int = 1000;
      
      private var name_1:EventDispatcherWrapper;
      
      private var _windowManager:class_38 = null;
      
      private var _roomEngine:IRoomEngine = null;
      
      private var var_1797:IRoomWidgetFactory = null;
      
      private var _sessionDataManager:ISessionDataManager = null;
      
      private var _roomSessionManager:IRoomSessionManager = null;
      
      private var _communicationManager:class_57 = null;
      
      private var _avatarRenderManager:class_48 = null;
      
      private var _friendList:class_258 = null;
      
      private var _inventory:class_61 = null;
      
      private var _toolbar:IHabboToolbar = null;
      
      private var _navigator:class_41 = null;
      
      private var _messenger:class_46 = null;
      
      private var _habboGroupsManager:class_140 = null;
      
      private var _avatarEditor:class_141 = null;
      
      private var _catalog:IHabboCatalog = null;
      
      private var _adManager:class_56 = null;
      
      private var _localization:class_27 = null;
      
      private var _habboHelp:IHabboHelp = null;
      
      private var var_37:IConnection = null;
      
      private var _moderation:IHabboModeration;
      
      private var _config:class_16;
      
      private var _soundManager:class_544;
      
      private var _habboTracking:class_53;
      
      private var _userDefinedRoomEvents:IHabboUserDefinedRoomEvents;
      
      private var _gameManager:class_45;
      
      private var _questEngine:class_498;
      
      private var _freeFlowChat:class_51;
      
      private var _assets:class_40 = null;
      
      private var var_70:IRoomSession = null;
      
      private var var_521:Array = [];
      
      private var var_35:class_55;
      
      private var var_1411:class_55;
      
      private var var_1144:class_55;
      
      private var _updateListeners:Array;
      
      private var var_271:class_3019;
      
      private var var_174:class_1970;
      
      private var var_2769:Boolean = true;
      
      private var var_1610:Array;
      
      private var var_386:IToolTipWindow;
      
      private var var_1443:ColorTransitioner = null;
      
      private var _roomColor:uint = 16777215;
      
      private var var_5326:Boolean = false;
      
      private var _zoomChangedMillis:int = 0;
      
      private var var_1465:ColorTransitioner = null;
      
      private var _roomBackgroundColor:uint = 0;
      
      private var var_908:Timer;
      
      private var var_2794:Rectangle;
      
      private var var_1632:IMessageEvent;
      
      private var var_1608:IMessageEvent;
      
      private var var_1605:Point;
      
      private var var_1862:Number = 0;
      
      private var var_1627:Number = 0;
      
      private var var_2960:Boolean;
      
      public function RoomDesktop(param1:IRoomSession, param2:class_40, param3:IConnection)
      {
         super();
         name_1 = new EventDispatcherWrapper();
         var_70 = param1;
         _assets = param2;
         var_37 = param3;
         var_1632 = new class_2982(onBotSkillListUpdateEvent);
         var_37.addMessageEvent(var_1632);
         var_1608 = new class_2388(onBotForceOpenContextMenuEvent);
         var_37.addMessageEvent(var_1608);
         var_35 = new class_55();
         var_1411 = new class_55();
         var_1144 = new class_55();
         var_271 = new class_3019();
         checkInterrupts();
         var_1443 = new ColorTransitioner();
         var_1465 = new ColorTransitioner(0,0);
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(var_174)
         {
            var_174.visible = param1;
         }
      }
      
      public function get roomSession() : IRoomSession
      {
         return var_70;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get events() : IEventDispatcher
      {
         return name_1;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get friendList() : class_258
      {
         return _friendList;
      }
      
      public function get avatarRenderManager() : class_48
      {
         return _avatarRenderManager;
      }
      
      public function get inventory() : class_61
      {
         return _inventory && !_inventory.disposed ? _inventory : null;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get roomWidgetFactory() : IRoomWidgetFactory
      {
         return var_1797;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get habboGroupsManager() : class_140
      {
         return _habboGroupsManager;
      }
      
      public function get communicationManager() : class_57
      {
         return _communicationManager;
      }
      
      public function get avatarEditor() : class_141
      {
         return _avatarEditor;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get habboHelp() : IHabboHelp
      {
         return _habboHelp;
      }
      
      public function get config() : class_16
      {
         return _config;
      }
      
      public function get soundManager() : class_544
      {
         return _soundManager;
      }
      
      public function get messenger() : class_46
      {
         return _messenger;
      }
      
      public function get moderation() : IHabboModeration
      {
         return _moderation;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get habboTracking() : class_53
      {
         return _habboTracking;
      }
      
      public function get session() : IRoomSession
      {
         return var_70;
      }
      
      public function get gameManager() : class_45
      {
         return _gameManager;
      }
      
      public function get questEngine() : class_498
      {
         return _questEngine;
      }
      
      public function get freeFlowChat() : class_51
      {
         return _freeFlowChat;
      }
      
      public function get roomBackgroundColor() : uint
      {
         return _roomBackgroundColor;
      }
      
      public function set catalog(param1:IHabboCatalog) : void
      {
         _catalog = param1;
      }
      
      public function set avatarEditor(param1:class_141) : void
      {
         _avatarEditor = param1;
      }
      
      public function set roomWidgetFactory(param1:IRoomWidgetFactory) : void
      {
         var_1797 = param1;
      }
      
      public function set sessionDataManager(param1:ISessionDataManager) : void
      {
         _sessionDataManager = param1;
      }
      
      public function set roomSessionManager(param1:IRoomSessionManager) : void
      {
         _roomSessionManager = param1;
         checkInterrupts();
      }
      
      public function set communicationManager(param1:class_57) : void
      {
         _communicationManager = param1;
      }
      
      public function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents
      {
         return _userDefinedRoomEvents;
      }
      
      public function get connection() : IConnection
      {
         return var_37;
      }
      
      public function set friendList(param1:class_258) : void
      {
         _friendList = param1;
         if(_friendList)
         {
            _friendList.events.addEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.addEventListener("FRE_DECLINED",processEvent);
         }
      }
      
      public function set avatarRenderManager(param1:class_48) : void
      {
         _avatarRenderManager = param1;
      }
      
      public function set windowManager(param1:class_38) : void
      {
         _windowManager = param1;
      }
      
      public function set inventory(param1:class_61) : void
      {
         _inventory = param1;
      }
      
      public function set navigator(param1:class_41) : void
      {
         _navigator = param1;
      }
      
      public function set adManager(param1:class_56) : void
      {
         _adManager = param1;
      }
      
      public function set localization(param1:class_27) : void
      {
         _localization = param1;
      }
      
      public function set habboHelp(param1:IHabboHelp) : void
      {
         _habboHelp = param1;
      }
      
      public function set moderation(param1:IHabboModeration) : void
      {
         _moderation = param1;
      }
      
      public function set config(param1:class_16) : void
      {
         _config = param1;
      }
      
      public function set soundManager(param1:class_544) : void
      {
         _soundManager = param1;
      }
      
      public function set habboTracking(param1:class_53) : void
      {
         _habboTracking = param1;
      }
      
      public function set userDefinedRoomEvents(param1:IHabboUserDefinedRoomEvents) : void
      {
         _userDefinedRoomEvents = param1;
      }
      
      public function set gameManager(param1:class_45) : void
      {
         _gameManager = param1;
      }
      
      public function set questEngine(param1:class_498) : void
      {
         _questEngine = param1;
      }
      
      public function set freeFlowChat(param1:class_51) : void
      {
         _freeFlowChat = param1;
      }
      
      public function set habboGroupsManager(param1:class_140) : void
      {
         _habboGroupsManager = param1;
      }
      
      public function set roomEngine(param1:IRoomEngine) : void
      {
         _roomEngine = param1;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.addEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
      }
      
      public function set messenger(param1:class_46) : void
      {
         _messenger = param1;
      }
      
      public function set toolbar(param1:IHabboToolbar) : void
      {
         _toolbar = param1;
         _toolbar.events.addEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
      }
      
      public function set layout(param1:XML) : void
      {
         var_271.setLayout(param1,_windowManager,_config);
      }
      
      public function dispose() : void
      {
         var _loc5_:IRoomGeometry = null;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         if(_roomEngine != null && var_70 != null)
         {
            _loc5_ = _roomEngine.getRoomCanvasGeometry(var_70.roomId,getFirstCanvasId());
            if(_loc5_ != null)
            {
               trackZooming(_loc5_.isZoomedIn(),false);
            }
         }
         var _loc2_:int = 0;
         if(var_521 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_521.length)
            {
               _loc4_ = int(var_521[_loc2_]);
               _loc3_ = getWindowName(_loc4_);
               if(_windowManager)
               {
                  _windowManager.removeWindow(_loc3_);
               }
               _loc2_++;
            }
         }
         _updateListeners = null;
         if(var_35 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_35.length)
            {
               var _loc1_:IRoomWidget = var_35.getWithIndex(_loc2_) as IRoomWidget;
               _loc2_++;
            }
            var_35.dispose();
            var_35 = null;
         }
         if(var_1411 != null)
         {
            var_1411.dispose();
            var_1411 = null;
         }
         if(var_1144 != null)
         {
            var_1144.dispose();
            var_1144 = null;
         }
         if(var_37)
         {
            if(var_1632 != null)
            {
               var_37.removeMessageEvent(var_1632);
               var_1632.dispose();
               var_1632 = null;
            }
            if(var_1608 != null)
            {
               var_37.removeMessageEvent(var_1608);
               var_1608.dispose();
               var_1608 = null;
            }
            var_37 = null;
         }
         _assets = null;
         _avatarRenderManager = null;
         var_521 = null;
         name_1 = null;
         if(_friendList && _friendList.events)
         {
            _friendList.events.removeEventListener("FRE_ACCEPTED",processEvent);
            _friendList.events.removeEventListener("FRE_DECLINED",processEvent);
         }
         _friendList = null;
         var_271.dispose();
         var_271 = null;
         if(_roomEngine != null && _roomEngine.events != null)
         {
            _roomEngine.events.removeEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_FAILURE",onRoomContentLoaded);
            _roomEngine.events.removeEventListener("RCLE_CANCEL",onRoomContentLoaded);
         }
         _roomEngine = null;
         _roomSessionManager = null;
         var_1797 = null;
         var_70 = null;
         _sessionDataManager = null;
         _windowManager = null;
         _inventory = null;
         _localization = null;
         _config = null;
         _soundManager = null;
         _habboGroupsManager = null;
         if(_toolbar && toolbar.events)
         {
            _toolbar.events.removeEventListener("HTIE_ICON_ZOOM",onToolbarEvent);
            _toolbar = null;
         }
         _navigator = null;
         if(var_386 != null)
         {
            var_386.dispose();
            var_386 = null;
         }
         if(var_908 != null)
         {
            var_908.reset();
            var_908.removeEventListener("timer",onResizeTimerEvent);
            var_908 = null;
         }
         var_2794 = null;
         var_1443 = null;
         var_1465 = null;
      }
      
      private function onBotSkillListUpdateEvent(param1:class_2982) : void
      {
         var _loc3_:class_3191 = param1.getParser();
         if(var_70 != null)
         {
            var _loc2_:class_2146 = var_70.userDataManager.getRentableBotUserData(_loc3_.botId);
            null.botSkillData = param1.getParser().skillList.concat();
         }
         events.dispatchEvent(new RoomWidgetRentableBotSkillListUpdateEvent(_loc3_.botId,_loc3_.skillList));
      }
      
      private function onBotForceOpenContextMenuEvent(param1:class_2388) : void
      {
         var _loc2_:class_3314 = param1.getParser();
         events.dispatchEvent(new RoomWidgetRentableBotForceOpenContextMenuEvent(_loc2_.botId));
      }
      
      public function init() : void
      {
         if(_roomEngine != null && var_70 != null)
         {
            var_1610 = [];
            if(var_1610.length > 0)
            {
               var_2769 = false;
               processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUE_SHOW_LOADING_BAR"));
            }
         }
      }
      
      public function requestInterstitial() : void
      {
         if(_adManager != null)
         {
            _adManager.showInterstitial();
         }
      }
      
      private function onRoomContentLoaded(param1:RoomContentLoadedEvent) : void
      {
         if(var_1610 == null || var_1610.length == 0)
         {
            return;
         }
         var _loc2_:int = int(var_1610.indexOf(param1.contentType));
         if(_loc2_ != -1)
         {
            var_1610.splice(_loc2_,1);
         }
         if(var_1610.length == 0)
         {
            var_2769 = true;
            checkInterrupts();
         }
      }
      
      public function createWidget(param1:String, param2:Boolean = false, param3:IRoomWidget = null) : IRoomWidget
      {
         var _loc4_:IRoomWidgetHandler = null;
         var _loc9_:ChatWidgetHandler = null;
         var _loc21_:PlayListEditorWidgetHandler = null;
         var _loc5_:SpamWallPostItWidgetHandler = null;
         var _loc8_:FurnitureContextMenuWidgetHandler = null;
         var _loc16_:FurnitureRoomLinkHandler = null;
         var _loc10_:RoomToolsWidgetHandler = null;
         var _loc22_:RoomWidgetBase = null;
         var _loc6_:FurnitureRoomLinkHandler = null;
         var _loc15_:ChatWidgetHandler = null;
         var _loc14_:FurnitureContextMenuWidgetHandler = null;
         var _loc12_:RoomToolsWidgetHandler = null;
         var _loc18_:Array = null;
         var _loc19_:Array = null;
         var _loc23_:Array = null;
         var _loc17_:RoomWidgetRoomViewUpdateEvent = null;
         if(var_1797 == null)
         {
            return null;
         }
         var _loc7_:IRoomWidget = var_35.getValue(param1) as IRoomWidget;
         if(_loc7_ != null)
         {
            return null;
         }
         if(var_70.isGameSession && !isGameWidget(param1))
         {
            return null;
         }
         var _loc11_:Boolean = param1 == "RWE_CHAT_INPUT_WIDGET" || param1 == "RWE_CHAT_WIDGET";
         if(param3 == null)
         {
            switch(param1)
            {
               case "RWE_CHAT_WIDGET":
                  _loc9_ = new ChatWidgetHandler();
                  _loc9_.connection = var_37;
                  _loc4_ = _loc9_;
                  break;
               case "RWE_INFOSTAND":
                  _loc4_ = new InfoStandWidgetHandler(_soundManager.musicController);
                  break;
               case "RWE_CHAT_INPUT_WIDGET":
                  _loc4_ = new ChatInputWidgetHandler();
                  break;
               case "RWE_ME_MENU":
                  _loc4_ = new MeMenuWidgetHandler();
                  break;
               case "RWE_FURNI_PLACEHOLDER":
                  _loc4_ = new PlaceholderWidgetHandler();
                  break;
               case "RWE_FURNI_CREDIT_WIDGET":
                  _loc4_ = new FurnitureCreditWidgetHandler();
                  break;
               case "RWE_FURNI_STICKIE_WIDGET":
                  _loc4_ = new FurnitureStickieWidgetHandler();
                  break;
               case "RWE_FURNI_PRESENT_WIDGET":
                  _loc4_ = new FurniturePresentWidgetHandler();
                  break;
               case "RWE_FURNI_TROPHY_WIDGET":
                  _loc4_ = new FurnitureTrophyWidgetHandler();
                  break;
               case "RWE_FURNI_ECOTRONBOX_WIDGET":
                  _loc4_ = new FurnitureEcotronBoxWidgetHandler();
                  break;
               case "RWE_FURNI_PET_PACKAGE_WIDGET":
                  _loc4_ = new PetPackageFurniWidgetHandler();
                  break;
               case "RWE_DOORBELL":
                  _loc4_ = new DoorbellWidgetHandler();
                  break;
               case "RWE_ROOM_QUEUE":
                  _loc4_ = new RoomQueueWidgetHandler();
                  break;
               case "RWE_LOADINGBAR":
                  _loc4_ = new LoadingBarWidgetHandler();
                  break;
               case "RWE_ROOM_POLL":
                  _loc4_ = new PollWidgetHandler();
                  break;
               case "RWE_WORD_QUIZZ":
                  _loc4_ = new WordQuizWidgetHandler();
                  break;
               case "RWE_FURNI_CHOOSER":
                  _loc4_ = new FurniChooserWidgetHandler();
                  break;
               case "RWE_USER_CHOOSER":
                  _loc4_ = new UserChooserWidgetHandler();
                  break;
               case "RWE_ROOM_DIMMER":
                  _loc4_ = new FurnitureDimmerWidgetHandler();
                  break;
               case "RWE_FRIEND_REQUEST":
                  _loc4_ = new FriendRequestWidgetHandler();
                  break;
               case "RWE_CLOTHING_CHANGE":
                  _loc4_ = new FurnitureClothingChangeWidgetHandler();
                  break;
               case "RWE_CONVERSION_TRACKING":
                  _loc4_ = new ConversionPointWidgetHandler();
                  break;
               case "RWE_AVATAR_INFO":
                  _loc4_ = new AvatarInfoWidgetHandler();
                  break;
               case "RWE_PLAYLIST_EDITOR_WIDGET":
                  _loc21_ = new PlayListEditorWidgetHandler();
                  _loc21_.connection = var_37;
                  _loc4_ = _loc21_ as IRoomWidgetHandler;
                  break;
               case "RWE_SPAMWALL_POSTIT_WIDGET":
                  _loc5_ = new SpamWallPostItWidgetHandler();
                  _loc5_.connection = var_37;
                  _loc4_ = _loc5_ as IRoomWidgetHandler;
                  break;
               case "RWE_EFFECTS":
                  _loc4_ = new class_3487();
                  break;
               case "RWE_MANNEQUIN":
                  _loc4_ = new MannequinWidgetHandler();
                  break;
               case "RWE_FURNITURE_CONTEXT_MENU":
                  _loc8_ = new FurnitureContextMenuWidgetHandler();
                  _loc8_.connection = var_37;
                  _loc4_ = _loc8_ as IRoomWidgetHandler;
                  break;
               case "RWE_LOCATION_WIDGET":
                  _loc4_ = new ObjectLocationRequestHandler();
                  break;
               case "RWE_CAMERA":
                  _loc4_ = new CameraWidgetHandler(this);
                  break;
               case "RWE_ROOM_BACKGROUND_COLOR":
                  _loc4_ = new FurnitureBackgroundColorWidgetHandler();
                  break;
               case "RWE_AREA_HIDE":
                  _loc4_ = new FurnitureAreaHideWidgetHandler();
                  break;
               case "RWE_CUSTOM_USER_NOTIFICATION":
                  _loc4_ = new CustomUserNotificationWidgetHandler();
                  break;
               case "RWE_FURNI_ACHIEVEMENT_RESOLUTION_ENGRAVING":
                  _loc4_ = new class_2736();
                  break;
               case "RWE_FRIEND_FURNI_CONFIRM":
                  _loc4_ = new class_3437();
                  class_3437(_loc4_).connection = connection;
                  break;
               case "RWE_FRIEND_FURNI_ENGRAVING":
                  _loc4_ = new class_2664();
                  break;
               case "RWE_HIGH_SCORE_DISPLAY":
                  _loc4_ = new class_2711();
                  break;
               case "RWE_INTERNAL_LINK":
                  _loc4_ = new class_2750();
                  break;
               case "RWE_ROOM_LINK":
                  _loc16_ = new FurnitureRoomLinkHandler();
                  _loc16_.communicationManager = _communicationManager;
                  _loc4_ = _loc16_;
                  break;
               case "RWE_CUSTOM_STACK_HEIGHT":
                  _loc4_ = new class_2833();
                  break;
               case "RWE_YOUTUBE":
                  _loc4_ = new class_2671();
                  break;
               case "RWE_RENTABLESPACE":
                  _loc4_ = new class_2656();
                  break;
               case "RWE_VIMEO":
                  _loc4_ = new class_3409();
                  break;
               case "RWE_ROOM_TOOLS":
                  _loc10_ = new RoomToolsWidgetHandler();
                  _loc10_.communicationManager = _communicationManager;
                  _loc10_.navigator = _navigator;
                  _loc4_ = _loc10_;
                  break;
               case "RWE_EXTERNAL_IMAGE":
                  _loc4_ = new ExternalImageWidgetHandler();
                  break;
               case "RWE_UI_HELP_BUBBLE":
                  _loc4_ = new UiHelpBubbleWidgetHandler();
                  break;
               case "RWE_ROOM_THUMBNAIL_CAMERA":
                  _loc4_ = new RoomThumbnailCameraWidgetHandler(this);
                  break;
               case "RWE_CRAFTING":
                  _loc4_ = new CraftingWidgetHandler(this);
            }
         }
         else
         {
            _loc22_ = param3 as RoomWidgetBase;
            if(_loc22_ != null)
            {
               _loc4_ = _loc22_.widgetHandler;
               _loc6_ = _loc4_ as FurnitureRoomLinkHandler;
               if(_loc6_ != null)
               {
                  _loc14_.connection = var_37;
               }
               _loc15_ = _loc4_ as ChatWidgetHandler;
               if(_loc15_ != null)
               {
                  _loc15_.connection = var_37;
               }
               _loc14_ = _loc4_ as FurnitureContextMenuWidgetHandler;
               if(_loc14_ != null)
               {
                  _loc14_.connection = var_37;
               }
               _loc12_ = _loc4_ as RoomToolsWidgetHandler;
               if(_loc12_ != null)
               {
                  _loc12_.communicationManager = _communicationManager;
                  _loc12_.navigator = _navigator;
               }
            }
         }
         if(_loc4_ != null)
         {
            _loc4_.container = this;
            _loc18_ = null;
            _loc19_ = _loc4_.getWidgetMessages();
            if(_loc19_ != null)
            {
               for each(var _loc13_ in _loc19_)
               {
                  _loc18_ = var_1411.getValue(_loc13_);
                  if(_loc18_ == null)
                  {
                     _loc18_ = [];
                     var_1411.add(_loc13_,_loc18_);
                  }
                  _loc18_.push(_loc4_);
               }
            }
            _loc23_ = _loc4_.getProcessedEvents();
            if(_loc23_ != null)
            {
               _loc23_.push("RETWE_OPEN_WIDGET");
               _loc23_.push("RETWE_CLOSE_WIDGET");
               for each(var _loc20_ in _loc23_)
               {
                  _loc18_ = var_1144.getValue(_loc20_);
                  if(_loc18_ == null)
                  {
                     _loc18_ = [];
                     var_1144.add(_loc20_,_loc18_);
                  }
                  _loc18_.push(_loc4_);
               }
            }
         }
         _loc7_ = param3 == null ? var_1797.createWidget(param1,_loc4_) : param3;
         if(_loc7_ == null)
         {
            return null;
         }
         _loc7_.messageListener = this;
         _loc7_.registerUpdateEvents(name_1);
         _loc7_.reusable = param2;
         _loc7_.widgetType = param1;
         if(!var_35.add(param1,_loc7_))
         {
            if(param3 == null)
            {
               _loc7_.dispose();
            }
            else
            {
               param3.release();
            }
         }
         else
         {
            if(param3 != null)
            {
               param3.reuse(this);
            }
            var_271.addWidgetWindow(param1,_loc7_.mainWindow);
         }
         if(_loc11_)
         {
            param1 = "RWRVUE_ROOM_VIEW_SIZE_CHANGED";
            _loc17_ = new RoomWidgetRoomViewUpdateEvent(param1,var_271.roomViewRect);
            this.events.dispatchEvent(_loc17_);
         }
         return _loc7_;
      }
      
      private function isGameWidget(param1:String) : Boolean
      {
         switch(param1)
         {
            case "RWE_CHAT_INPUT_WIDGET":
            case "RWE_CHAT_WIDGET":
            case "RWE_AVATAR_INFO":
            case "RWE_LOCATION_WIDGET":
               return true;
            default:
               return false;
         }
      }
      
      public function disposeWidget(param1:String) : void
      {
         if(var_35 != null)
         {
            var _loc2_:IRoomWidget = var_35.remove(param1);
         }
      }
      
      public function getWidget(param1:String) : IRoomWidget
      {
         if(var_35 != null)
         {
            var _loc2_:IRoomWidget = var_35[param1];
         }
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc4_:RoomWidgetUpdateEvent = null;
         if(param1 == null)
         {
            return null;
         }
         if(param1.type == "RWZTM_ZOOM_TOGGLE")
         {
            toggleZoom();
         }
         var _loc3_:Array = var_1411.getValue(param1.type);
         if(_loc3_ != null)
         {
            for each(var _loc2_ in _loc3_)
            {
               _loc4_ = _loc2_.processWidgetMessage(param1);
               if(_loc4_ != null)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc3_:Boolean = false;
         var _loc5_:RoomEngineToWidgetEvent = null;
         if(!param1 || !var_1144)
         {
            return;
         }
         if(var_174 && param1.type == "RDMZEE_ENABLED")
         {
            checkAndEnableMouseZoomEvent(var_174.getDisplayObject());
         }
         var _loc4_:Array = var_1144.getValue(param1.type);
         if(_loc4_ != null)
         {
            for each(var _loc2_ in _loc4_)
            {
               _loc3_ = true;
               if(param1.type == "RETWE_OPEN_WIDGET" || param1.type == "RETWE_CLOSE_WIDGET")
               {
                  _loc5_ = param1 as RoomEngineToWidgetEvent;
                  _loc3_ = _loc5_ != null && _loc2_.type == _loc5_.widget;
               }
               if(param1.type == "RWZTM_ZOOM_TOGGLE")
               {
                  toggleZoom();
               }
               if(_loc3_)
               {
                  _loc2_.processEvent(param1);
               }
            }
         }
      }
      
      private function isFurnitureSelectionDisabled(param1:RoomEngineObjectEvent) : Boolean
      {
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:Boolean = false;
         var _loc2_:IRoomObject = roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_.getModel();
            if(_loc4_ != null)
            {
               if(_loc4_.getNumber("furniture_selection_disable") == 1)
               {
                  _loc3_ = true;
                  if(_sessionDataManager.isAnyRoomController)
                  {
                     _loc3_ = false;
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function roomObjectEventHandler(param1:RoomEngineObjectEvent) : void
      {
         var _loc12_:class_2146 = null;
         if(param1 == null)
         {
            return;
         }
         var _loc10_:int = param1.objectId;
         var _loc11_:int = param1.category;
         switch(param1.type)
         {
            case "REOE_SELECTED":
               if(!isFurnitureSelectionDisabled(param1))
               {
                  var _loc8_:RoomWidgetRoomObjectUpdateEvent = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_SELECTED",_loc10_,_loc11_,param1.roomId);
               }
               if(_moderation != null && _loc11_ == 100)
               {
                  _loc12_ = var_70.userDataManager.getUserDataByIndex(_loc10_);
                  if(_loc12_ != null && _loc12_.type == 1)
                  {
                     _moderation.userSelected(_loc12_.webID,_loc12_.name);
                  }
               }
               break;
            case "REOE_PLACED":
               var _loc3_:RoomEngineObjectPlacedEvent = param1 as RoomEngineObjectPlacedEvent;
               _loc8_ = new RoomWidgetRoomObjectPlaceEvent("RWROUE_OBJECT_PLACED",_loc10_,_loc11_,param1.roomId,null.wallLocation,null.x,null.y,null.z,null.direction,null.placedInRoom,null.placedOnFloor,null.placedOnWall,null.instanceData,null.placementSource);
               break;
            case "REOE_ADDED":
               switch(_loc11_)
               {
                  case 10:
                  case 20:
                     var _loc4_:String = "RWROUE_FURNI_ADDED";
                     break;
                  case 100:
                     _loc4_ = "RWROUE_USER_ADDED";
               }
               break;
            case "REOE_REMOVED":
               switch(_loc11_)
               {
                  case 10:
                  case 20:
                     _loc4_ = "RWROUE_FURNI_REMOVED";
                     break;
                  case 100:
                     _loc4_ = "RWROUE_USER_REMOVED";
               }
               break;
            case "REOE_DESELECTED":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_DESELECTED",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_MOUSE_ENTER":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OVER",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_MOUSE_LEAVE":
               _loc8_ = new RoomWidgetRoomObjectUpdateEvent("RWROUE_OBJECT_ROLL_OUT",_loc10_,_loc11_,param1.roomId);
               break;
            case "REOE_REQUEST_MOVE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_MOVE");
               }
               break;
            case "REOE_REQUEST_ROTATE":
               if(checkFurniManipulationRights(param1.roomId,param1.objectId,param1.category))
               {
                  _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_ROTATE_POSITIVE");
               }
               break;
            case "REOE_REQUEST_PICKUP":
               _roomEngine.modifyRoomObject(param1.objectId,param1.category,"OBJECT_PICKUP");
               break;
            case "RETWE_REQUEST_CREDITFURNI":
               var _loc6_:RoomWidgetFurniToWidgetMessage = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CREDITFURNI",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_STICKIE":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_STICKIE",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_PRESENT":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PRESENT",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_TROPHY":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TROPHY",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_TEASER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_TEASER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_ECOTRONBOX":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_ECOTRONBOX",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_DIMMER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_DIMMER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_PLACEHOLDER":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLACEHOLDER",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RERAE_FURNI_CLICK":
            case "RERAE_FURNI_DOUBLE_CLICK":
               handleRoomAdClick(param1);
               break;
            case "RERAE_TOOLTIP_SHOW":
            case "RERAE_TOOLTIP_HIDE":
               handleRoomAdTooltip(param1);
               break;
            case "RETWE_REQUEST_CLOTHING_CHANGE":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_CLOTHING_CHANGE",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_PLAYLIST_EDITOR":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_MESSAGE_REQUEST_PLAYLIST_EDITOR",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_ENGRAVING",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_BADGE_DISPLAY_ENGRAVING":
               _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_BADGE_DISPLAY_ENGRAVING",_loc10_,_loc11_,param1.roomId);
               processWidgetMessage(null);
               break;
            case "RETWE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED":
               var _loc13_:IRoomObject = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
               if(_loc13_ != null)
               {
                  var _loc5_:int = int(null.getModel().getNumber("furniture_owner_id"));
                  var _loc9_:int = _sessionDataManager.userId;
                  _loc6_ = new RoomWidgetFurniToWidgetMessage("RWFWM_WIDGET_MESSAGE_REQUEST_ACHIEVEMENT_RESOLUTION_FAILED",_loc10_,_loc11_,param1.roomId);
                  processWidgetMessage(null);
               }
               break;
            case "RETWE_OPEN_WIDGET":
            case "RETWE_CLOSE_WIDGET":
            case "RETWE_OPEN_FURNI_CONTEXT_MENU":
            case "RETWE_CLOSE_FURNI_CONTEXT_MENU":
            case "RETWE_REMOVE_DIMMER":
            case "ROSM_JUKEBOX_DISPOSE":
            case "RETWE_REQUEST_MANNEQUIN":
            case "ROSM_USE_PRODUCT_FROM_INVENTORY":
            case "ROSM_USE_PRODUCT_FROM_ROOM":
            case "RETWE_REQUEST_BACKGROUND_COLOR":
            case "RETWE_REQUEST_AREA_HIDE":
            case "RETWE_UPDATE_STATE_AREA_HIDE":
            case "RETWE_REQUEST_FRIEND_FURNITURE_ENGRAVING":
            case "RETWE_REQUEST_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_HIDE_HIGH_SCORE_DISPLAY":
            case "RETWE_REQUEST_INTERNAL_LINK":
            case "RETWE_REQUEST_ROOM_LINK":
               processEvent(param1);
         }
      }
      
      private function checkFurniManipulationRights(param1:int, param2:int, param3:int) : Boolean
      {
         return var_70.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController || isOwnerOfFurniture(_roomEngine.getRoomObject(param1,param2,param3));
      }
      
      public function roomEngineEventHandler(param1:RoomEngineEvent) : void
      {
         var _loc2_:RoomWidgetUpdateEvent = null;
         switch(param1.type)
         {
            case "REE_NORMAL_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_NORMAL_MODE",param1.roomId);
               break;
            case "REE_GAME_MODE":
               _loc2_ = new RoomWidgetRoomEngineUpdateEvent("RWREUE_GAME_MODE",param1.roomId);
         }
         if(_loc2_ != null)
         {
            events.dispatchEvent(_loc2_);
         }
      }
      
      public function createRoomView(param1:int) : void
      {
         var _loc15_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc3_:Rectangle = var_271.roomViewRect;
         var _loc16_:int = _loc3_.width;
         var _loc22_:int = _loc3_.height;
         var _loc7_:int = var_70.isGameSession ? 32 : 64;
         if(var_521.indexOf(param1) >= 0)
         {
            return;
         }
         if(var_70 == null || _windowManager == null || _roomEngine == null)
         {
            return;
         }
         var _loc17_:DisplayObject = _roomEngine.createRoomCanvas(var_70.roomId,param1,_loc16_,_loc22_,_loc7_);
         if(_loc17_ == null)
         {
            return;
         }
         var _loc18_:RoomGeometry = _roomEngine.getRoomCanvasGeometry(var_70.roomId,param1) as RoomGeometry;
         if(_loc18_ != null)
         {
            _loc15_ = _roomEngine.getRoomNumberValue(var_70.roomId,"room_min_x");
            _loc5_ = _roomEngine.getRoomNumberValue(var_70.roomId,"room_max_x");
            _loc14_ = _roomEngine.getRoomNumberValue(var_70.roomId,"room_min_y");
            _loc4_ = _roomEngine.getRoomNumberValue(var_70.roomId,"room_max_y");
            _loc13_ = (_loc15_ + _loc5_) / 2;
            _loc10_ = (_loc14_ + _loc4_) / 2;
            _loc8_ = 20;
            _loc13_ += _loc8_ - 1;
            _loc10_ += _loc8_ - 1;
            _loc11_ = Math.sqrt(_loc8_ * _loc8_ + _loc8_ * _loc8_) * Math.tan(0.16666666666666666 * 3.141592653589793);
            _loc18_.location = new Vector3d(_loc13_,_loc10_,_loc11_);
         }
         var _loc20_:XmlAsset = _assets.getAssetByName("room_view_container_xml") as XmlAsset;
         if(_loc20_ == null)
         {
            return;
         }
         var _loc9_:class_1812 = _windowManager.buildFromXML(_loc20_.content as XML) as class_1812;
         if(_loc9_ == null)
         {
            return;
         }
         _loc9_.width = _loc16_;
         _loc9_.height = _loc22_;
         var_174 = _loc9_.findChildByName("room_canvas_wrapper") as class_1970;
         if(var_174 == null)
         {
            return;
         }
         var_174.setDisplayObject(_loc17_);
         if(var_70.isGameSession)
         {
            _loc17_.addEventListener("click",mouseEventHandler);
         }
         checkAndEnableMouseZoomEvent(_loc17_);
         var_174.addEventListener("WME_CLICK",canvasMouseHandler);
         var_174.addEventListener("WME_DOUBLE_CLICK",canvasMouseHandler);
         var_174.addEventListener("WME_MOVE",canvasMouseHandler);
         var_174.addEventListener("WME_DOWN",canvasMouseHandler);
         var_174.addEventListener("WME_UP",canvasMouseHandler);
         var_174.addEventListener("WME_UP_OUTSIDE",canvasMouseHandler);
         var_174.addEventListener("WE_RESIZED",onRoomViewResized);
         var _loc19_:Sprite = new Sprite();
         _loc19_.mouseEnabled = false;
         _loc19_.blendMode = "multiply";
         var _loc21_:class_1970 = _loc9_.findChildByName("colorizer_wrapper") as class_1970;
         if(_loc21_ == null)
         {
            return;
         }
         _loc21_.setDisplayObject(_loc19_);
         _loc21_.addEventListener("WE_RESIZED",resizeColorizer);
         var _loc2_:Sprite = new Sprite();
         _loc2_.mouseEnabled = false;
         var _loc12_:class_1970 = _loc9_.findChildByName("background_wrapper") as class_1970;
         if(_loc12_ == null)
         {
            return;
         }
         _loc12_.setDisplayObject(_loc2_);
         _loc12_.addEventListener("WE_RESIZED",resizeBackgroundColorizer);
         if(var_70.isSpectatorMode)
         {
            var _loc6_:class_1741 = getSpectatorModeVisualization();
            if(_loc6_ != null)
            {
               null.width = _loc9_.width;
               null.height = _loc9_.height;
               _loc9_.addChild(null);
            }
         }
         var_271.addRoomView(_loc9_);
         var_521.push(param1);
      }
      
      public function initCameraLocation(param1:int) : void
      {
         var _loc5_:Vector3d = null;
         var _loc2_:Number = _roomEngine.getRoomNumberValue(var_70.roomId,"camera_init_x");
         var _loc4_:Number = _roomEngine.getRoomNumberValue(var_70.roomId,"camera_init_y");
         var _loc3_:Number = _roomEngine.getRoomNumberValue(var_70.roomId,"camera_init_z");
         if(!isNaN(_loc2_) && !isNaN(_loc4_) && !isNaN(_loc3_))
         {
            _loc5_ = new Vector3d(_loc2_,_loc4_,_loc3_);
            _roomEngine.runUpdate();
            _roomEngine.updateRoomCamera(var_70.roomId,param1,_loc5_,1);
         }
      }
      
      public function enterAfterSpectate() : void
      {
         var _loc2_:class_1812 = var_271.getRoomView() as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc1_:class_1741 = _loc2_.findChildByName("spectator_mode_container");
         if(_loc1_ == null)
         {
            return;
         }
         _loc2_.removeChild(_loc1_);
         _loc1_.dispose();
      }
      
      private function checkAndEnableMouseZoomEvent(param1:DisplayObject) : void
      {
         param1.removeEventListener("mouseWheel",mouseWheelHandler);
         if(_sessionDataManager.isPerkAllowed("MOUSE_ZOOM"))
         {
            param1.addEventListener("mouseWheel",mouseWheelHandler);
         }
      }
      
      private function mouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(param1.ctrlKey && !param1.altKey && !param1.shiftKey)
         {
            var _temp_3:* = §§findproperty(var_1627);
            var_1627 += param1.delta == 0 ? 0 : (param1.delta < 0 ? -20 : 20);
            _loc3_ = new Point();
            var_174.getGlobalPosition(_loc3_);
            _loc2_ = param1.stageX - _loc3_.x;
            _loc4_ = param1.stageY - _loc3_.y;
            var_1605 = new Point(_loc2_,_loc4_);
         }
      }
      
      private function resizeColorizer(param1:class_1758) : void
      {
         var _loc2_:class_1970 = param1.target as class_1970;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Sprite = _loc2_.getDisplayObject() as Sprite;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.graphics.clear();
         _loc3_.graphics.beginFill(_roomColor);
         _loc3_.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         _loc3_.graphics.endFill();
      }
      
      private function resizeBackgroundColorizer(param1:class_1758) : void
      {
         var _loc2_:class_1970 = param1.target as class_1970;
         if(_loc2_ == null)
         {
            return;
         }
         fillBackgroundColorizer(_loc2_);
      }
      
      private function fillBackgroundColorizer(param1:class_1970) : void
      {
         var _loc2_:Sprite = param1.getDisplayObject() as Sprite;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.graphics.clear();
         _loc2_.graphics.beginFill(_roomBackgroundColor);
         _loc2_.graphics.drawRect(0,0,param1.width,param1.height);
         _loc2_.graphics.endFill();
      }
      
      public function setRoomViewColor(param1:uint, param2:int) : void
      {
         if(var_1443)
         {
            var_1443.startTransition(param1,param2,getTimer());
         }
      }
      
      private function updateColor() : void
      {
         if(var_1443 && var_1443.updateColor(getTimer()))
         {
            _roomColor = var_1443.color;
            drawRoomColor();
         }
         if(var_1465 && var_1465.updateColor(getTimer()))
         {
            _roomBackgroundColor = var_1465.color;
            drawRoomBackgroundColor();
         }
      }
      
      private function drawRoomColor() : void
      {
         var _loc2_:class_1812 = var_271.getRoomView() as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_1970 = _loc2_.getChildByName("colorizer_wrapper") as class_1970;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc1_:Sprite = _loc3_.getDisplayObject() as Sprite;
         if(_loc1_ == null)
         {
            return;
         }
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(_roomColor);
         _loc1_.graphics.drawRect(0,0,_loc3_.width,_loc3_.height);
         _loc1_.graphics.endFill();
      }
      
      public function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void
      {
         if(var_1465)
         {
            var_1465.startTransition(ColorConverter.hslToRGB(((param1 & 0xFF) << 16) + ((param2 & 0xFF) << 8) + (param3 & 0xFF)),param3,getTimer());
         }
      }
      
      private function drawRoomBackgroundColor() : void
      {
         var _loc1_:class_1812 = var_271.getRoomView() as class_1812;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:class_1970 = _loc1_.getChildByName("background_wrapper") as class_1970;
         if(_loc2_ == null)
         {
            return;
         }
         if(roomBackgroundColor == 0)
         {
            _loc2_.visible = false;
         }
         else
         {
            _loc2_.visible = true;
            fillBackgroundColorizer(_loc2_);
         }
      }
      
      public function getFirstCanvasId() : int
      {
         if(var_521 != null)
         {
            if(var_521.length > 0)
            {
               return var_521[0];
            }
         }
         return 0;
      }
      
      public function getRoomViewRect() : Rectangle
      {
         if(!var_271)
         {
            return null;
         }
         return var_271.roomViewRect;
      }
      
      public function addListenerToStage(param1:String, param2:Function) : void
      {
         if(!var_174 || !var_174.getDisplayObject() || !var_174.getDisplayObject().stage)
         {
            return;
         }
         var_174.getDisplayObject().stage.addEventListener(param1,param2,false,0,true);
      }
      
      public function removeListenerFromStage(param1:String, param2:Function) : void
      {
         if(!var_174 || !var_174.getDisplayObject() || !var_174.getDisplayObject().stage)
         {
            return;
         }
         var_174.getDisplayObject().stage.removeEventListener(param1,param2);
      }
      
      public function canvasMouseHandler(param1:class_1758) : void
      {
         var _loc5_:Point = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:Point = null;
         if(_roomEngine == null || var_70 == null)
         {
            return;
         }
         var _loc4_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc8_:String = "";
         switch(_loc4_.type)
         {
            case "WME_CLICK":
               _loc8_ = "click";
               break;
            case "WME_DOUBLE_CLICK":
               _loc8_ = "doubleClick";
               break;
            case "WME_DOWN":
               _loc8_ = "mouseDown";
               break;
            case "WME_UP":
            case "WME_UP_OUTSIDE":
               _loc8_ = "mouseUp";
               break;
            case "WME_MOVE":
               _loc8_ = "mouseMove";
               break;
            default:
               return;
         }
         var _loc2_:class_1970 = _loc4_.target as class_1970;
         if(_loc2_ == _loc4_.target)
         {
            _loc5_ = new Point();
            _loc2_.getGlobalPosition(_loc5_);
            _loc3_ = _loc4_.stageX - _loc5_.x;
            _loc7_ = _loc4_.stageY - _loc5_.y;
            _roomEngine.setActiveRoom(var_70.roomId);
            _roomEngine.handleRoomCanvasMouseEvent(var_521[0],_loc3_,_loc7_,_loc8_,_loc4_.altKey,_loc4_.ctrlKey,_loc4_.shiftKey,_loc4_.buttonDown);
         }
         if(_loc8_ == "mouseMove" && var_386 != null)
         {
            _loc6_ = new Point(_loc4_.stageX,_loc4_.stageY);
            _loc6_.offset(-var_386.width / 2,15);
            var_386.setGlobalPosition(_loc6_);
         }
      }
      
      private function mouseEventHandler(param1:MouseEvent) : void
      {
         var _loc3_:Point = new Point();
         var_174.getGlobalPosition(_loc3_);
         var _loc2_:int = param1.stageX - _loc3_.x;
         var _loc4_:int = param1.stageY - _loc3_.y;
         _roomEngine.setActiveRoom(var_70.roomId);
         param1.stopImmediatePropagation();
         _roomEngine.handleRoomCanvasMouseEvent(var_521[0],_loc2_,_loc4_,param1.type,param1.altKey,param1.ctrlKey,param1.shiftKey,param1.buttonDown);
      }
      
      private function onRoomViewResized(param1:class_1758) : void
      {
         var _loc2_:class_1741 = param1.window;
         var_2794 = _loc2_.rectangle;
         _roomEngine.modifyRoomCanvas(var_70.roomId,var_521[0],_loc2_.width,_loc2_.height);
         if(var_908 == null)
         {
            var_908 = new Timer(1000,1);
            var_908.addEventListener("timer",onResizeTimerEvent);
         }
         else
         {
            var_908.reset();
         }
         var_908.start();
      }
      
      private function onResizeTimerEvent(param1:TimerEvent) : void
      {
         events.dispatchEvent(new RoomWidgetRoomViewUpdateEvent("RWRVUE_ROOM_VIEW_SIZE_CHANGED",var_2794));
      }
      
      private function trackZooming(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(var_5326)
         {
            _loc3_ = getTimer();
            _loc4_ = Math.round((_loc3_ - _zoomChangedMillis) / 1000);
            if(_habboTracking != null)
            {
               if(param1)
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","out");
                  }
                  _habboTracking.trackGoogle("zoomEnded","in",_loc4_);
               }
               else
               {
                  if(param2)
                  {
                     _habboTracking.trackGoogle("zoomEvent","in");
                  }
                  _habboTracking.trackGoogle("zoomEnded","out",_loc4_);
               }
            }
            _zoomChangedMillis = _loc3_;
         }
      }
      
      private function onToolbarEvent(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTIE_ICON_ZOOM")
         {
            toggleZoom();
         }
      }
      
      private function toggleZoom() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:IRoomGeometry = null;
         if(var_70 != null)
         {
            if((_roomEngine as class_17).getBoolean("zoom.enabled"))
            {
               _loc1_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
               _loc2_ = _loc1_ == 1 ? 0.5 : 1;
               _roomEngine.setRoomCanvasScale(_roomEngine.activeRoomId,getFirstCanvasId(),_loc2_);
            }
            else
            {
               _loc3_ = _roomEngine.getRoomCanvasGeometry(var_70.roomId,getFirstCanvasId());
               if(_loc3_ != null)
               {
                  trackZooming(_loc3_.isZoomedIn(),true);
                  _loc3_.performZoom();
               }
            }
         }
      }
      
      public function update() : void
      {
         var _loc6_:Number = NaN;
         var _loc4_:int = 0;
         var _loc2_:IRoomWidgetHandler = null;
         var _loc1_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         if(_updateListeners == null)
         {
            return;
         }
         var _loc3_:int = int(_updateListeners.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _updateListeners[_loc4_] as IRoomWidgetHandler;
            if(_loc2_ != null)
            {
               _loc2_.update();
            }
            _loc4_++;
         }
         if(Math.abs(var_1627) > 0.01)
         {
            _loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
            _loc1_ = hibit(_loc6_);
            _loc7_ = (_loc1_ > 1 ? _loc1_ << 1 : 1) / 10;
            _loc5_ = var_1627 > 0 ? _loc6_ - _loc7_ : _loc6_ + _loc7_;
            _loc5_ = Math.max(0.5,_loc5_);
            var_2960 = true;
            var_1627 *= 0.05;
            _roomEngine.setRoomCanvasScale(var_70.roomId,getFirstCanvasId(),_loc5_,var_1605,null,false,true);
         }
         else if(var_2960)
         {
            var_2960 = false;
            _loc6_ = _roomEngine.getRoomCanvasScale(_roomEngine.activeRoomId);
            if(_loc6_ < 0.75)
            {
               _roomEngine.setRoomCanvasScale(var_70.roomId,getFirstCanvasId(),0.5,var_1605,null,false,true);
            }
            else
            {
               _roomEngine.setRoomCanvasScale(var_70.roomId,getFirstCanvasId(),Math.round(_loc6_),var_1605,null,false,true);
            }
         }
         updateColor();
      }
      
      private function hibit(param1:int) : int
      {
         param1 |= param1 >> 1;
         param1 |= param1 >> 2;
         param1 |= param1 >> 4;
         param1 |= param1 >> 8;
         param1 |= param1 >> 16;
         return param1 - (param1 >> 1);
      }
      
      private function getWindowName(param1:int) : String
      {
         return "Room_Engine_Window_" + param1;
      }
      
      private function createFilter(param1:int, param2:int) : Array
      {
         var _loc3_:BlurFilter = new BlurFilter(2,2);
         return [];
      }
      
      private function getBitmapFilter(param1:int, param2:int) : BitmapFilter
      {
         var _loc9_:BitmapData = new BitmapData(param1,param2);
         _loc9_.perlinNoise(param1,param2,5,Math.random() * 2000000000,true,false);
         var _loc6_:Point = new Point(0,0);
         var _loc3_:Number = param1 / 20;
         var _loc5_:Number = -param1 / 25;
         return new DisplacementMapFilter(_loc9_,_loc6_,1,1,_loc3_,_loc5_,"color",0,0);
      }
      
      private function checkInterrupts() : Boolean
      {
         if(_roomSessionManager != null && var_70 != null && var_2769)
         {
            _roomSessionManager.startSession(var_70);
            processEvent(new RoomWidgetLoadingBarUpdateEvent("RWLBUW_HIDE_LOADING_BAR"));
            return true;
         }
         return false;
      }
      
      private function handleRoomAdClick(param1:RoomEngineObjectEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc4_:IRoomObject = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:IRoomObjectModel = _loc4_.getModel() as IRoomObjectModel;
         var _loc2_:String = _loc3_.getString("furniture_ad_url");
         if(_loc2_ == null || _loc2_.indexOf("http") != 0)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_FURNI_CLICK":
               if(var_70.roomControllerLevel >= 1 || _sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
               break;
            case "RERAE_FURNI_DOUBLE_CLICK":
               if(!var_70.roomControllerLevel >= 1 && !_sessionDataManager.isAnyRoomController)
               {
                  return;
               }
               HabboWebTools.openWebPage(_loc2_);
         }
      }
      
      private function handleRoomAdTooltip(param1:RoomEngineObjectEvent) : void
      {
         var _loc3_:IRoomObject = null;
         var _loc4_:String = null;
         var _loc5_:IRoomObjectModel = null;
         var _loc2_:String = null;
         if(param1 == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RERAE_TOOLTIP_SHOW":
               if(var_386 != null)
               {
                  return;
               }
               _loc3_ = _roomEngine.getRoomObject(param1.roomId,param1.objectId,param1.category);
               if(_loc3_ == null)
               {
                  return;
               }
               _loc4_ = _localization.getLocalization(_loc3_.getType() + ".tooltip","${ads.roomad.tooltip}");
               if(_loc4_ == null)
               {
                  _loc5_ = _loc3_.getModel() as IRoomObjectModel;
                  _loc2_ = _loc5_.getString("furniture_ad_url");
                  if(_loc2_ != null && _loc2_.indexOf("http") == 0)
                  {
                     _loc4_ = _loc2_;
                  }
               }
               if(_loc4_ == null)
               {
                  return;
               }
               var_386 = _windowManager.createWindow("room_ad_tooltip",_loc4_,8,0,32) as IToolTipWindow;
               var_386.setParamFlag(1,false);
               var_386.visible = true;
               var_386.center();
               break;
            case "RERAE_TOOLTIP_HIDE":
               if(var_386 == null)
               {
                  return;
               }
               var_386.dispose();
               var_386 = null;
         }
      }
      
      private function getSpectatorModeVisualization() : class_1741
      {
         var _loc2_:XmlAsset = _assets.getAssetByName("spectator_mode_xml") as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         var _loc1_:class_1812 = _windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc1_ == null)
         {
            return null;
         }
         setBitmap(_loc1_.findChildByName("top_left"),"spec_top_left_png");
         setBitmap(_loc1_.findChildByName("top_middle"),"spec_top_middle_png");
         setBitmap(_loc1_.findChildByName("top_right"),"spec_top_right_png");
         setBitmap(_loc1_.findChildByName("middle_left"),"spec_middle_left_png");
         setBitmap(_loc1_.findChildByName("middle_right"),"spec_middle_right_png");
         setBitmap(_loc1_.findChildByName("bottom_left"),"spec_bottom_left_png");
         setBitmap(_loc1_.findChildByName("bottom_middle"),"spec_bottom_middle_png");
         setBitmap(_loc1_.findChildByName("bottom_right"),"spec_bottom_right_png");
         return _loc1_;
      }
      
      private function setBitmap(param1:class_1741, param2:String) : void
      {
         var _loc4_:class_2251 = param1 as class_2251;
         if(_loc4_ == null || _assets == null)
         {
            return;
         }
         var _loc5_:BitmapDataAsset = _assets.getAssetByName(param2) as BitmapDataAsset;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc5_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         _loc4_.bitmap = _loc3_.clone();
      }
      
      public function initializeWidget(param1:String, param2:int = 0) : void
      {
         var _loc3_:IRoomWidget = var_35[param1];
         if(_loc3_ == null)
         {
            class_21.log("Tried to initialize an unknown widget " + param1);
            return;
         }
         _loc3_.initialize(param2);
      }
      
      public function getWidgetState(param1:String) : int
      {
         var _loc2_:IRoomWidget = var_35[param1];
         if(_loc2_ == null)
         {
            class_21.log("Requested the state of an unknown widget " + param1);
            return -1;
         }
         return _loc2_.state;
      }
      
      public function addUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            _updateListeners = [];
         }
         if(_updateListeners.indexOf(param1) == -1)
         {
            _updateListeners.push(param1);
         }
      }
      
      public function removeUpdateListener(param1:IRoomWidgetHandler) : void
      {
         if(_updateListeners == null)
         {
            return;
         }
         var _loc2_:int = int(_updateListeners.indexOf(param1));
         if(_loc2_ != -1)
         {
            _updateListeners.splice(_loc2_,1);
         }
      }
      
      public function isOwnerOfFurniture(param1:IRoomObject) : Boolean
      {
         var _loc4_:int = sessionDataManager.userId;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ == null)
         {
            return false;
         }
         var _loc2_:Number = _loc3_.getNumber("furniture_owner_id");
         return _loc2_ == _loc4_;
      }
      
      public function getFurnitureOwnerId(param1:IRoomObject) : int
      {
         var _loc2_:Number = NaN;
         var _loc3_:IRoomObjectModel = param1.getModel();
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getNumber("furniture_owner_id");
            if(!isNaN(_loc2_))
            {
               return _loc2_;
            }
         }
         return -1;
      }
      
      public function isOwnerOfPet(param1:class_2146) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:int = sessionDataManager.userId;
         return _loc2_ == param1.ownerId;
      }
      
      public function showGamePlayerName(param1:int, param2:String, param3:uint, param4:int) : void
      {
         var _loc5_:AvatarInfoWidget = var_35["RWE_AVATAR_INFO"] as AvatarInfoWidget;
         if(!_loc5_)
         {
            return;
         }
         _loc5_.showGamePlayerName(param1,param2,param3,param4);
      }
      
      public function get layoutManager() : class_3019
      {
         return var_271;
      }
      
      public function mouseEventPositionHasInputEventWindow(param1:MouseEvent, param2:int) : Boolean
      {
         var _loc3_:Array = new Array(0);
         var _loc4_:Point = new Point(param1.stageX,param1.stageY);
         _windowManager.getDesktop(param2).groupParameterFilteredChildrenUnderPoint(_loc4_,_loc3_,1);
         return _loc3_.length > 1;
      }
   }
}

