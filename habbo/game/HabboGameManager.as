package com.sulake.habbo.game
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.friendbar.IHabboLandingView;
   import com.sulake.habbo.game.snowwar.SnowWarEngine;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.navigator.class_41;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboInventory;
   import com.sulake.iid.IIDHabboLandingView;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboNavigator;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboToolbar;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import com.sulake.habbo.communication.messages.outgoing.catalog.GetSnowWarGameTokensOfferComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2CheckGameDirectoryStatusMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2StartSnowWarMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.Game2QuickJoinGameMessageComposer;
   
   public class HabboGameManager extends class_17 implements class_45
   {
      
      private var _communication:class_57;
      
      private var _windowManager:class_38;
      
      private var _localization:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _toolbar:IHabboToolbar;
      
      private var _avatarManager:class_48;
      
      private var _catalog:IHabboCatalog;
      
      private var _roomEngine:IRoomEngine;
      
      private var _habboHelp:IHabboHelp;
      
      private var _inventory:class_61;
      
      private var _navigator:class_41;
      
      private var var_21:SnowWarEngine;
      
      private var var_1692:IncomingMessages;
      
      private var var_4641:Boolean = false;
      
      private var var_4398:Boolean = false;
      
      private var var_5057:Boolean = false;
      
      private var _landingView:IHabboLandingView;
      
      private var _activeGame:int = -1;
      
      public function HabboGameManager(param1:class_15, param2:uint = 0, param3:class_40 = null)
      {
         super(param1,param2,param3);
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderedReady);
         queueInterface(new IIDHabboToolbar(),onToolbarReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboLandingView(),onLandingViewReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboInventory(),onHabboInventory);
         queueInterface(new IIDHabboNavigator(),onHabboNavigator);
         var_21 = new SnowWarEngine(this,param1,0,param3);
         HabboGamesCom.log("HabboGameManager initialized: " + param3);
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get communication() : class_57
      {
         return _communication;
      }
      
      public function get localization() : class_27
      {
         return _localization;
      }
      
      public function get avatarManager() : class_48
      {
         return _avatarManager;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
      }
      
      public function get inventory() : class_61
      {
         return _inventory;
      }
      
      public function get navigator() : class_41
      {
         return _navigator;
      }
      
      public function get gameCenterEnabled() : Boolean
      {
         return var_4641 || var_4398 && sessionDataManager.hasSecurity(4);
      }
      
      public function get isHotelClosed() : Boolean
      {
         return var_5057;
      }
      
      public function set hotelClosed(param1:Boolean) : void
      {
         var_5057 = param1;
      }
      
      override public function dispose() : void
      {
         if(_communication)
         {
            _communication.release(new IIDHabboCommunicationManager());
            _communication = null;
         }
         if(_windowManager)
         {
            _windowManager.release(new IIDHabboWindowManager());
            _windowManager = null;
         }
         if(_localization)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_toolbar)
         {
            if(_toolbar.events)
            {
               _toolbar.events.removeEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
            }
            _toolbar.release(new IIDHabboToolbar());
            _toolbar = null;
         }
         if(_avatarManager != null)
         {
            _avatarManager.release(new IIDAvatarRenderManager());
            _avatarManager = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(var_1692)
         {
            var_1692.dispose();
            var_1692 = null;
         }
         if(_landingView)
         {
            _landingView.release(new IIDHabboLandingView());
            _landingView = null;
         }
         if(_roomEngine)
         {
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_inventory)
         {
            _inventory.release(new IIDHabboInventory());
            _inventory = null;
         }
         if(_navigator)
         {
            _navigator.release(new IIDHabboNavigator());
            _navigator = null;
         }
         _activeGame = -1;
         super.dispose();
      }
      
      private function onWindowManagerReady(param1:IID, param2:IUnknown) : void
      {
         _windowManager = param2 as class_38;
         WindowUtils.init(assets,_windowManager);
      }
      
      private function onHabboCommunicationReady(param1:IID, param2:IUnknown) : void
      {
         _communication = param2 as class_57;
         var_1692 = new IncomingMessages(this);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         var_4641 = getBoolean("game.center.enabled");
         var_4398 = getBoolean("game.center.enabled.forStaff");
      }
      
      private function onLocalizationReady(param1:IID, param2:IUnknown) : void
      {
         _localization = param2 as class_27;
      }
      
      private function onSessionDataManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _sessionDataManager = param2 as ISessionDataManager;
      }
      
      private function onRoomSessionManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomSessionManager = param2 as IRoomSessionManager;
      }
      
      private function onAvatarRenderedReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _avatarManager = param2 as class_48;
      }
      
      private function onToolbarReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _toolbar = param2 as IHabboToolbar;
         _toolbar.events.addEventListener("HTE_TOOLBAR_CLICK",onToolbarClick);
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _catalog = param2 as IHabboCatalog;
      }
      
      private function onLandingViewReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _landingView = param2 as IHabboLandingView;
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomEngine = param2 as IRoomEngine;
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onHabboInventory(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _inventory = param2 as class_61;
      }
      
      private function onHabboNavigator(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _navigator = param2 as class_41;
      }
      
      public function initGameDirectoryConnection() : void
      {
         send(new Game2CheckGameDirectoryStatusMessageComposer());
      }
      
      public function startSnowWarGame(param1:String) : void
      {
         initGameDirectoryConnection();
         send(new Game2StartSnowWarMessageComposer(param1));
      }
      
      public function startQuickSnowWarGame() : void
      {
         send(new Game2QuickJoinGameMessageComposer());
      }
      
      public function onSnowWarArenaSessionEnded() : void
      {
         if(!var_21.isGameStarting)
         {
            var_21.resetSession();
            if(_landingView != null)
            {
               _landingView.activate();
            }
         }
      }
      
      public function generateChecksumMismatch() : void
      {
         if(var_21)
         {
            var_21.generateChecksumMismatch();
         }
      }
      
      public function handleClickOnTile(param1:RoomObjectTileMouseEvent) : void
      {
         if(var_21)
         {
            var_21.handleClickOnTile(param1);
         }
      }
      
      public function handleClickOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(var_21)
         {
            var_21.handleClickOnHuman(param1,param2,param3);
         }
      }
      
      public function handleMouseOverOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         if(var_21)
         {
            var_21.handleMouseOverOnHuman(param1,param2,param3);
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communication)
         {
            _communication.connection.send(param1);
         }
      }
      
      private function onToolbarClick(param1:HabboToolbarEvent) : void
      {
         switch(param1.iconId)
         {
            case "HTIE_ICON_GAMES":
               initGameDirectoryConnection();
               send(new GetSnowWarGameTokensOfferComposer());
               break;
            case "HTIE_ICON_RECEPTION":
         }
      }
   }
}

