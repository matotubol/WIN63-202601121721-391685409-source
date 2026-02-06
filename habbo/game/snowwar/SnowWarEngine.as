package com.sulake.habbo.game.snowwar
{
   import com.sulake.core.assets.AssetLibraryCollection;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IID;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.parser.game.snowwar.data.*;
   import com.sulake.habbo.friendlist.class_258;
   import com.sulake.habbo.game.HabboGameManager;
   import com.sulake.habbo.game.events.GameChatEvent;
   import com.sulake.habbo.game.snowwar.arena.ISynchronizedGameEvent;
   import com.sulake.habbo.game.snowwar.arena.SynchronizedGameArena;
   import com.sulake.habbo.game.snowwar.arena.class_2693;
   import com.sulake.habbo.game.snowwar.events.NewMoveTargetEvent;
   import com.sulake.habbo.game.snowwar.gameobjects.HumanGameObject;
   import com.sulake.habbo.game.snowwar.leaderboard.LeaderboardViewController;
   import com.sulake.habbo.game.snowwar.ui.GameArenaView;
   import com.sulake.habbo.game.snowwar.ui.GameEndingViewController;
   import com.sulake.habbo.game.snowwar.ui.GameLoadingViewController;
   import com.sulake.habbo.game.snowwar.ui.GameLobbyWindowCtrl;
   import com.sulake.habbo.game.snowwar.ui.GamesMainViewController;
   import com.sulake.habbo.game.snowwar.utils.Location3D;
   import com.sulake.habbo.game.snowwar.utils.WindowUtils;
   import com.sulake.habbo.groups.class_140;
   import com.sulake.habbo.help.IHabboHelp;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomObjectTileMouseEvent;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.ui.IRoomUI;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.IIDAvatarRenderManager;
   import com.sulake.iid.IIDHabboCatalog;
   import com.sulake.iid.IIDHabboCommunicationManager;
   import com.sulake.iid.IIDHabboConfigurationManager;
   import com.sulake.iid.IIDHabboFriendList;
   import com.sulake.iid.IIDHabboGroupsManager;
   import com.sulake.iid.IIDHabboHelp;
   import com.sulake.iid.IIDHabboLocalizationManager;
   import com.sulake.iid.IIDHabboRoomSessionManager;
   import com.sulake.iid.IIDHabboRoomUI;
   import com.sulake.iid.IIDHabboSoundManager;
   import com.sulake.iid.IIDHabboWindowManager;
   import com.sulake.iid.IIDRoomEngine;
   import com.sulake.iid.IIDSessionDataManager;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.outgoing.game.arena.*;
   import com.sulake.habbo.communication.messages.outgoing.game.ingame.*;
   import com.sulake.habbo.communication.messages.outgoing.game.directory.*;
   import com.sulake.habbo.communication.messages.outgoing.tracking.EventLogMessageComposer;
   
   public class SnowWarEngine extends class_17 implements class_31
   {
      
      private static const GHOST_CHECKSUM_TURNS_TO_CHECK:int = 3;
      
      public static const GET_SNOWWAR_TOKENS:String = "GET_SNOWWAR_TOKENS";
      
      public static const GET_SNOWWAR_TOKENS2:String = "GET_SNOWWAR_TOKENS2";
      
      public static const GET_SNOWWAR_TOKENS3:String = "GET_SNOWWAR_TOKENS3";
      
      public static const STATE_INACTIVE:int = 0;
      
      public static const STATE_GAME_STARTING:int = 1;
      
      public static const STATE_STAGE_LOADING:int = 2;
      
      public static const STATE_STAGE_STARTING:int = 3;
      
      public static const STATE_STAGE_RUNNING:int = 4;
      
      public static const STATE_STAGE_ENDING:int = 5;
      
      public static const STATE_GAME_OVER:int = 6;
      
      public static const STATE_REJOIN_GAME:int = 7;
      
      private static var _soundManager:class_544;
      
      private var _gameManager:HabboGameManager;
      
      private var _communication:class_57;
      
      private var _windowManager:class_38;
      
      private var var_637:class_16;
      
      private var _localization:class_27;
      
      private var _sessionDataManager:ISessionDataManager;
      
      private var _roomSessionManager:IRoomSessionManager;
      
      private var _avatarManager:class_48;
      
      private var var_2120:class_140;
      
      private var _roomEngine:IRoomEngine;
      
      private var _roomUI:IRoomUI;
      
      private var _catalog:IHabboCatalog;
      
      private var var_1692:class_1762;
      
      private var _habboHelp:IHabboHelp;
      
      private var _friendList:class_258;
      
      private var var_112:SynchronizedGameArena;
      
      private var var_137:GameArenaView;
      
      private var _timeSinceLastUpdate:int;
      
      private var var_66:int = 0;
      
      private var var_865:class_1750;
      
      private var var_1655:int;
      
      private var _players:class_55;
      
      private var var_417:int = 0;
      
      private var var_1075:int = 0;
      
      private var var_2486:int = 0;
      
      private var _serverChecksums:class_55;
      
      private var var_3246:Boolean = false;
      
      private var var_1232:GameLoadingViewController;
      
      private var var_77:GameEndingViewController;
      
      private var var_528:GamesMainViewController;
      
      private var var_1583:LeaderboardViewController;
      
      private var var_1298:Boolean = false;
      
      private var var_4361:Boolean = false;
      
      private var var_4818:Boolean = false;
      
      private var var_3294:Boolean = false;
      
      private var _stageLength:int;
      
      private var var_464:Boolean = false;
      
      private var var_4643:Boolean = false;
      
      private var var_3557:int = 0;
      
      private var _roomBeforeGame:int = -1;
      
      private var var_4533:int = -1;
      
      private var var_4345:Boolean = false;
      
      public function SnowWarEngine(param1:HabboGameManager, param2:class_15, param3:uint = 0, param4:class_40 = null)
      {
         super(param2,param3,param4);
         _gameManager = param1;
         queueInterface(new IIDHabboWindowManager(),onWindowManagerReady);
         queueInterface(new IIDHabboCommunicationManager(),onHabboCommunicationReady);
         queueInterface(new IIDHabboConfigurationManager(),onConfigurationReady);
         queueInterface(new IIDHabboLocalizationManager(),onLocalizationReady);
         queueInterface(new IIDHabboRoomSessionManager(),onRoomSessionManagerReady);
         queueInterface(new IIDSessionDataManager(),onSessionDataManagerReady);
         queueInterface(new IIDAvatarRenderManager(),onAvatarRenderedReady);
         queueInterface(new IIDRoomEngine(),onRoomEngineReady);
         queueInterface(new IIDHabboSoundManager(),onSoundManagerReady);
         queueInterface(new IIDHabboRoomUI(),onRoomUIReady);
         queueInterface(new IIDHabboCatalog(),onCatalogReady);
         queueInterface(new IIDHabboHelp(),onHabboHelpReady);
         queueInterface(new IIDHabboFriendList(),onFriendListReady);
         queueInterface(new IIDHabboGroupsManager(),onGroupsManagerReady);
         HabboGamesCom.log("SnowWarEngine initialized: " + param4);
         var_528 = new GamesMainViewController(this);
      }
      
      public static function playSound(param1:String, param2:int = 0) : void
      {
         if(_soundManager != null)
         {
            _soundManager.playSound(param1,param2);
         }
      }
      
      public static function stopSound(param1:String) : void
      {
         if(_soundManager != null)
         {
            _soundManager.stopSound(param1);
         }
      }
      
      public function get gameCenterEnabled() : Boolean
      {
         return _gameManager.gameCenterEnabled;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return _roomEngine;
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
      
      public function get config() : class_16
      {
         return var_637;
      }
      
      public function get avatarManager() : class_48
      {
         return _avatarManager;
      }
      
      public function get groupsManager() : class_140
      {
         return var_2120;
      }
      
      public function get roomUI() : IRoomUI
      {
         return _roomUI;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get friendList() : class_258
      {
         return _friendList;
      }
      
      public function get gameArena() : SynchronizedGameArena
      {
         return var_112;
      }
      
      public function get currentSubTurn() : int
      {
         return var_417;
      }
      
      public function get stageLength() : int
      {
         return _stageLength;
      }
      
      public function get roomBeforeGame() : int
      {
         return _roomBeforeGame;
      }
      
      public function get isGhostEnabled() : Boolean
      {
         return var_1298;
      }
      
      public function get isGhostVisualizationEnabled() : Boolean
      {
         return var_4361;
      }
      
      public function getArenaName(param1:GameLobbyData) : String
      {
         var _loc2_:String = "snowwar.field.name." + param1.fieldType;
         return localization.getLocalization(_loc2_,_loc2_);
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
         if(var_637)
         {
            var_637.release(new IIDHabboConfigurationManager());
            var_637 = null;
         }
         if(_localization)
         {
            _localization.release(new IIDHabboLocalizationManager());
            _localization = null;
         }
         if(_roomSessionManager)
         {
            _roomSessionManager.release(new IIDHabboRoomSessionManager());
            _roomSessionManager = null;
         }
         if(_sessionDataManager != null)
         {
            _sessionDataManager.release(new IIDSessionDataManager());
            _sessionDataManager = null;
         }
         if(_roomEngine != null)
         {
            _roomEngine.events.removeEventListener("REE_OBJECTS_INITIALIZED",onRoomObjectsInitialized);
            _roomEngine.release(new IIDRoomEngine());
            _roomEngine = null;
         }
         if(_soundManager != null)
         {
            _soundManager.release(new IIDHabboSoundManager());
            _soundManager = null;
         }
         if(_habboHelp != null)
         {
            _habboHelp.release(new IIDHabboHelp());
            _habboHelp = null;
         }
         if(_avatarManager != null)
         {
            _avatarManager.release(new IIDAvatarRenderManager());
            _avatarManager = null;
         }
         if(var_2120 != null)
         {
            var_2120.release(new IIDHabboGroupsManager());
            var_2120 = null;
         }
         if(_roomUI != null)
         {
            _roomUI.release(new IIDHabboRoomUI());
            _roomUI = null;
         }
         if(_catalog != null)
         {
            _catalog.release(new IIDHabboCatalog());
            _catalog = null;
         }
         if(_friendList != null)
         {
            _friendList.release(new IIDHabboFriendList());
            _friendList = null;
         }
         if(var_865 != null)
         {
            var_865.dispose();
            var_865 = null;
         }
         if(var_77)
         {
            var_77.dispose();
            var_77 = null;
         }
         disposeLoadingView();
         if(var_112 != null)
         {
            var_112.dispose();
            var_112 = null;
         }
         if(var_137 != null)
         {
            var_137.dispose();
            var_137 = null;
         }
         if(var_528)
         {
            var_528.dispose();
            var_528 = null;
         }
         if(var_1692)
         {
            var_1692.dispose();
            var_1692 = null;
         }
         if(var_1583)
         {
            var_1583.dispose();
            var_1583 = null;
         }
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
         var_1692 = new class_1762(this);
      }
      
      private function onConfigurationReady(param1:IID, param2:IUnknown) : void
      {
         var_637 = param2 as class_16;
         var_1298 = var_637.getBoolean("snowwar.ghost.enabled");
         if(var_1298)
         {
            var_4361 = var_637.getBoolean("snowwar.ghost.visualization.enabled");
            var_4818 = var_637.getBoolean("snowwar.ghost.immediate.enabled");
         }
         HabboGamesCom.logEnabled = var_637.getBoolean("snowwar.log.enabled");
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
         _avatarManager.events.addEventListener("AVATAR_RENDER_READY",onAvatarReady);
      }
      
      private function onGroupsManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         var_2120 = param2 as class_140;
      }
      
      private function onAvatarReady(param1:Event) : void
      {
         var _loc3_:XmlAsset = null;
         var _loc2_:Boolean = (context.assets as AssetLibraryCollection).hasAssetLibrary(assets.name);
         if(!_loc2_)
         {
            HabboGamesCom.log(assets.manifest);
            (context.assets as AssetLibraryCollection).addAssetLibrary(assets);
            _loc3_ = assets.getAssetByName("figure") as XmlAsset;
            _avatarManager.injectFigureData(_loc3_.content as XML);
            _avatarManager.resetAssetManager();
         }
      }
      
      private function onRoomEngineReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _roomEngine = param2 as IRoomEngine;
         _roomEngine.events.addEventListener("REE_OBJECTS_INITIALIZED",onRoomObjectsInitialized);
      }
      
      private function onRoomObjectsInitialized(param1:RoomEngineEvent) : void
      {
         if(var_112)
         {
            send(new Game2LoadStageReadyMessageComposer(100));
         }
      }
      
      public function send(param1:IMessageComposer) : void
      {
         if(_communication)
         {
            _communication.connection.send(param1);
         }
      }
      
      private function onSoundManagerReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _soundManager = class_544(param2);
      }
      
      private function onRoomUIReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _roomUI = param2 as IRoomUI;
      }
      
      private function onCatalogReady(param1:IID = null, param2:IUnknown = null) : void
      {
         _catalog = param2 as IHabboCatalog;
      }
      
      public function showGamesMainView() : void
      {
         var_528.toggleVisibility();
      }
      
      private function onHabboHelpReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _habboHelp = param2 as IHabboHelp;
      }
      
      private function onFriendListReady(param1:IID = null, param2:IUnknown = null) : void
      {
         if(disposed)
         {
            return;
         }
         _friendList = param2 as class_258;
      }
      
      public function onGameDirectoryAvailable(param1:Boolean) : void
      {
         if(param1)
         {
            showGamesMainView();
         }
      }
      
      public function initArena(param1:int, param2:int, param3:int, param4:Array) : void
      {
         if(!var_112)
         {
            var_112 = new SynchronizedGameArena();
            var_112.setExtension(new class_3118());
            var_112.initialize(this,param3);
            var_137 = new GameArenaView(this);
            _roomSessionManager.disposeSession(-1,false);
            _roomSessionManager.startGameSession();
            registerUpdateReceiver(this,1);
            _timeSinceLastUpdate = 0;
            var_417 = 0;
            var_1075 = 0;
         }
      }
      
      public function startServerGame(param1:String) : void
      {
         initGameDirectoryConnection();
         send(new Game2StartSnowWarMessageComposer(param1));
      }
      
      public function initGameDirectoryConnection() : void
      {
         send(new Game2CheckGameDirectoryStatusMessageComposer());
      }
      
      public function startQuickServerGame() : void
      {
         send(new Game2QuickJoinGameMessageComposer());
      }
      
      private function getCurrentStage() : class_2694
      {
         if(!var_112)
         {
            return null;
         }
         return var_112.getCurrentStage() as class_2694;
      }
      
      public function getCurrentPlayer() : HumanGameObject
      {
         return getPlayer(var_1655);
      }
      
      public function getPlayer(param1:int) : HumanGameObject
      {
         var _loc2_:class_2693 = getCurrentStage();
         if(!_loc2_)
         {
            return null;
         }
         return _loc2_.getGameObject(param1) as HumanGameObject;
      }
      
      public function handleClickOnTile(param1:RoomObjectTileMouseEvent) : void
      {
         if(var_66 != 4)
         {
            return;
         }
         var _loc2_:int = class_2993.getClickTypeOnTile(param1.altKey,param1.shiftKey);
         if(_loc2_ == 0)
         {
            moveOwnAvatarTo(param1.tileXAsInt,param1.tileYAsInt);
         }
         else
         {
            throwSnowballAt(param1.tileXAsInt,param1.tileYAsInt,getTrajectoryFromClickType(_loc2_));
         }
      }
      
      public function handleClickOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc7_:HumanGameObject = null;
         var _loc4_:HumanGameObject = null;
         var _loc6_:int = 0;
         if(var_66 != 4)
         {
            return;
         }
         var _loc5_:HumanGameObject = getGhostPlayer();
         if(param1 == var_1655 || var_1298 && _loc5_ && param1 == _loc5_.gameObjectId)
         {
            if(makeSnowball() && var_137)
            {
               var_137.startWaitingForSnowball();
            }
         }
         else
         {
            _loc7_ = getCurrentPlayer();
            _loc4_ = getPlayer(param1);
            if(_loc7_ && _loc4_ && _loc7_.team != _loc4_.team)
            {
               _loc6_ = class_2993.getClickTypeOnOpponent(param2,param3);
               throwSnowballAtHuman(param1,getTrajectoryFromClickType(_loc6_));
            }
         }
      }
      
      public function handleMouseOverOnHuman(param1:int, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:HumanGameObject = getPlayer(param1);
         if(!_loc6_)
         {
            return;
         }
         if(var_637.getBoolean("snowstorm.settings.show_user_names"))
         {
            _loc4_ = _loc6_.team == 1 ? 4281310921 : 4290988872;
            _loc5_ = 500;
            _roomUI.showGamePlayerName(_loc6_.gameObjectId,_loc6_.name,_loc4_,_loc5_);
         }
         if(var_66 == 4)
         {
            var_137.updateTileCursor(_loc6_.team);
         }
      }
      
      public function moveOwnAvatarTo(param1:int, param2:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:class_2694 = null;
         if(var_66 != 4)
         {
            return;
         }
         var _loc4_:HumanGameObject = getCurrentPlayer();
         if(_loc4_)
         {
            _loc6_ = param1 * 3200;
            _loc5_ = param2 * 3200;
            _loc3_ = getCurrentStage();
            if(_loc3_)
            {
               send(new Game2SetUserMoveTargetMessageComposer(_loc6_,_loc5_,var_112.getTurnNumber(),var_112.subturn));
               walkGhost(_loc4_,_loc6_,_loc5_);
            }
         }
      }
      
      public function getGhostPlayer() : HumanGameObject
      {
         var _loc1_:HumanGameObject = getCurrentPlayer();
         if(_loc1_)
         {
            return getPlayer(_loc1_.ghostObjectId);
         }
         return null;
      }
      
      private function throwSnowballAtHuman(param1:int, param2:int) : void
      {
         var _loc3_:HumanGameObject = getCurrentPlayer();
         if(_loc3_ && _loc3_.canThrowSnowballs())
         {
            send(new Game2ThrowSnowballAtHumanMessageComposer(param1,param2,var_112.getTurnNumber(),var_112.subturn));
            stopGhost();
         }
      }
      
      private function throwSnowballAt(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:HumanGameObject = getCurrentPlayer();
         if(_loc4_ && _loc4_.canThrowSnowballs())
         {
            _loc6_ = param1 * 3200;
            _loc5_ = param2 * 3200;
            send(new Game2ThrowSnowballAtPositionMessageComposer(_loc6_,_loc5_,param3,var_112.getTurnNumber(),var_112.subturn));
            stopGhost();
         }
      }
      
      private function getTrajectoryFromClickType(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = 0;
               break;
            case 1:
               _loc2_ = 2;
               break;
            case 2:
               _loc2_ = 1;
               break;
            default:
               _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function makeSnowball() : Boolean
      {
         if(var_66 != 4)
         {
            return false;
         }
         var _loc1_:HumanGameObject = getCurrentPlayer();
         if(_loc1_ && _loc1_.canMakeSnowballs())
         {
            send(new Game2MakeSnowballMessageComposer(var_112.getTurnNumber(),var_112.subturn));
            stopGhost();
            return true;
         }
         return false;
      }
      
      private function walkGhost(param1:HumanGameObject, param2:int, param3:int) : void
      {
         var _loc6_:Boolean = false;
         var _loc4_:HumanGameObject = null;
         var _loc5_:ISynchronizedGameEvent = null;
         if(var_1298)
         {
            _loc6_ = param1 && param1.posture != "swdieback" && param1.posture != "swdiefront";
            _loc4_ = getGhostPlayer();
            if(_loc4_ && _loc6_)
            {
               _loc5_ = new NewMoveTargetEvent(_loc4_,param2,param3);
               if(var_4818)
               {
                  _loc5_.apply(gameArena.getCurrentStage());
               }
               else
               {
                  gameArena.addGameEvent(gameArena.getTurnNumber(),gameArena.subturn,_loc5_);
               }
            }
         }
      }
      
      private function stopGhost() : void
      {
         var _loc1_:HumanGameObject = null;
         if(var_1298)
         {
            _loc1_ = getGhostPlayer();
            if(_loc1_)
            {
               _loc1_.stopMovement();
            }
         }
      }
      
      public function update(param1:uint) : void
      {
         if(!var_112 || !var_66 == 4 || !var_66 == 3)
         {
            return;
         }
         if(var_137 && var_66 == 3)
         {
            var_137.update(param1,var_112.subturn == 0);
         }
         _timeSinceLastUpdate += param1;
         var _loc8_:int = (var_112.getExtension() as class_3118).getPulseInterval();
         if(!var_3246 && _timeSinceLastUpdate > _loc8_ && var_417 < var_1075)
         {
            var_112.pulse();
            _timeSinceLastUpdate -= _loc8_;
            var_417 = var_417 + 1;
            if(_timeSinceLastUpdate > _loc8_)
            {
               _timeSinceLastUpdate = 0;
            }
            var _loc9_:int = var_1075 - currentSubTurn;
            while(0 > ((_loc9_--,3)))
            {
               var_112.pulse();
               var_417 = var_417 + 1;
            }
            if(var_137 && var_66 == 4)
            {
               var_137.update(param1,var_112.subturn == 0);
            }
            if(var_417 % var_112.getNumberOfSubTurns() == 0)
            {
               var _loc5_:int = gameArena.getTurnNumber() - 1;
               var _loc6_:int = gameArena.getCheckSum(0);
               var _loc7_:int = int(_serverChecksums[0]);
               checkGhostLocation(0);
               var _loc3_:* = 0 < var_2486 - 3;
               var _loc10_:* = 0 != 0;
               if(var_3294)
               {
                  HabboGamesCom.log("Turn: " + [0,var_2486] + " currentSubTurn:" + var_417 + " maxSubTurn:" + var_1075 + " serverChecksum:" + 0 + " clientChecksum:" + 0);
                  var _loc2_:int = -1;
                  var _loc4_:uint = 255;
                  HabboGamesCom.log("ERROR WAS GENERATED! Requesting full status!");
                  var_137.showChecksumError(0);
                  requestFullStatus(0);
                  var_3294 = false;
                  var_3246 = true;
               }
            }
         }
      }
      
      private function checkGhostLocation(param1:int) : void
      {
         var _loc3_:HumanGameObject = null;
         var _loc6_:Location3D = null;
         var _loc2_:HumanGameObject = null;
         var _loc5_:Boolean = false;
         var _loc4_:int = 0;
         if(var_1298)
         {
            _loc3_ = getCurrentPlayer();
            _loc6_ = _loc3_.currentLocation;
            _loc2_ = getGhostPlayer();
            _loc5_ = false;
            _loc4_ = -3;
            while(_loc4_ < 3)
            {
               _loc5_ = _loc2_.isInGhostDistance(param1 + _loc4_,_loc6_);
               if(_loc5_)
               {
                  break;
               }
               _loc4_++;
            }
            _loc2_.removeGhostLocation(param1 - 3);
            if(!_loc5_ && param1 > 3)
            {
               HabboGamesCom.log("GHOST CHECKSUM MISMATCH, checksumTurn:" + param1 + " currentLocation:" + _loc6_);
               _loc2_.reinitGhost(_loc3_);
               _loc2_.addGhostLocation(param1);
               var_137.showChecksumError(65280);
            }
         }
      }
      
      public function nextTurn(param1:int, param2:int, param3:Boolean = false) : void
      {
         var_2486 = param1;
         _serverChecksums[var_2486] = param2;
         var_1075 = (param1 + 1) * gameArena.getNumberOfSubTurns();
         if(param3)
         {
            var_417 = var_1075 - gameArena.getNumberOfSubTurns();
            _timeSinceLastUpdate = (gameArena.getExtension() as class_3118).getPulseInterval();
            var_3246 = false;
            if(var_1298)
            {
               getGhostPlayer().addGhostLocation(var_2486);
            }
         }
      }
      
      public function requestFullStatus(param1:int) : void
      {
         send(new Game2RequestFullStatusUpdateMessageComposer(param1));
      }
      
      public function alert(param1:String) : void
      {
         removeOldAlert();
         if(!var_865)
         {
            var_865 = _windowManager.alert("SnowWar Alert",param1,0,onAlertClose);
         }
         else
         {
            var_865.summary = param1;
         }
         HabboGamesCom.log("[HabboGameManager.alert] " + param1);
      }
      
      public function disposeLoadingView() : void
      {
         if(var_1232)
         {
            var_1232.dispose();
            var_1232 = null;
         }
      }
      
      public function removeOldAlert() : void
      {
         if(var_865)
         {
            var_865.dispose();
            var_865 = null;
         }
      }
      
      public function generateChecksumMismatch() : void
      {
         if(var_66 != 4)
         {
            return;
         }
         var_3294 = true;
      }
      
      private function onAlertClose(param1:class_1750, param2:class_1758) : void
      {
         removeOldAlert();
      }
      
      public function set ownId(param1:int) : void
      {
         var_1655 = param1;
      }
      
      public function get ownId() : int
      {
         return var_1655;
      }
      
      public function initView() : void
      {
         if(var_137)
         {
            var_137.init();
         }
      }
      
      public function get mainView() : GamesMainViewController
      {
         return var_528;
      }
      
      public function get lobbyView() : GameLobbyWindowCtrl
      {
         if(var_528)
         {
            return var_528.lobbyView;
         }
         return null;
      }
      
      public function stageLoading(param1:int, param2:Array) : void
      {
         if(var_1232 != null)
         {
            var_66 = 2;
            var_1232.showReadyPlayers(param2);
         }
      }
      
      public function startStage(param1:int) : void
      {
         if(var_137)
         {
            _roomUI.visible = true;
            disposeLoadingView();
            playSound("HBSTG_ig_countdown");
            var_137.initGameUI(param1);
            var_66 = 3;
         }
      }
      
      public function stageRunning(param1:int) : void
      {
         if(param1 > 0)
         {
            _stageLength = param1;
            var_66 = 4;
         }
         else
         {
            var_66 = 5;
         }
         var_417 = 0;
         var_1075 = 0;
      }
      
      public function resetGameSession() : void
      {
         _roomEngine.isGameMode = false;
         var_66 = 5;
         removeUpdateReceiver(this);
         if(var_112)
         {
            var_112.dispose();
            var_112 = null;
         }
         stopSound("HBSTG_snowwar_walk");
         send(new Game2GetAccountGameStatusMessageComposer(0));
      }
      
      public function resetRoomSession() : void
      {
         _roomSessionManager.disposeGameSession();
         if(var_137)
         {
            var_137.dispose();
            var_137 = null;
         }
      }
      
      public function gameOver(param1:int, param2:Array, param3:Game2SnowWarGameStats, param4:Game2GameResult) : void
      {
         var_66 = 6;
         var_528.close(false);
         if(var_77)
         {
            var_77.dispose();
            var_77 = null;
         }
         if(var_137)
         {
            var_137.removeGameUI();
         }
         var_77 = new GameEndingViewController(this,param2,param3,param4,param1);
      }
      
      public function gameStarted(param1:GameLobbyData) : void
      {
         var_66 = 1;
         var_464 = false;
         _players = new class_55();
         _serverChecksums = new class_55();
         for each(var _loc2_ in param1.players)
         {
            _players.add(_loc2_.userId,_loc2_);
         }
         if(var_77)
         {
            var_77.dispose();
            var_77 = null;
         }
         if(!var_1232)
         {
            var_1232 = new GameLoadingViewController(this);
         }
         var_1232.show(param1);
      }
      
      public function rejoinGame(param1:int) : void
      {
         var_66 = var_464 ? 7 : 6;
         _roomBeforeGame = param1;
         if(var_77)
         {
            var_77.changeToWaitState(var_464);
            var_464 = false;
         }
      }
      
      public function playerRematches(param1:int) : void
      {
         if(var_77)
         {
            var_77.playerRematches(param1);
         }
      }
      
      public function startLobbyCounter(param1:int) : void
      {
         if(var_66 == 7 && var_77 != null)
         {
            var_77.startLobbyCountDown(param1);
         }
         else if(lobbyView)
         {
            lobbyView.startCountdown(param1);
         }
      }
      
      public function sendRejoinGame() : void
      {
         var_464 = true;
         send(new Game2PlayAgainMessageComposer());
      }
      
      public function addChatMessage(param1:int, param2:String, param3:Boolean = false) : void
      {
         if(_players == null)
         {
            return;
         }
         var _loc6_:GameLobbyPlayerData = _players.getValue(param1);
         if(_loc6_ == null)
         {
            return;
         }
         var _loc5_:int = _loc6_.teamId == 1 ? -300 : 300;
         var _loc4_:uint = _loc6_.teamId == 1 ? 255 : 16711680;
         _gameManager.events.dispatchEvent(new GameChatEvent("gce_game_chat",param1,param2,_loc5_,_loc4_,_loc6_.figure,_loc6_.gender,_loc6_.name,_loc6_.teamId,param3));
      }
      
      public function stopLobbyCounter() : void
      {
         if(var_66 == 7 && var_77 != null)
         {
            var_464 = true;
            var_77.changeToWaitState(var_464);
         }
         else if(lobbyView)
         {
            lobbyView.stopCountdown();
         }
      }
      
      public function createLobby(param1:GameLobbyData) : void
      {
         var _loc2_:* = null;
         if(var_66 == 6)
         {
            var_464 = true;
         }
         if(var_77 != null && var_66 != 7)
         {
            var_77.changeToWaitState(var_464);
            var_66 = 7;
            var_464 = false;
         }
         if(var_66 == 7 && var_77 != null)
         {
            var_77.changeToLobbyState(param1);
            for each(_loc2_ in param1.players)
            {
               var_77.playerJoined(_loc2_);
            }
         }
         else
         {
            var_66 = 0;
            mainView.openGameLobbyWindow(getArenaName(param1),param1.numberOfTeams,param1.maximumPlayers);
            for each(_loc2_ in param1.players)
            {
               lobbyView.playerJoined(_loc2_);
            }
         }
      }
      
      public function userJoined(param1:GameLobbyPlayerData) : void
      {
         if(var_66 == 7 && var_77 != null)
         {
            var_77.playerJoined(param1);
         }
         else
         {
            var_66 = 0;
            if(lobbyView)
            {
               lobbyView.playerJoined(param1);
            }
         }
      }
      
      public function userLeft(param1:int) : void
      {
         if(var_66 == 7 && var_77 != null)
         {
            var_77.playerLeft(param1);
         }
         else
         {
            var_66 = 0;
            if(lobbyView)
            {
               lobbyView.playerLeft(param1);
            }
         }
      }
      
      public function gamesLeft(param1:int, param2:Boolean, param3:int) : void
      {
         if(param1 == 0)
         {
            var_4643 = param2;
            var_3557 = param3;
            if(var_77)
            {
               var_77.updateGamesLeft();
            }
            if(var_528)
            {
               var_528.updateGameStartingStatus();
            }
         }
      }
      
      public function get isGameStarting() : Boolean
      {
         return var_66 == 1 || var_66 == 7;
      }
      
      public function resetSession() : void
      {
         resetGameSession();
         resetRoomSession();
         if(var_77)
         {
            var_77.dispose();
            var_77 = null;
         }
         if(var_528)
         {
            var_528.openMainWindow(false);
         }
      }
      
      public function gameCancelled(param1:Boolean) : void
      {
         resetSession();
         if(param1)
         {
            _gameManager.onSnowWarArenaSessionEnded();
         }
      }
      
      public function get hasUnlimitedGames() : Boolean
      {
         return var_4643;
      }
      
      public function get freeGamesLeft() : int
      {
         return var_3557;
      }
      
      public function stopWaitingForSnowball(param1:int) : void
      {
         if(var_137 != null && param1 == var_1655)
         {
            var_137.stopWaitingForSnowball();
         }
      }
      
      public function openGetMoreGames(param1:String) : void
      {
         _catalog.buySnowWarTokensOffer("GET_SNOWWAR_TOKENS");
         logGameEvent(param1);
      }
      
      public function openClubCenter(param1:String) : void
      {
         _catalog.openClubCenter();
         logGameEvent(param1);
      }
      
      public function logGameEvent(param1:String) : void
      {
         send(new EventLogMessageComposer("GameFramework","SnowStorm",param1,"",freeGamesLeft));
      }
      
      public function registerHit(param1:HumanGameObject, param2:HumanGameObject) : void
      {
         if(var_1655 == param1.gameObjectId)
         {
            var_137.flashOwnScore(false);
         }
         else if(var_1655 == param2.gameObjectId)
         {
            var_137.flashOwnScore(true);
         }
      }
      
      public function set gamesPlayed(param1:int) : void
      {
         var_4533 = param1;
      }
      
      public function promoteGame() : void
      {
         if(var_4345 || var_4533 != 0)
         {
            return;
         }
         var_4345 = true;
         var _loc2_:* = var_637.getInteger("new.identity",0) > 0;
         var _loc1_:String = var_637.getProperty("new.user.wing");
         if(_loc2_ && _loc1_ != "game")
         {
            return;
         }
         _habboHelp.showWelcomeScreen("HTIE_ICON_GAMES","snowwar.promotion",0,"GAMES");
      }
      
      public function showLeaderboard() : void
      {
         leaderboard.selectedGame = 0;
         leaderboard.showFriendsAllTime();
      }
      
      public function get leaderboard() : LeaderboardViewController
      {
         if(!var_1583 && !gameCenterEnabled)
         {
            var_1583 = new LeaderboardViewController(this);
         }
         return var_1583;
      }
   }
}

