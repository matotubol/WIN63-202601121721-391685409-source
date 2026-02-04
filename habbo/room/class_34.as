package com.sulake.habbo.room
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.utils.class_2130;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.utils.images.class_1791;
   import com.sulake.habbo.advertisement.class_56;
   import com.sulake.habbo.advertisement.events.AdEvent;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_2076;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_2077;
   import com.sulake.habbo.game.class_45;
   import com.sulake.habbo.room.events.RoomEngineAreaHideStateWidgetEvent;
   import com.sulake.habbo.room.events.RoomEngineDragWithMouseEvent;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.room.events.RoomEngineHSLColorEnableEvent;
   import com.sulake.habbo.room.events.RoomEngineObjectEvent;
   import com.sulake.habbo.room.events.RoomEngineRoomColorEvent;
   import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
   import com.sulake.habbo.room.events.RoomToObjectOwnAvatarMoveEvent;
   import com.sulake.habbo.room.messages.RoomObjectAvatarBlockedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarCarryObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarChatUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDanceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarDirectionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarEffectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExperienceUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarExpressionUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFigureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarFlatControlUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarGuideStatusUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarMutedUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarOwnMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPetGestureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayerValueUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPlayingGameMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarPostureUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSignUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarSleepUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarTypingUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectAvatarUseObjectUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectGroupBadgeUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectHeightUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectItemDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectModelDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomAdUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomColorUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomFloorHoleUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomMaskUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlanePropertyUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomPlaneVisibilityUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectRoomUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectTileCursorUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectUpdateStateMessage;
   import com.sulake.habbo.room.object.RoomObjectUserTypes;
   import com.sulake.habbo.room.object.RoomPlaneParser;
   import com.sulake.habbo.room.object.data.class_2035;
   import com.sulake.habbo.room.object.data.class_2108;
   import com.sulake.habbo.room.utils.RoomAreaSelectionManager;
   import com.sulake.habbo.room.utils.class_1744;
   import com.sulake.habbo.room.utils.class_1771;
   import com.sulake.habbo.room.utils.class_1821;
   import com.sulake.habbo.room.utils.class_1925;
   import com.sulake.habbo.room.utils.class_1934;
   import com.sulake.habbo.room.utils.class_2004;
   import com.sulake.habbo.room.utils.class_2070;
   import com.sulake.habbo.room.utils.class_2197;
   import com.sulake.habbo.room.utils.class_2200;
   import com.sulake.habbo.room.utils.class_2247;
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.events.BadgeImageReadyEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.utils.class_2262;
   import com.sulake.habbo.window.class_38;
   import com.sulake.iid.*;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.IRoomManager;
   import com.sulake.room.IRoomManagerListener;
   import com.sulake.room.IRoomObjectFactory;
   import com.sulake.room.RoomInstance;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomObjectMouseEvent;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.*;
   import com.sulake.room.object.logic.IRoomObjectEventHandler;
   import com.sulake.room.object.visualization.IRoomObjectSpriteVisualization;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.renderer.IRoomRenderer;
   import com.sulake.room.renderer.IRoomRendererFactory;
   import com.sulake.room.renderer.IRoomRenderingCanvas;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.NumberBank;
   import com.sulake.room.utils.RoomEnterEffect;
   import com.sulake.room.utils.RoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import com.sulake.room.utils.class_2119;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.FileReference;
   import flash.ui.Mouse;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   import package_50.AreaHideMessageData;
   
   [SecureSWF(rename="true")]
   public class class_34 extends class_17 implements IRoomEngine, IRoomManagerListener, class_30, class_32, class_31, class_33
   {
      
      public static const SETUP_WITHOUT_TOOLBAR:uint = 1;
      
      public static const const_82:uint = 2;
      
      public static const SETUP_WITHOUT_GAME_MANAGER:uint = 4;
      
      public static const const_38:uint = 5;
      
      private static const ROOM_TEMP_ID:String = "temporary_room";
      
      public static const OBJECT_ID_ROOM:int = -1;
      
      private static const OBJECT_TYPE_ROOM:String = "room";
      
      private static const OBJECT_ID_ROOM_HIGHLIGHTER:int = -2;
      
      private static const OBJECT_TYPE_ROOM_HIGHLIGHTER:String = "tile_cursor";
      
      private static const const_1081:int = -3;
      
      private static const const_604:String = "selection_arrow";
      
      private static const const_204:String = "overlay";
      
      private static const const_1256:String = "object_icon_sprite";
      
      private static const ROOM_DRAG_THRESHOLD:int = 15;
      
      private static const const_1179:int = 30;
      
      private var _communication:class_57 = null;
      
      private var _roomRendererFactory:IRoomRendererFactory = null;
      
      private var _roomManager:IRoomManager = null;
      
      private var _roomObjectFactory:IRoomObjectFactory = null;
      
      private var _visualizationFactory:IRoomObjectVisualizationFactory = null;
      
      private var _adManager:class_56 = null;
      
      private var _sessionDataManager:ISessionDataManager = null;
      
      private var _roomSessionManager:IRoomSessionManager = null;
      
      private var _toolbar:IHabboToolbar = null;
      
      private var _catalog:IHabboCatalog = null;
      
      private var _windowManager:class_38;
      
      private var _roomEvents:IHabboUserDefinedRoomEvents;
      
      private var var_126:class_1947 = null;
      
      private var var_761:class_1788 = null;
      
      private var var_27:class_1835 = null;
      
      private var var_5261:Boolean = false;
      
      private var var_1321:NumberBank;
      
      private var var_2656:class_55;
      
      private var var_1184:NumberBank;
      
      private var var_1717:class_55;
      
      private var var_871:Boolean = false;
      
      protected var var_71:int = 0;
      
      private var var_1223:int = -1;
      
      private var var_2959:int = 0;
      
      private var var_3056:int = 0;
      
      private var var_953:Boolean = false;
      
      private var var_591:Boolean = false;
      
      private var var_5102:int = 0;
      
      private var var_5087:int = 0;
      
      private var _roomDraggingAlwaysCenters:Boolean = false;
      
      private var var_677:class_55 = null;
      
      private var var_540:class_55 = null;
      
      private var _skipFurnitureCreationForNextFrame:Boolean = false;
      
      private var _mouseCursorUpdate:Boolean;
      
      private var var_671:class_55 = null;
      
      private var _gameManager:class_45;
      
      private var var_1798:Boolean;
      
      private var var_3105:int = -1;
      
      private var var_2936:int = 0;
      
      private var var_1057:int = 0;
      
      private var var_5382:int = 0;
      
      private var var_2568:int = 0;
      
      private var var_5339:Boolean = true;
      
      private var var_4759:Boolean = false;
      
      private var var_1003:RoomAreaSelectionManager;
      
      public function class_34(param1:class_15, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function get mouseEventsDisabledAboveY() : int
      {
         return var_2936;
      }
      
      public function set mouseEventsDisabledAboveY(param1:int) : void
      {
         var_2936 = param1;
      }
      
      public function get mouseEventsDisabledLeftToX() : int
      {
         return var_1057;
      }
      
      public function set mouseEventsDisabledLeftToX(param1:int) : void
      {
         var_1057 = param1;
      }
      
      public function get isInitialized() : Boolean
      {
         return var_871;
      }
      
      public function get connection() : IConnection
      {
         return _communication != null ? _communication.connection : null;
      }
      
      public function get activeRoomId() : int
      {
         return var_71;
      }
      
      public function get roomManager() : IRoomManager
      {
         return _roomManager;
      }
      
      public function get configuration() : class_16
      {
         return this;
      }
      
      protected function get eventHandler() : class_1947
      {
         return var_126;
      }
      
      private function get useOffsetScrolling() : Boolean
      {
         return true;
      }
      
      public function get gameEngine() : class_45
      {
         return _gameManager;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDRoomObjectFactory(),function(param1:IRoomObjectFactory):void
         {
            _roomObjectFactory = param1;
         }),new ComponentDependency(new IIDRoomObjectVisualizationFactory(),function(param1:IRoomObjectVisualizationFactory):void
         {
            _visualizationFactory = param1;
         }),new ComponentDependency(new IIDRoomManager(),function(param1:IRoomManager):void
         {
            _roomManager = param1;
         }),new ComponentDependency(new IIDRoomRendererFactory(),function(param1:IRoomRendererFactory):void
         {
            _roomRendererFactory = param1;
         }),new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         },(flags & 5) == 0),new ComponentDependency(new IIDHabboConfigurationManager(),null,true,[{
            "type":"complete",
            "callback":onConfigurationComplete
         }]),new ComponentDependency(new IIDHabboAdManager(),function(param1:class_56):void
         {
            _adManager = param1;
         },false,[{
            "type":"AE_ROOM_AD_SHOW",
            "callback":showRoomAd
         },{
            "type":"AE_ROOM_AD_IMAGE_LOADED",
            "callback":onRoomAdImageLoaded
         },{
            "type":"AE_ROOM_AD_IMAGE_LOADING_FAILED",
            "callback":onRoomAdImageLoaded
         }]),new ComponentDependency(new IIDSessionDataManager(),function(param1:ISessionDataManager):void
         {
            _sessionDataManager = param1;
         }),new ComponentDependency(new IIDHabboRoomSessionManager(),function(param1:IRoomSessionManager):void
         {
            _roomSessionManager = param1;
         },false,[{
            "type":"RSE_STARTED",
            "callback":onRoomSessionEvent
         },{
            "type":"RSE_ENDED",
            "callback":onRoomSessionEvent
         }]),new ComponentDependency(new IIDHabboToolbar(),function(param1:IHabboToolbar):void
         {
            _toolbar = param1;
         },false,[{
            "type":"HTE_TOOLBAR_CLICK",
            "callback":onToolbarClicked
         }]),new ComponentDependency(new IIDHabboCatalog(),function(param1:IHabboCatalog):void
         {
            _catalog = param1;
         },false),new ComponentDependency(new IIDHabboUserDefinedRoomEvents(),function(param1:IHabboUserDefinedRoomEvents):void
         {
            _roomEvents = param1;
         },false),new ComponentDependency(new IIDHabboGameManager(),function(param1:class_45):void
         {
            _gameManager = param1;
         },(flags & 4) == 0),new ComponentDependency(new IIDHabboWindowManager(),function(param1:class_38):void
         {
            _windowManager = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         var_540 = new class_55();
         var_1321 = new NumberBank(1000);
         var_1184 = new NumberBank(1000);
         var_2656 = new class_55();
         var_1717 = new class_55();
         var_677 = new class_55();
         var_126 = createRoomObjectEventHandlerInstance();
         var_761 = new class_1788(this);
         registerUpdateReceiver(this,1);
         _roomObjectFactory.addObjectEventListener(roomObjectEventHandler);
         var_1003 = new RoomAreaSelectionManager(this);
      }
      
      private function onConfigurationComplete(param1:Event) : void
      {
         if(var_27)
         {
            var_27.dispose();
            events.removeEventListener("RCL_LOADER_READY",onContentLoaderReady);
         }
         var _loc2_:DisplayObjectContainer = context.displayObjectContainer;
         var _loc3_:LoaderInfo = _loc2_.loaderInfo;
         var_27 = new class_1835(_loc3_.loaderURL);
         var_27.initialize(events,this);
         var_27.iconAssets = assets;
         var_27.iconListener = this;
         var_27.visualizationFactory = _visualizationFactory;
         _roomManager.addObjectUpdateCategory(10);
         _roomManager.addObjectUpdateCategory(20);
         _roomManager.addObjectUpdateCategory(100);
         _roomManager.addObjectUpdateCategory(200);
         _roomManager.addObjectUpdateCategory(0);
         _roomManager.setContentLoader(var_27);
         if(var_761 && _communication)
         {
            var_761.connection = _communication.connection;
         }
         _roomDraggingAlwaysCenters = getBoolean("room.dragging.always_center");
         var_27.sessionDataManager = _sessionDataManager;
         events.addEventListener("RCL_LOADER_READY",onContentLoaderReady);
      }
      
      protected function createRoomObjectEventHandlerInstance() : class_1947
      {
         return new class_1947(this);
      }
      
      override public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc1_:class_1744 = null;
         if(disposed)
         {
            return;
         }
         removeUpdateReceiver(this);
         if(var_1003 != null)
         {
            var_1003.dispose();
            var_1003 = null;
         }
         if(var_1321 != null)
         {
            var_1321.dispose();
            var_1321 = null;
         }
         if(var_1184 != null)
         {
            var_1184.dispose();
            var_1184 = null;
         }
         if(var_2656 != null)
         {
            var_2656.dispose();
         }
         if(var_1717 != null)
         {
            var_1717.dispose();
         }
         if(var_126 != null)
         {
            var_126.dispose();
            var_126 = null;
         }
         if(var_761 != null)
         {
            var_761.dispose();
            var_761 = null;
         }
         if(var_27 != null)
         {
            var_27.dispose();
            var_27 = null;
         }
         if(var_677 != null)
         {
            var_677.dispose();
            var_677 = null;
         }
         if(var_540 != null)
         {
            _loc2_ = 0;
            while(_loc2_ < var_540.length)
            {
               _loc1_ = var_540.getWithIndex(_loc2_) as class_1744;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            var_540.dispose();
            var_540 = null;
         }
         if(var_671 != null)
         {
            var_671.dispose();
            var_671 = null;
         }
         super.dispose();
      }
      
      public function set disableUpdate(param1:Boolean) : void
      {
         if(param1)
         {
            removeUpdateReceiver(this);
         }
         else
         {
            removeUpdateReceiver(this);
            registerUpdateReceiver(this,1);
         }
      }
      
      public function runUpdate() : void
      {
         update(1);
      }
      
      private function getRoomInstanceData(param1:int) : class_1744
      {
         var _loc2_:String = getRoomIdentifier(param1);
         if(var_540 != null)
         {
            var _loc3_:class_1744 = var_540.getValue(_loc2_) as class_1744;
            _loc3_ = new class_1744(param1);
            var_540.add(_loc2_,null);
         }
         return null;
      }
      
      public function setFurniStackingHeightMap(param1:int, param2:class_1934) : void
      {
         var _loc3_:class_1744 = getRoomInstanceData(param1);
         if(_loc3_ != null)
         {
            _loc3_.furniStackingHeightMap = param2;
         }
      }
      
      public function getFurniStackingHeightMap(param1:int) : class_1934
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.furniStackingHeightMap;
         }
         return null;
      }
      
      public function setWorldType(param1:int, param2:String) : void
      {
         var _loc3_:class_1744 = getRoomInstanceData(param1);
         if(_loc3_ != null)
         {
            _loc3_.worldType = param2;
         }
      }
      
      public function getWorldType(param1:int) : String
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.worldType;
         }
         return null;
      }
      
      public function getLegacyGeometry(param1:int) : class_1821
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.legacyGeometry;
         }
         return null;
      }
      
      public function getTileObjectMap(param1:int) : class_2247
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.tileObjectMap;
         }
         return null;
      }
      
      private function getActiveRoomCamera() : class_1771
      {
         return getRoomCamera(var_71);
      }
      
      private function getRoomCamera(param1:int) : class_1771
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.roomCamera;
         }
         return null;
      }
      
      public function setSelectedObjectData(param1:int, param2:class_1925) : void
      {
         var _loc3_:class_1744 = getRoomInstanceData(param1);
         if(_loc3_ != null)
         {
            _loc3_.selectedObject = param2;
            if(param2 != null)
            {
               _loc3_.placedObject = null;
            }
         }
      }
      
      public function getSelectedObjectData(param1:int) : ISelectedRoomObjectData
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.selectedObject;
         }
         return null;
      }
      
      public function setPlacedObjectData(param1:int, param2:class_1925) : void
      {
         var _loc3_:class_1744 = getRoomInstanceData(param1);
         if(_loc3_ != null)
         {
            _loc3_.placedObject = param2;
         }
      }
      
      public function getPlacedObjectData(param1:int) : ISelectedRoomObjectData
      {
         var _loc2_:class_1744 = getRoomInstanceData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.placedObject;
         }
         return null;
      }
      
      public function addObjectUpdateCategory(param1:int) : void
      {
         _roomManager.addObjectUpdateCategory(param1);
      }
      
      public function removeObjectUpdateCategory(param1:int) : void
      {
         _roomManager.removeObjectUpdateCategory(param1);
      }
      
      public function update(param1:uint) : void
      {
         RoomEnterEffect.turnVisualizationOn();
         if(_roomManager != null)
         {
            createRoomFurniture();
            _roomManager.update(param1);
            var _loc2_:int = 0;
            while(0 < _roomManager.getRoomCount())
            {
               var _loc3_:IRoomInstance = _roomManager.getRoomWithIndex(0);
               _loc2_++;
            }
            updateRoomCameras(param1);
            if(_mouseCursorUpdate)
            {
               updateMouseCursor();
            }
         }
         RoomEnterEffect.turnVisualizationOff();
      }
      
      private function updateMouseCursor() : void
      {
         _mouseCursorUpdate = false;
         var _loc1_:class_1744 = getRoomInstanceData(var_71);
         if(_loc1_ && _loc1_.hasButtonMouseCursorOwners())
         {
            Mouse.cursor = "button";
         }
         else
         {
            Mouse.cursor = "auto";
         }
      }
      
      public function requestMouseCursor(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:int = getRoomObjectCategory(param3);
         var _loc5_:String = param1;
         if("ROFCAE_MOUSE_BUTTON" !== _loc5_)
         {
            if(isGameMode && _loc4_ == 100)
            {
               var_3105 = -1;
            }
            removeButtonMouseCursorOwner(var_71,_loc4_,param2);
         }
         else
         {
            if(isGameMode && _loc4_ == 100)
            {
               var_3105 = param2;
            }
            addButtonMouseCursorOwner(var_71,_loc4_,param2);
         }
      }
      
      private function addButtonMouseCursorOwner(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:String = null;
         var _loc4_:class_1744 = null;
         var _loc6_:IRoomSession = _roomSessionManager.getSession(param1);
         if(param2 != 10 && param2 != 20 || _loc6_ != null && _loc6_.roomControllerLevel >= 1)
         {
            _loc5_ = param2 + "_" + param3;
            _loc4_ = getRoomInstanceData(param1);
            if(_loc4_ != null)
            {
               if(_loc4_.addButtonMouseCursorOwner(_loc5_))
               {
                  _mouseCursorUpdate = true;
               }
            }
         }
      }
      
      private function removeButtonMouseCursorOwner(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:class_1744 = getRoomInstanceData(param1);
         if(_loc4_ != null)
         {
            var _loc5_:String = param2 + "_" + param3;
            if(_loc4_.removeButtonMouseCursorOwner(null))
            {
               _mouseCursorUpdate = true;
            }
         }
      }
      
      public function addFloorHole(param1:int, param2:int) : void
      {
         if(param2 >= 0)
         {
            var _loc8_:IRoomObjectController = getObjectRoom(param1);
         }
      }
      
      public function removeFloorHole(param1:int, param2:int) : void
      {
         if(param2 >= 0)
         {
            var _loc4_:IRoomObjectController = getObjectRoom(param1);
            if(_loc4_ != null && null.getEventHandler() != null)
            {
               var _loc3_:String = "RORPFHUM_REMOVE";
               null.getEventHandler().processUpdateMessage(new RoomObjectRoomFloorHoleUpdateMessage(null,param2));
            }
         }
      }
      
      private function createRoomFurniture() : void
      {
         var _loc6_:int = 0;
         _loc6_ = 4;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:class_2197 = null;
         var _loc10_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc8_:String = null;
         var _loc9_:RoomInstance = null;
         var _loc5_:int = getTimer();
         var _loc12_:int = 0;
         var _loc11_:class_55 = var_540;
         do
         {
            for each(var _loc2_ in _loc11_)
            {
               _loc4_ = 0;
               _loc3_ = null;
               _loc10_ = false;
               _loc7_ = false;
               while(true)
               {
                  _loc3_ = _loc2_.getFurnitureData();
                  if(_loc3_ == null)
                  {
                     break;
                  }
                  _loc10_ = addObjectFurnitureFromData(_loc2_.roomId,_loc3_.id,_loc3_);
                  if(++_loc4_ % 4 == 0)
                  {
                     _loc1_ = getTimer();
                     if(_loc1_ - _loc5_ >= 30 && !var_1798)
                     {
                        _loc7_ = true;
                        break;
                     }
                  }
               }
               while(true)
               {
                  _loc3_ = _loc2_.getWallItemData();
                  if(!(!_loc7_ && _loc3_ != null))
                  {
                     break;
                  }
                  _loc10_ = addObjectWallItemFromData(_loc2_.roomId,_loc3_.id,_loc3_);
                  if(++_loc4_ % 4 == 0)
                  {
                     _loc1_ = getTimer();
                     if(_loc1_ - _loc5_ >= 30 && !var_1798)
                     {
                        _loc7_ = true;
                        break;
                     }
                  }
               }
               if(_loc10_ && var_1798)
               {
                  _loc8_ = getRoomIdentifier(_loc2_.roomId);
                  _loc9_ = _roomManager.getRoom(_loc8_) as RoomInstance;
                  if(!_loc9_.hasUninitializedObjects())
                  {
                     objectsInitialized(_loc8_);
                  }
               }
            }
            return;
         }
         while(!_loc7_);
         
      }
      
      private function updateRoomCameras(param1:uint) : void
      {
         var _loc7_:int = 0;
         var _loc3_:class_1744 = null;
         var _loc6_:class_1771 = null;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:IRoomObject = null;
         _loc7_ = 0;
         while(_loc7_ < var_540.length)
         {
            _loc3_ = var_540.getWithIndex(_loc7_) as class_1744;
            _loc6_ = null;
            _loc8_ = 0;
            if(_loc3_ != null)
            {
               _loc6_ = _loc3_.roomCamera;
               _loc8_ = _loc3_.roomId;
            }
            if(_loc6_ != null)
            {
               _loc5_ = _loc6_.targetId;
               _loc4_ = _loc6_.targetCategory;
               _loc9_ = getRoomObject(_loc8_,_loc5_,_loc4_);
               if(_loc9_ != null)
               {
                  if(_loc8_ != var_71 || !var_953)
                  {
                     updateRoomCamera(_loc8_,1,_loc9_.getLocation(),param1);
                  }
               }
            }
            _loc7_++;
         }
      }
      
      public function getRoomGeometry(param1:int) : RoomGeometry
      {
         var _loc2_:IRoomRenderingCanvas = getRoomCanvas(param1,1);
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.geometry as RoomGeometry;
      }
      
      public function updateRoomCamera(param1:int, param2:int, param3:IVector3d, param4:uint) : void
      {
         var _loc46_:Number = NaN;
         var _loc18_:Rectangle = null;
         var _loc26_:int = 0;
         var _loc25_:int = 0;
         var _loc41_:Rectangle = null;
         var _loc6_:Vector3d = null;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc34_:Point = null;
         var _loc17_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc12_:Matrix = null;
         var _loc36_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc30_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         var _loc7_:class_1744 = getRoomInstanceData(param1);
         if(_loc30_ == null || _loc7_ == null || _loc30_.scale != 1)
         {
            return;
         }
         var _loc45_:RoomGeometry = _loc30_.geometry as RoomGeometry;
         var _loc11_:class_1771 = _loc7_.roomCamera;
         var _loc35_:IRoomInstance = getRoom(param1);
         if(_loc45_ != null && _loc11_ != null && _loc35_ != null)
         {
            _loc46_ = Math.floor(param3.z) + 1;
            _loc18_ = getRoomCanvasRectangle(param1,param2);
            if(_loc18_ != null)
            {
               _loc26_ = Math.round(_loc18_.width);
               _loc25_ = Math.round(_loc18_.height);
               _loc41_ = getActiveRoomBoundingRectangle(param2);
               if(_loc41_ != null && (_loc41_.right < 0 || _loc41_.bottom < 0 || _loc41_.left >= _loc26_ || _loc41_.top >= _loc25_))
               {
                  _loc11_.reset();
               }
               if(_loc11_.screenWd != _loc26_ || _loc11_.screenHt != _loc25_ || _loc11_.scale != _loc45_.scale || _loc11_.geometryUpdateId != _loc45_.updateId || !Vector3d.isEqual(param3,_loc11_.targetObjectLoc) || _loc11_.isMoving)
               {
                  _loc11_.targetObjectLoc = param3;
                  _loc6_ = new Vector3d();
                  _loc6_.assign(param3);
                  _loc6_.x = Math.round(_loc6_.x);
                  _loc6_.y = Math.round(_loc6_.y);
                  _loc31_ = _loc35_.getNumber("room_min_x") - 0.5;
                  _loc32_ = _loc35_.getNumber("room_min_y") - 0.5;
                  _loc9_ = _loc35_.getNumber("room_max_x") + 0.5;
                  _loc27_ = _loc35_.getNumber("room_max_y") + 0.5;
                  _loc22_ = Math.round((_loc31_ + _loc9_) / 2);
                  _loc21_ = Math.round((_loc32_ + _loc27_) / 2);
                  _loc19_ = 2;
                  _loc34_ = new Point(_loc6_.x - _loc22_,_loc6_.y - _loc21_);
                  _loc17_ = _loc45_.scale / Math.sqrt(2);
                  _loc20_ = _loc17_ / 2;
                  _loc12_ = new Matrix();
                  _loc12_.rotate(-(_loc45_.direction.x + 90) / 180 * 3.141592653589793);
                  _loc34_ = _loc12_.transformPoint(_loc34_);
                  _loc34_.y = _loc34_.y * (_loc20_ / _loc17_);
                  _loc36_ = _loc18_.width / 2 / _loc17_ - 1;
                  _loc38_ = _loc18_.height / 2 / _loc20_ - 1;
                  _loc42_ = 0;
                  _loc40_ = 0;
                  _loc10_ = 0;
                  _loc8_ = 0;
                  var _loc5_:Point = _loc45_.getScreenPoint(new Vector3d(_loc22_,_loc21_,_loc19_));
                  if(!_loc5_)
                  {
                     return;
                  }
                  null.x += Math.round(_loc18_.width / 2);
                  null.y += Math.round(_loc18_.height / 2);
                  if(_loc41_ == null)
                  {
                     _loc45_.adjustLocation(new Vector3d(0,0),25);
                     return;
                  }
                  _loc41_.offset(-_loc30_.screenOffsetX,-_loc30_.screenOffsetY);
                  if(!(_loc41_.width > 1 && _loc41_.height > 1))
                  {
                     _loc45_.adjustLocation(new Vector3d(-30,-30),25);
                     return;
                  }
                  _loc42_ = (_loc41_.left - null.x - _loc45_.scale * 0.25) / _loc17_;
                  _loc10_ = (_loc41_.right - null.x + _loc45_.scale * 0.25) / _loc17_;
                  _loc40_ = (_loc41_.top - null.y - _loc45_.scale * 0.5) / _loc20_;
                  _loc8_ = (_loc41_.bottom - null.y + _loc45_.scale * 0.5) / _loc20_;
                  var _loc44_:Boolean = false;
                  var _loc43_:Boolean = false;
                  var _loc24_:Boolean = false;
                  var _loc23_:Boolean = false;
                  _loc14_ = Math.round((_loc10_ - _loc42_) * _loc17_);
                  if(_loc14_ < _loc18_.width)
                  {
                     _loc46_ = 2;
                     _loc34_.x = (_loc10_ + _loc42_) / 2;
                     _loc24_ = true;
                  }
                  else
                  {
                     if(_loc34_.x > _loc10_ - _loc36_)
                     {
                        _loc34_.x = _loc10_ - _loc36_;
                        _loc44_ = true;
                     }
                     if(_loc34_.x < _loc42_ + _loc36_)
                     {
                        _loc34_.x = _loc42_ + _loc36_;
                        _loc44_ = true;
                     }
                  }
                  _loc13_ = Math.round((_loc8_ - _loc40_) * _loc20_);
                  if(_loc13_ < _loc18_.height)
                  {
                     _loc46_ = 2;
                     _loc34_.y = (_loc8_ + _loc40_) / 2;
                     _loc23_ = true;
                  }
                  else
                  {
                     if(_loc34_.y > _loc8_ - _loc38_)
                     {
                        _loc34_.y = _loc8_ - _loc38_;
                        _loc43_ = true;
                     }
                     if(_loc34_.y < _loc40_ + _loc38_)
                     {
                        _loc34_.y = _loc40_ + _loc38_;
                        _loc43_ = true;
                     }
                  }
                  _loc12_.invert();
                  _loc34_ = _loc12_.transformPoint(_loc34_);
                  _loc34_.x = _loc34_.x + _loc22_;
                  _loc34_.y += _loc21_;
                  _loc33_ = 0.35;
                  _loc37_ = 0.2;
                  _loc28_ = 0.2;
                  var _loc15_:int = 10;
                  var _loc16_:int = 10;
                  if(_loc28_ * _loc26_ > 100)
                  {
                     _loc28_ = 100 / _loc26_;
                  }
                  if(_loc33_ * _loc25_ > 150)
                  {
                     _loc33_ = 150 / _loc25_;
                  }
                  if(_loc37_ * _loc25_ > 150)
                  {
                     _loc37_ = 150 / _loc25_;
                  }
                  if(_loc11_.limitedLocationX && _loc11_.screenWd == _loc26_ && _loc11_.screenHt == _loc25_)
                  {
                     _loc28_ = 0;
                  }
                  if(_loc11_.limitedLocationY && _loc11_.screenWd == _loc26_ && _loc11_.screenHt == _loc25_)
                  {
                     _loc33_ = 0;
                     _loc37_ = 0;
                  }
                  _loc18_.right *= 1 - _loc28_ * 2;
                  _loc18_.bottom *= 1 - (_loc33_ + _loc37_);
                  if(_loc18_.right < 0)
                  {
                     _loc18_.right = 0;
                  }
                  if(_loc18_.bottom < 0)
                  {
                     _loc18_.bottom = 0;
                  }
                  if(_loc33_ + _loc37_ > 0)
                  {
                     _loc18_.offset(-_loc18_.width / 2,-_loc18_.height * (_loc37_ / (_loc33_ + _loc37_)));
                  }
                  else
                  {
                     _loc18_.offset(-_loc18_.width / 2,-_loc18_.height / 2);
                  }
                  _loc5_ = _loc45_.getScreenPoint(_loc6_);
                  if(!_loc5_)
                  {
                     return;
                  }
                  null.x += _loc30_.screenOffsetX;
                  null.y += _loc30_.screenOffsetY;
                  _loc6_.z = _loc46_;
                  _loc6_.x = Math.round(_loc34_.x * 2) / 2;
                  _loc6_.y = Math.round(_loc34_.y * 2) / 2;
                  if(_loc11_.location == null)
                  {
                     _loc45_.location = _loc6_;
                     if(useOffsetScrolling)
                     {
                        _loc11_.initializeLocation(new Vector3d(0,0,0));
                     }
                     else
                     {
                        _loc11_.initializeLocation(_loc6_);
                     }
                  }
                  var _loc39_:Point = _loc45_.getScreenPoint(_loc6_);
                  var _loc29_:Vector3d = new Vector3d(0,0,0);
                  if(_loc11_.roomWd != _loc41_.width || _loc11_.roomHt != _loc41_.height || (_loc11_.screenWd != _loc26_ || _loc11_.screenHt != _loc25_))
                  {
                     _loc11_.limitedLocationX = false;
                     _loc11_.limitedLocationY = false;
                     if(useOffsetScrolling)
                     {
                        _loc11_.target = null;
                     }
                     else
                     {
                        _loc11_.target = _loc6_;
                     }
                  }
                  else
                  {
                     _loc11_.limitedLocationX = false;
                     _loc11_.limitedLocationY = false;
                  }
                  _loc11_.centeredLocX = false;
                  _loc11_.centeredLocY = false;
                  _loc11_.screenWd = _loc26_;
                  _loc11_.screenHt = _loc25_;
                  _loc11_.scale = _loc45_.scale;
                  _loc11_.geometryUpdateId = _loc45_.updateId;
                  _loc11_.roomWd = _loc41_.width;
                  _loc11_.roomHt = _loc41_.height;
                  if(!_sessionDataManager.isRoomCameraFollowDisabled)
                  {
                     if(useOffsetScrolling)
                     {
                        _loc11_.update(param4,8);
                     }
                     else
                     {
                        _loc11_.update(param4,0.5);
                     }
                  }
                  if(useOffsetScrolling)
                  {
                     _loc30_.screenOffsetX = -_loc11_.location.x;
                     _loc30_.screenOffsetY = -_loc11_.location.y;
                  }
                  else
                  {
                     _loc45_.adjustLocation(_loc11_.location,25);
                  }
               }
               else
               {
                  _loc11_.limitedLocationX = false;
                  _loc11_.limitedLocationY = false;
                  _loc11_.centeredLocX = false;
                  _loc11_.centeredLocY = false;
               }
            }
         }
      }
      
      private function onContentLoaderReady(param1:Event) : void
      {
         var_5261 = true;
         _roomManager.initialize(<nothing/>,this);
      }
      
      private function onRoomSessionEvent(param1:RoomSessionEvent) : void
      {
         switch(param1.type)
         {
            case "RSE_STARTED":
               if(var_761)
               {
                  var_761.setCurrentRoom(param1.session.roomId);
               }
               break;
            case "RSE_ENDED":
               if(var_761)
               {
                  var_761.resetCurrentRoom();
                  disposeRoom(param1.session.roomId);
               }
         }
      }
      
      private function onToolbarClicked(param1:HabboToolbarEvent) : void
      {
         var _loc2_:class_1771 = null;
         if(param1.iconId == "HTIE_ICON_MEMENU")
         {
            _loc2_ = getActiveRoomCamera();
            if(_loc2_)
            {
               _loc2_.activateFollowing(cameraFollowDuration);
               _loc2_.reset();
            }
         }
      }
      
      public function roomManagerInitialized(param1:Boolean) : void
      {
         if(param1)
         {
            var_871 = true;
            events.dispatchEvent(new RoomEngineEvent("REE_ENGINE_INITIALIZED",0));
            var _loc3_:int = 0;
            while(0 < var_677.length)
            {
               var _loc2_:class_2004 = var_677.getWithIndex(0) as class_2004;
               _loc3_++;
            }
         }
         else
         {
            class_21.log("[RoomEngine] Failed to initialize manager");
         }
      }
      
      public function setActiveRoom(param1:int) : void
      {
         var_71 = param1;
      }
      
      public function getRoomIdentifier(param1:int) : String
      {
         return String(param1);
      }
      
      private function getRoomId(param1:String) : int
      {
         var _loc2_:Array = null;
         if(param1 != null)
         {
            _loc2_ = param1.split("_");
            if(_loc2_.length > 0)
            {
               return _loc2_[0];
            }
         }
         return -1;
      }
      
      public function getRoomNumberValue(param1:int, param2:String) : Number
      {
         var _loc3_:IRoomInstance = getRoom(param1);
         if(_loc3_ != null)
         {
            if(!_loc3_.hasValueForName(param2))
            {
               return NaN;
            }
            return _loc3_.getNumber(param2);
         }
         return NaN;
      }
      
      public function getRoomStringValue(param1:int, param2:String) : String
      {
         var _loc3_:IRoomInstance = getRoom(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getString(param2);
         }
         return null;
      }
      
      public function setIsPlayingGame(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IRoomInstance = getRoom(param1);
         if(_loc4_ != null)
         {
            _loc3_ = param2 ? 1 : 0;
            _loc4_.setNumber("is_playing_game",_loc3_);
            if(_loc3_ == 0)
            {
               events.dispatchEvent(new RoomEngineEvent("REE_NORMAL_MODE",param1));
            }
            else
            {
               events.dispatchEvent(new RoomEngineEvent("REE_GAME_MODE",param1));
            }
         }
      }
      
      public function leaveSpectate() : void
      {
         events.dispatchEvent(new RoomEngineEvent("REE_ENTRANCE_AFTER_SPECTATE",var_71));
      }
      
      public function setHanditemControlBlocked(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:IRoomInstance = getRoom(param1);
         if(_loc4_ != null)
         {
            _loc3_ = param2 ? 1 : 0;
            _loc4_.setNumber("handitem_control_blocked",_loc3_);
         }
      }
      
      public function getIsPlayingGame(param1:int) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:IRoomInstance = getRoom(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getNumber("is_playing_game");
            if(_loc2_ > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getHasHanditemControlBlocked(param1:int) : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:IRoomInstance = getRoom(param1);
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.getNumber("handitem_control_blocked");
            if(_loc2_ > 0)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getActiveRoomIsPlayingGame() : Boolean
      {
         return getIsPlayingGame(var_71);
      }
      
      public function get activeRoomHasHanditemControlBlocked() : Boolean
      {
         return getHasHanditemControlBlocked(var_71);
      }
      
      public function getRoom(param1:int) : IRoomInstance
      {
         if(!var_871)
         {
            return null;
         }
         var _loc2_:String = getRoomIdentifier(param1);
         return _roomManager.getRoom(_loc2_);
      }
      
      public function initializeRoom(param1:int, param2:XML, param3:IVector3d = null, param4:Vector.<IAreaHideInfo> = null) : void
      {
         var _loc5_:String = getRoomIdentifier(param1);
         var _loc8_:class_2004 = null;
         var _loc9_:String = "111";
         var _loc10_:String = "201";
         var _loc7_:String = "1";
         if(!var_871)
         {
            _loc8_ = var_677.remove(_loc5_);
            if(_loc8_ != null)
            {
               _loc9_ = _loc8_.floorType;
               _loc10_ = _loc8_.wallType;
               _loc7_ = _loc8_.landscapeType;
               if(!param3)
               {
                  param3 = _loc8_.cameraInitPosition;
               }
            }
            _loc8_ = new class_2004(param1,param2);
            _loc8_.floorType = _loc9_;
            _loc8_.wallType = _loc10_;
            _loc8_.landscapeType = _loc7_;
            _loc8_.cameraInitPosition = param3;
            var_677.add(_loc5_,_loc8_);
            class_21.log("Room Engine not initilized yet, can not create room. Room data stored for later initialization.");
            return;
         }
         if(param2 == null)
         {
            class_21.log("Room property messages received before floor height map, will initialize when floor height map received.");
            return;
         }
         _loc8_ = var_677.remove(_loc5_);
         if(_loc8_ != null)
         {
            if(_loc8_.floorType != null && _loc8_.floorType.length > 0)
            {
               _loc9_ = _loc8_.floorType;
            }
            if(_loc8_.wallType != null && _loc8_.wallType.length > 0)
            {
               _loc10_ = _loc8_.wallType;
            }
            if(_loc8_.landscapeType != null && _loc8_.landscapeType.length > 0)
            {
               _loc7_ = _loc8_.landscapeType;
            }
            if(_loc8_.cameraInitPosition != null)
            {
               param3 = _loc8_.cameraInitPosition;
            }
         }
         var _loc11_:IRoomInstance = createRoom(_loc5_,param2,_loc9_,_loc10_,_loc7_,param3);
         if(param4 != null)
         {
            for each(var _loc6_ in param4)
            {
               updateAreaHide(param1,_loc6_.furniId,_loc6_.on,_loc6_.rootX,_loc6_.rootY,_loc6_.width,_loc6_.length,_loc6_.invert);
            }
         }
         if(_loc11_ == null)
         {
            return;
         }
         events.dispatchEvent(new RoomEngineEvent("REE_INITIALIZED",param1));
      }
      
      private function createRoom(param1:String, param2:XML, param3:String, param4:String, param5:String, param6:IVector3d) : IRoomInstance
      {
         var _loc24_:int = 0;
         var _loc11_:XML = null;
         var _loc26_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc22_:RoomObjectRoomUpdateMessage = null;
         var _loc17_:XMLList = null;
         var _loc27_:Array = null;
         var _loc10_:RoomObjectRoomMaskUpdateMessage = null;
         var _loc20_:int = 0;
         var _loc7_:XML = null;
         var _loc16_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc18_:String = null;
         var _loc21_:String = null;
         var _loc19_:Vector3d = null;
         if(!var_871)
         {
            return null;
         }
         var _loc23_:IRoomInstance = _roomManager.createRoom(param1,param2);
         if(_loc23_ == null)
         {
            return null;
         }
         var _loc29_:IRoomObjectController = null;
         _loc29_ = _loc23_.createRoomObject(-1,"room",0) as IRoomObjectController;
         _loc23_.setNumber("room_is_public",0,true);
         _loc23_.setNumber("room_z_scale",1,true);
         if(param2 != null)
         {
            _loc24_ = 0;
            if(param2.dimensions.length() == 1)
            {
               _loc11_ = param2.dimensions[0];
               _loc26_ = Number(_loc11_.@minX);
               _loc9_ = Number(_loc11_.@maxX);
               _loc25_ = Number(_loc11_.@minY);
               _loc8_ = Number(_loc11_.@maxY);
               _loc23_.setNumber("room_min_x",_loc26_);
               _loc23_.setNumber("room_max_x",_loc9_);
               _loc23_.setNumber("room_min_y",_loc25_);
               _loc23_.setNumber("room_max_y",_loc8_);
               _loc24_ += _loc26_ * 423 + _loc9_ * 671 + _loc25_ * 913 + _loc8_ * 7509;
               if(_loc29_ != null && _loc29_.getModelController() != null)
               {
                  _loc29_.getModelController().setNumber("room_random_seed",_loc24_,true);
               }
            }
            if(param6 != null)
            {
               _loc23_.setNumber("camera_init_x",param6.x);
               _loc23_.setNumber("camera_init_y",param6.y);
               _loc23_.setNumber("camera_init_z",param6.z);
            }
         }
         if(_loc29_ != null && _loc29_.getEventHandler() != null)
         {
            _loc29_.getEventHandler().initialize(param2);
            _loc22_ = null;
            if(param3 != null)
            {
               _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE",param3);
               _loc29_.getEventHandler().processUpdateMessage(_loc22_);
               _loc23_.setString("room_floor_type",param3);
            }
            if(param4 != null)
            {
               _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE",param4);
               _loc29_.getEventHandler().processUpdateMessage(_loc22_);
               _loc23_.setString("room_wall_type",param4);
            }
            if(param5 != null)
            {
               _loc22_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE",param5);
               _loc29_.getEventHandler().processUpdateMessage(_loc22_);
               _loc23_.setString("room_landscape_type",param5);
            }
            if(param2 != null)
            {
               if(param2.doors.door.length() > 0)
               {
                  _loc17_ = param2.doors.door;
                  _loc27_ = ["x","y","z","dir"];
                  _loc10_ = null;
                  _loc20_ = 0;
                  while(_loc20_ < _loc17_.length())
                  {
                     _loc7_ = _loc17_[_loc20_];
                     if(class_2119.checkRequiredAttributes(_loc7_,_loc27_))
                     {
                        _loc16_ = Number(_loc7_.@x);
                        _loc14_ = Number(_loc7_.@y);
                        _loc13_ = Number(_loc7_.@z);
                        _loc12_ = Number(_loc7_.@dir);
                        _loc18_ = "door";
                        _loc21_ = "door_" + _loc20_;
                        _loc19_ = new Vector3d(_loc16_,_loc14_,_loc13_);
                        _loc10_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK",_loc21_,_loc18_,_loc19_,"hole");
                        _loc29_.getEventHandler().processUpdateMessage(_loc10_);
                        if(_loc12_ == 90 || _loc12_ == 180)
                        {
                           if(_loc12_ == 90)
                           {
                              _loc23_.setNumber("room_door_x",_loc16_ - 0.5,true);
                              _loc23_.setNumber("room_door_y",_loc14_,true);
                           }
                           if(_loc12_ == 180)
                           {
                              _loc23_.setNumber("room_door_x",_loc16_,true);
                              _loc23_.setNumber("room_door_y",_loc14_ - 0.5,true);
                           }
                           _loc23_.setNumber("room_door_z",_loc13_,true);
                           _loc23_.setNumber("room_door_dir",_loc12_,true);
                        }
                     }
                     _loc20_++;
                  }
               }
            }
         }
         _loc23_.createRoomObject(-2,"tile_cursor",200);
         if(!getBoolean("avatar.widget.enabled"))
         {
            _loc23_.createRoomObject(-3,"selection_arrow",200);
         }
         return _loc23_;
      }
      
      public function getObjectRoom(param1:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),-1,0);
      }
      
      public function updateObjectRoom(param1:int, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false) : Boolean
      {
         var _loc10_:IRoomObjectController = getObjectRoom(param1);
         var _loc7_:IRoomInstance = getRoom(param1);
         if(_loc10_ == null)
         {
            var _loc6_:String = getRoomIdentifier(param1);
            var _loc8_:class_2004 = var_677.getValue(null);
            if(_loc8_ == null)
            {
               _loc8_ = new class_2004(param1,null);
               var_677.add(null,null);
            }
            if(param2 != null)
            {
               null.floorType = param2;
            }
            if(param3 != null)
            {
               null.wallType = param3;
            }
            if(param4 != null)
            {
               null.landscapeType = param4;
            }
            return true;
         }
         if(_loc10_.getEventHandler() == null)
         {
            return false;
         }
         var _loc9_:RoomObjectRoomUpdateMessage = null;
         if(param2 != null)
         {
            if(_loc7_ != null && !param5)
            {
               _loc7_.setString("room_floor_type",param2);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_FLOOR_UPDATE",param2);
            _loc10_.getEventHandler().processUpdateMessage(_loc9_);
         }
         if(param3 != null)
         {
            if(_loc7_ != null && !param5)
            {
               _loc7_.setString("room_wall_type",param3);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_WALL_UPDATE",param3);
            _loc10_.getEventHandler().processUpdateMessage(_loc9_);
         }
         if(param4 != null)
         {
            if(_loc7_ != null && !param5)
            {
               _loc7_.setString("room_landscape_type",param4);
            }
            _loc9_ = new RoomObjectRoomUpdateMessage("RORUM_ROOM_LANDSCAPE_UPDATE",param4);
            _loc10_.getEventHandler().processUpdateMessage(_loc9_);
         }
         return true;
      }
      
      public function updateObjectRoomColor(param1:int, param2:uint, param3:int, param4:Boolean) : Boolean
      {
         var _loc6_:IRoomObjectController = getObjectRoom(param1);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         var _loc5_:RoomObjectRoomColorUpdateMessage = null;
         _loc5_ = new RoomObjectRoomColorUpdateMessage("RORCUM_BACKGROUND_COLOR",param2,param3,param4);
         _loc6_.getEventHandler().processUpdateMessage(_loc5_);
         events.dispatchEvent(new RoomEngineRoomColorEvent(param1,param2,param3,param4));
         return true;
      }
      
      public function updateObjectRoomBackgroundColor(param1:int, param2:Boolean, param3:int, param4:int, param5:int) : Boolean
      {
         var _loc6_:IRoomObjectController = getObjectRoom(param1);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         events.dispatchEvent(new RoomEngineHSLColorEnableEvent("ROHSLCEE_ROOM_BACKGROUND_COLOR",param1,param2,param3,param4,param5));
         return true;
      }
      
      public function updateObjectRoomVisibilities(param1:int, param2:Boolean, param3:Boolean = true) : Boolean
      {
         var _loc4_:IRoomObjectController = getObjectRoom(param1);
         if(_loc4_ == null || _loc4_.getEventHandler() == null)
         {
            return false;
         }
         var _loc5_:RoomObjectRoomPlaneVisibilityUpdateMessage = null;
         _loc5_ = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_WALL_VISIBILITY",param2);
         _loc4_.getEventHandler().processUpdateMessage(_loc5_);
         _loc5_ = new RoomObjectRoomPlaneVisibilityUpdateMessage("RORPVUM_FLOOR_VISIBILITY",param3);
         _loc4_.getEventHandler().processUpdateMessage(_loc5_);
         return true;
      }
      
      public function updateObjectRoomPlaneThicknesses(param1:int, param2:Number, param3:Number) : Boolean
      {
         var _loc4_:IRoomObjectController = getObjectRoom(param1);
         if(_loc4_ == null || _loc4_.getEventHandler() == null)
         {
            return false;
         }
         var _loc5_:RoomObjectRoomPlanePropertyUpdateMessage = null;
         _loc5_ = new RoomObjectRoomPlanePropertyUpdateMessage("RORPPUM_WALL_THICKNESS",param2);
         _loc4_.getEventHandler().processUpdateMessage(_loc5_);
         _loc5_ = new RoomObjectRoomPlanePropertyUpdateMessage("RORPVUM_FLOOR_THICKNESS",param3);
         _loc4_.getEventHandler().processUpdateMessage(_loc5_);
         return true;
      }
      
      public function updateAreaHide(param1:int, param2:int, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:Boolean) : Boolean
      {
         var _loc10_:RoomObjectRoomFloorHoleUpdateMessage = null;
         var _loc9_:RoomEngineAreaHideStateWidgetEvent = new RoomEngineAreaHideStateWidgetEvent(param1,param2,10,param3);
         events.dispatchEvent(_loc9_);
         var _loc11_:IRoomObjectController = getObjectRoom(param1);
         if(_loc11_ == null || _loc11_.getEventHandler() == null)
         {
            return false;
         }
         if(param3)
         {
            _loc10_ = new RoomObjectRoomFloorHoleUpdateMessage("RORPFHUM_ADD",param2,param4,param5,param6,param7,param8);
         }
         else
         {
            _loc10_ = new RoomObjectRoomFloorHoleUpdateMessage("RORPFHUM_REMOVE",param2);
         }
         _loc11_.getEventHandler().processUpdateMessage(_loc10_);
         return true;
      }
      
      public function disposeRoom(param1:int) : void
      {
         var _loc2_:String = getRoomIdentifier(param1);
         _roomManager.disposeRoom(_loc2_);
         var _loc3_:class_1744 = var_540.remove(_loc2_);
         if(_loc3_ != null)
         {
            _loc3_.dispose();
         }
         events.dispatchEvent(new RoomEngineEvent("REE_DISPOSED",param1));
      }
      
      public function setOwnUserId(param1:int, param2:int) : void
      {
         var _loc3_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc3_)
         {
            _loc3_.ownUserRoomId = param2;
         }
         var _loc4_:class_1771 = getRoomCamera(param1);
         if(_loc4_ != null)
         {
            _loc4_.targetId = param2;
            _loc4_.targetCategory = 100;
            _loc4_.activateFollowing(cameraFollowDuration);
         }
      }
      
      public function createRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int) : DisplayObject
      {
         var _loc17_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Vector3d = null;
         var _loc15_:Vector3d = null;
         var _loc8_:Sprite = null;
         var _loc11_:String = getRoomIdentifier(param1);
         var _loc9_:IRoomInstance = _roomManager.getRoom(_loc11_);
         if(_loc9_ == null)
         {
            return null;
         }
         var _loc6_:IRoomRenderer = _loc9_.getRenderer() as IRoomRenderer;
         if(_loc6_ == null)
         {
            _loc6_ = _roomRendererFactory.createRenderer();
         }
         if(_loc6_ == null)
         {
            return null;
         }
         _loc6_.roomObjectVariableAccurateZ = "object_accurate_z_value";
         _loc9_.setRenderer(_loc6_);
         var _loc7_:IRoomRenderingCanvas = _loc6_.createCanvas(param2,param3,param4,param5);
         if(_loc7_ == null)
         {
            return null;
         }
         _loc7_.mouseListener = var_126;
         if(_loc7_.geometry != null)
         {
            _loc7_.geometry.z_scale = _loc9_.getNumber("room_z_scale");
         }
         if(_loc7_.geometry != null)
         {
            _loc17_ = _loc9_.getNumber("room_door_x");
            _loc16_ = _loc9_.getNumber("room_door_y");
            _loc14_ = _loc9_.getNumber("room_door_z");
            _loc12_ = _loc9_.getNumber("room_door_dir");
            _loc13_ = new Vector3d(_loc17_,_loc16_,_loc14_);
            _loc15_ = null;
            if(_loc12_ == 90)
            {
               _loc15_ = new Vector3d(-2000,0,0);
            }
            if(_loc12_ == 180)
            {
               _loc15_ = new Vector3d(0,-2000,0);
            }
            _loc7_.geometry.setDisplacement(_loc13_,_loc15_);
         }
         var _loc10_:Sprite = _loc7_.displayObject as Sprite;
         if(_loc10_ != null)
         {
            _loc8_ = new Sprite();
            _loc8_.name = "overlay";
            _loc8_.mouseEnabled = false;
            _loc10_.addChild(_loc8_);
         }
         return _loc10_;
      }
      
      public function setRoomCanvasScale(param1:int, param2:int, param3:Number, param4:Point = null, param5:Point = null, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void
      {
         if(!getBoolean("zoom.enabled"))
         {
            return;
         }
         if(!param7)
         {
            param3 = param6 ? -1 : (param3 < 1 ? 0.5 : Math.floor(param3));
         }
         var _loc9_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc9_ != null)
         {
            _loc9_.setScale(param3,param4,param5,param8);
            events.dispatchEvent(new RoomEngineEvent("REE_ROOM_ZOOMED",param1));
         }
      }
      
      public function getRoomCanvasScale(param1:int = -1000, param2:int = -1) : Number
      {
         if(param1 == -1000)
         {
            param1 = var_71;
         }
         if(param2 == -1)
         {
            param2 = var_1223;
         }
         var _loc3_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc3_ == null)
         {
            return 1;
         }
         return _loc3_.scale;
      }
      
      public function getRoomCanvas(param1:int, param2:int) : IRoomRenderingCanvas
      {
         var _loc3_:String = getRoomIdentifier(param1);
         var _loc6_:IRoomInstance = _roomManager.getRoom(_loc3_);
         if(_loc6_ == null)
         {
            return null;
         }
         var _loc4_:IRoomRenderer = _loc6_.getRenderer() as IRoomRenderer;
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.getCanvas(param2);
      }
      
      public function modifyRoomCanvas(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         var _loc5_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc5_ == null)
         {
            return false;
         }
         _loc5_.initialize(param3,param4);
         return true;
      }
      
      public function setRoomCanvasMask(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc4_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc4_ == null)
         {
            return;
         }
         _loc4_.useMask = param3;
      }
      
      private function getRoomCanvasRectangle(param1:int, param2:int) : Rectangle
      {
         var _loc3_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return new Rectangle(0,0,_loc3_.width,_loc3_.height);
      }
      
      public function getRoomCanvasGeometry(param1:int, param2:int = -1) : IRoomGeometry
      {
         if(param2 == -1)
         {
            param2 = var_1223;
         }
         var _loc3_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.geometry;
      }
      
      public function getRoomCanvasScreenOffset(param1:int, param2:int = -1) : Point
      {
         if(param2 == -1)
         {
            param2 = var_1223;
         }
         var _loc3_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc3_ == null)
         {
            return null;
         }
         return new Point(_loc3_.screenOffsetX,_loc3_.screenOffsetY);
      }
      
      public function setRoomCanvasScreenOffset(param1:int, param2:int, param3:Point) : Boolean
      {
         var _loc4_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(_loc4_ == null || param3 == null)
         {
            return false;
         }
         _loc4_.screenOffsetX = param3.x;
         _loc4_.screenOffsetY = param3.y;
         return true;
      }
      
      public function snapshotRoomCanvasToBitmap(param1:int, param2:int, param3:BitmapData, param4:Matrix, param5:Boolean) : Boolean
      {
         var _loc7_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(!_loc7_)
         {
            return false;
         }
         var _loc6_:DisplayObject = _loc7_.displayObject;
         if(!_loc6_)
         {
            return false;
         }
         param3.draw(_loc6_,param4,null,null,null,param5);
         return true;
      }
      
      private function handleRoomDragging(param1:IRoomRenderingCanvas, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean) : Boolean
      {
         if(var_1798)
         {
            return false;
         }
         if(var_1003.areaSelectionState == RoomAreaSelectionManager.SELECTING)
         {
            var_953 = false;
            var_591 = false;
            return false;
         }
         var _loc9_:int = param2 - var_2959;
         var _loc8_:int = param3 - var_3056;
         if(param4 == "mouseDown")
         {
            if(!param5 && !param6 && !param7 && !isDecorateMode)
            {
               var_953 = true;
               var_591 = false;
               var_5102 = var_2959;
               var_5087 = var_3056;
               var_2568 = var_1057;
               var_1057 = 0;
            }
         }
         else if(param4 == "mouseUp")
         {
            if(var_953)
            {
               var_953 = false;
               if(var_591)
               {
                  var _loc10_:class_1744 = getRoomInstanceData(var_71);
                  if(_loc10_ != null)
                  {
                     var _loc11_:class_1771 = null.roomCamera;
                     if(_loc11_ != null)
                     {
                        if(useOffsetScrolling)
                        {
                           if(!null.isMoving)
                           {
                              null.centeredLocX = false;
                              null.centeredLocY = false;
                           }
                           null.resetLocation(new Vector3d(-param1.screenOffsetX,-param1.screenOffsetY));
                        }
                        if(_roomDraggingAlwaysCenters)
                        {
                           null.reset();
                        }
                     }
                  }
                  events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_END",var_71));
               }
            }
            if(var_2568 != 0)
            {
               var_1057 = var_2568;
               var_2568 = 0;
            }
         }
         else if(param4 == "mouseMove")
         {
            if(var_953)
            {
               if(!var_591)
               {
                  _loc9_ = param2 - var_5102;
                  _loc8_ = param3 - var_5087;
                  if(_loc9_ <= -15 || _loc9_ >= 15 || _loc8_ <= -15 || _loc8_ >= 15)
                  {
                     var_591 = true;
                     events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START",var_71));
                  }
                  _loc9_ = 0;
                  _loc8_ = 0;
               }
               if(_loc9_ != 0 || _loc8_ != 0)
               {
                  param1.screenOffsetX += _loc9_;
                  param1.screenOffsetY += _loc8_;
                  if(!var_591)
                  {
                     events.dispatchEvent(new RoomEngineDragWithMouseEvent("REDWME_DRAG_START",var_71));
                  }
                  var_591 = true;
               }
            }
         }
         else if(param4 == "click" || param4 == "doubleClick")
         {
            var_953 = false;
            if(var_591)
            {
               var_591 = false;
               return true;
            }
         }
         return false;
      }
      
      public function handleRoomCanvasMouseEvent(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void
      {
         var _loc12_:Number = NaN;
         var _loc10_:Sprite = null;
         var _loc11_:Sprite = null;
         var _loc14_:String = null;
         var _loc13_:RoomObjectEvent = null;
         if(var_2936 > 0 && param3 < var_2936)
         {
            return;
         }
         if(var_1057 > 0 && param2 < var_1057)
         {
            return;
         }
         var _loc9_:IRoomRenderingCanvas = getRoomCanvas(var_71,param1);
         if(_loc9_ != null)
         {
            if(_sessionDataManager.isPerkAllowed("MOUSE_ZOOM") && param4 == "click" && param6 && param5)
            {
               _loc12_ = Number(param7 ? _loc9_.scale >> 1 : (_loc9_.scale < 1 ? 1 : _loc9_.scale << 1));
               setRoomCanvasScale(activeRoomId,var_1223,_loc12_,new Point(param2,param3));
               return;
            }
            _loc10_ = getOverlaySprite(_loc9_);
            _loc11_ = getOverlayIconSprite(_loc10_,"object_icon_sprite");
            if(_loc11_ != null)
            {
               var _loc15_:Rectangle = _loc11_.getRect(_loc11_);
               _loc11_.x = param2 - null.width / 2;
               _loc11_.y = param3 - null.height / 2;
            }
            if(param4 == "click" && var_1003.finishSelecting())
            {
               var_1003.finishSelecting();
            }
            else if(!handleRoomDragging(_loc9_,param2,param3,param4,param5,param6,param7))
            {
               if(!_loc9_.handleMouseEvent(param2,param3,param4,param5,param6,param7,param8))
               {
                  _loc14_ = "";
                  if(param4 == "click")
                  {
                     if(events != null)
                     {
                        events.dispatchEvent(new RoomEngineObjectEvent("REOE_DESELECTED",var_71,-1,-2));
                     }
                     _loc14_ = "ROE_MOUSE_CLICK";
                  }
                  else if(param4 == "mouseMove")
                  {
                     _loc14_ = "ROE_MOUSE_MOVE";
                  }
                  else if(param4 == "mouseDown")
                  {
                     _loc14_ = "ROE_MOUSE_DOWN";
                  }
                  if(var_126 != null)
                  {
                     _loc13_ = new RoomObjectMouseEvent(_loc14_,getRoomObject(var_71,-1,0),null,param5);
                     var_126.handleRoomObjectEvent(_loc13_,var_71);
                  }
               }
            }
            var_1223 = param1;
            var_2959 = param2;
            var_3056 = param3;
         }
      }
      
      private function getOverlaySprite(param1:IRoomRenderingCanvas) : Sprite
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Sprite = param1.displayObject as Sprite;
         if(_loc3_ == null)
         {
            return null;
         }
         return _loc3_.getChildByName("overlay") as Sprite;
      }
      
      private function addOverlayIconSprite(param1:Sprite, param2:String, param3:BitmapData) : Sprite
      {
         if(param1 == null || param3 == null)
         {
            return null;
         }
         var _loc5_:Sprite = getOverlayIconSprite(param1,param2);
         if(_loc5_ != null)
         {
            return null;
         }
         _loc5_ = new Sprite();
         _loc5_.name = param2;
         _loc5_.mouseEnabled = false;
         var _loc4_:Bitmap = new Bitmap(param3);
         _loc5_.addChild(_loc4_);
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      private function removeOverlayIconSprite(param1:Sprite, param2:String) : Boolean
      {
         var _loc5_:int = 0;
         var _loc4_:Sprite = null;
         if(param1 == null)
         {
            return false;
         }
         _loc5_ = param1.numChildren - 1;
         while(_loc5_ >= 0)
         {
            _loc4_ = param1.getChildAt(_loc5_) as Sprite;
            if(_loc4_ != null)
            {
               if(_loc4_.name == param2)
               {
                  param1.removeChildAt(_loc5_);
                  var _loc3_:Bitmap = _loc4_.getChildAt(0) as Bitmap;
                  return true;
               }
            }
            _loc5_--;
         }
         return false;
      }
      
      private function getOverlayIconSprite(param1:Sprite, param2:String) : Sprite
      {
         var _loc4_:int = 0;
         var _loc3_:Sprite = null;
         if(param1 == null)
         {
            return null;
         }
         _loc4_ = param1.numChildren - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = param1.getChildAt(_loc4_) as Sprite;
            if(_loc3_ != null)
            {
               if(_loc3_.name == param2)
               {
                  return _loc3_;
               }
            }
            _loc4_--;
         }
         return null;
      }
      
      public function setObjectMoverIconSprite(param1:int, param2:int, param3:Boolean, param4:String = null, param5:IStuffData = null, param6:int = -1, param7:int = -1, param8:String = null) : void
      {
         var _loc13_:String = null;
         var _loc12_:int = 0;
         var _loc15_:class_2198 = null;
         if(param3)
         {
            _loc15_ = getRoomObjectImage(var_71,param1,param2,new Vector3d(),1,null);
         }
         else if(var_27 != null)
         {
            _loc13_ = null;
            _loc12_ = 0;
            if(param2 == 10)
            {
               _loc13_ = var_27.getActiveObjectType(param1);
               _loc12_ = var_27.getActiveObjectColorIndex(param1);
            }
            else if(param2 == 20)
            {
               _loc13_ = var_27.getWallItemType(param1,param4);
               _loc12_ = var_27.getWallItemColorIndex(param1);
            }
            if(param2 == 100)
            {
               _loc13_ = RoomObjectUserTypes.getName(param1);
               if(_loc13_ == "pet")
               {
                  _loc13_ = getPetType(param4);
                  var _loc14_:PetFigureData = new PetFigureData(param4);
                  _loc15_ = getPetImage(null.typeId,null.paletteId,null.color,new Vector3d(180),64,null,true,0,null.customParts,param8);
               }
               else
               {
                  _loc15_ = getGenericRoomObjectImage(_loc13_,param4,new Vector3d(180),1,null,0,null,param5,param6,param7,param8);
               }
            }
            else
            {
               _loc15_ = getGenericRoomObjectImage(_loc13_,String(_loc12_),new Vector3d(),1,null,0,param4,param5,param6,param7,param8);
            }
         }
         if(_loc15_ == null || _loc15_.data == null)
         {
            return;
         }
         var _loc9_:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
         if(_loc9_ != null)
         {
            var _loc10_:Sprite = getOverlaySprite(_loc9_);
            removeOverlayIconSprite(null,"object_icon_sprite");
            var _loc11_:Sprite = addOverlayIconSprite(null,"object_icon_sprite",_loc15_.data);
            if(_loc11_ != null)
            {
               null.x = var_2959 - _loc15_.data.width / 2;
               null.y = var_3056 - _loc15_.data.height / 2;
            }
         }
      }
      
      public function setObjectMoverIconSpriteVisible(param1:Boolean) : void
      {
         var _loc2_:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
         if(_loc2_ != null)
         {
            var _loc3_:Sprite = getOverlaySprite(_loc2_);
            var _loc4_:Sprite = getOverlayIconSprite(null,"object_icon_sprite");
            if(_loc4_ != null)
            {
               null.visible = param1;
            }
         }
      }
      
      public function getObjectMoverIconSpriteVisible() : Boolean
      {
         var _loc1_:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
         if(_loc1_ != null)
         {
            var _loc2_:Sprite = getOverlaySprite(_loc1_);
            var _loc3_:Sprite = getOverlayIconSprite(null,"object_icon_sprite");
         }
         return false;
      }
      
      public function removeObjectMoverIconSprite() : void
      {
         var _loc1_:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
         if(_loc1_ != null)
         {
            var _loc2_:Sprite = getOverlaySprite(_loc1_);
            removeOverlayIconSprite(null,"object_icon_sprite");
         }
      }
      
      public function getRoomObjectCount(param1:int, param2:int) : int
      {
         if(!var_871)
         {
            return 0;
         }
         var _loc3_:String = getRoomIdentifier(param1);
         var _loc4_:IRoomInstance = _roomManager.getRoom(_loc3_);
         if(_loc4_ == null)
         {
            return 0;
         }
         return _loc4_.getObjectCount(param2);
      }
      
      public function getRoomObject(param1:int, param2:int, param3:int) : IRoomObject
      {
         if(!var_871)
         {
            return null;
         }
         var _loc4_:String = getRoomIdentifier(param1);
         if(param1 == 0)
         {
            _loc4_ = "temporary_room";
         }
         return getObject(_loc4_,param2,param3);
      }
      
      public function getObjectsByCategory(param1:int) : Array
      {
         var _loc2_:IRoomInstance = null;
         if(_roomManager != null)
         {
            _loc2_ = _roomManager.getRoom(getRoomIdentifier(var_71));
         }
         if(_loc2_ == null)
         {
            return [];
         }
         return _loc2_.getObjects(param1);
      }
      
      public function getRoomObjectWithIndex(param1:int, param2:int, param3:int) : IRoomObject
      {
         if(!var_871)
         {
            return null;
         }
         var _loc4_:String = getRoomIdentifier(param1);
         var _loc5_:IRoomInstance = _roomManager.getRoom(_loc4_);
         if(_loc5_ == null)
         {
            return null;
         }
         return _loc5_.getObjectWithIndex(param2,param3);
      }
      
      public function getRoomObjects(param1:int, param2:int) : Array
      {
         if(var_871)
         {
            var _loc3_:String = getRoomIdentifier(param1);
            var _loc4_:IRoomInstance = _roomManager.getRoom(null);
            if(_loc4_ != null)
            {
               return null.getObjects(param2);
            }
         }
         return [];
      }
      
      public function modifyRoomObject(param1:int, param2:int, param3:String) : Boolean
      {
         if(var_126 != null)
         {
            return var_126.modifyRoomObject(var_71,param1,param2,param3);
         }
         return false;
      }
      
      public function modifyRoomObjectDataWithMap(param1:int, param2:int, param3:String, param4:class_55) : Boolean
      {
         if(var_126 != null)
         {
            if(param2 == 10)
            {
               return var_126.modifyRoomObjectData(var_71,param1,param2,param3,param4);
            }
         }
         return false;
      }
      
      public function modifyRoomObjectData(param1:int, param2:int, param3:String, param4:String) : Boolean
      {
         if(var_126 != null)
         {
            if(param2 == 20)
            {
               return var_126.modifyWallItemData(var_71,param1,param3,param4);
            }
         }
         return false;
      }
      
      public function deleteRoomObject(param1:int, param2:int) : Boolean
      {
         if(var_126 != null)
         {
            if(param2 == 20)
            {
               return var_126.deleteWallItem(var_71,param1);
            }
         }
         return false;
      }
      
      public function initializeRoomObjectInsert(param1:String, param2:int, param3:int, param4:int, param5:String = null, param6:IStuffData = null, param7:int = -1, param8:int = -1, param9:String = null, param10:Boolean = false) : Boolean
      {
         var _loc11_:IRoomInstance = getRoom(var_71);
         if(_loc11_ == null || _loc11_.getNumber("room_is_public") != 0)
         {
            return false;
         }
         if(var_126 != null)
         {
            return var_126.initializeRoomObjectInsert(param1,var_71,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         }
         return false;
      }
      
      public function cancelRoomObjectInsert() : void
      {
         if(var_126 != null)
         {
            var_126.cancelRoomObjectInsert(var_71);
         }
      }
      
      public function useRoomObjectInActiveRoom(param1:int, param2:int) : Boolean
      {
         var _loc3_:IRoomObjectEventHandler = null;
         var _loc4_:IRoomObject = getRoomObject(var_71,param1,param2);
         if(_loc4_ != null)
         {
            _loc3_ = _loc4_.getMouseHandler() as IRoomObjectEventHandler;
            if(_loc3_ != null)
            {
               _loc3_.useObject();
               return true;
            }
         }
         return false;
      }
      
      private function getRoomObjectAdURL(param1:String) : String
      {
         if(var_27 != null)
         {
            return var_27.getRoomObjectAdURL(param1);
         }
         return "";
      }
      
      public function setRoomObjectAlias(param1:String, param2:String) : void
      {
         if(var_27 != null)
         {
            var_27.setRoomObjectAlias(param1,param2);
         }
      }
      
      public function getRoomObjectCategory(param1:String) : int
      {
         if(var_27 != null)
         {
            return var_27.getObjectCategory(param1);
         }
         return -2;
      }
      
      public function getFurnitureType(param1:int) : String
      {
         if(var_27 != null)
         {
            return var_27.getActiveObjectType(param1);
         }
         return "";
      }
      
      public function getFurnitureTypeId(param1:String) : int
      {
         if(var_27 != null)
         {
            return var_27.getActiveObjectTypeId(param1);
         }
         return 0;
      }
      
      public function getWallItemType(param1:int, param2:String = null) : String
      {
         if(var_27 != null)
         {
            return var_27.getWallItemType(param1,param2);
         }
         return "";
      }
      
      public function getPetTypeId(param1:String) : int
      {
         var _loc2_:Array = null;
         var _loc3_:int = -1;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length > 1)
            {
               _loc3_ = parseInt(_loc2_[0]);
            }
         }
         return _loc3_;
      }
      
      private function getPetType(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 != null)
         {
            _loc2_ = param1.split(" ");
            if(_loc2_.length > 1)
            {
               _loc3_ = parseInt(_loc2_[0]);
               if(var_27 != null)
               {
                  return var_27.getPetType(_loc3_);
               }
               return "pet";
            }
         }
         return null;
      }
      
      public function getPetColor(param1:int, param2:int) : PetColorResult
      {
         if(var_27 != null)
         {
            return var_27.getPetColor(param1,param2);
         }
         return null;
      }
      
      public function getPetColorsByTag(param1:int, param2:String) : Array
      {
         if(var_27 != null)
         {
            return var_27.getPetColorsByTag(param1,param2);
         }
         return null;
      }
      
      public function getPetLayerIdForTag(param1:int, param2:String) : int
      {
         if(var_27 != null)
         {
            return var_27.getPetLayerIdForTag(param1,param2);
         }
         return -1;
      }
      
      public function getPetDefaultPalette(param1:int, param2:String) : PetColorResult
      {
         if(var_27 != null)
         {
            return var_27.getPetDefaultPalette(param1,param2);
         }
         return null;
      }
      
      private function getFurnitureColorIndex(param1:int) : int
      {
         if(var_27 != null)
         {
            return var_27.getActiveObjectColorIndex(param1);
         }
         return 0;
      }
      
      private function getWallItemColorIndex(param1:int) : int
      {
         if(var_27 != null)
         {
            return var_27.getWallItemColorIndex(param1);
         }
         return 0;
      }
      
      public function getSelectionArrow(param1:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),-3,200);
      }
      
      public function getTileCursor(param1:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),-2,200);
      }
      
      public function setTileCursorState(param1:int, param2:int) : void
      {
         var _loc4_:RoomObjectDataUpdateMessage = null;
         var _loc3_:IRoomObjectController = getTileCursor(param1);
         if(_loc3_ != null && _loc3_.getEventHandler() != null)
         {
            _loc4_ = new RoomObjectDataUpdateMessage(param2,null);
            _loc3_.getEventHandler().processUpdateMessage(_loc4_);
         }
      }
      
      public function toggleTileCursorVisibility(param1:int, param2:Boolean) : void
      {
         var _loc4_:RoomObjectTileCursorUpdateMessage = null;
         var _loc3_:IRoomObjectController = getTileCursor(param1);
         if(_loc3_ != null && _loc3_.getEventHandler() != null)
         {
            _loc4_ = new RoomObjectTileCursorUpdateMessage(null,0,param2,"",true);
            _loc3_.getEventHandler().processUpdateMessage(_loc4_);
         }
      }
      
      public function addObjectFurniture(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1) : Boolean
      {
         var _loc16_:class_1744 = getRoomInstanceData(param1);
         if(_loc16_ != null)
         {
            var _loc17_:class_2197 = new class_2197(param2,param3,null,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15);
            _loc16_.addFurnitureData(null);
         }
         return true;
      }
      
      public function addObjectFurnitureByName(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN) : Boolean
      {
         var _loc9_:class_1744 = getRoomInstanceData(param1);
         if(_loc9_ != null)
         {
            var _loc10_:class_2197 = new class_2197(param2,0,param3,param4,param5,param6,param7,param8,0);
            _loc9_.addFurnitureData(null);
         }
         return true;
      }
      
      private function addObjectFurnitureFromData(param1:int, param2:int, param3:class_2197) : Boolean
      {
         if(param3 == null)
         {
            var _loc4_:class_1744 = getRoomInstanceData(param1);
            if(_loc4_ != null)
            {
               param3 = null.getFurnitureDataWithId(param2);
            }
         }
         if(param3 == null)
         {
            return false;
         }
         var _loc9_:String = param3.type;
         if(_loc9_ == null)
         {
            _loc9_ = getFurnitureType(param3.typeId);
            var _loc6_:Boolean = true;
         }
         var _loc7_:int = getFurnitureColorIndex(param3.typeId);
         var _loc8_:String = getRoomObjectAdURL(_loc9_);
         if(_loc9_ == null)
         {
            _loc9_ = "";
         }
         var _loc10_:IRoomObjectController = createObjectFurniture(param1,param2,_loc9_);
         if(_loc10_ == null)
         {
            return false;
         }
         if(_loc10_ != null && _loc10_.getModelController() != null && false)
         {
            _loc10_.getModelController().setNumber("furniture_color",_loc7_,true);
            _loc10_.getModelController().setNumber("furniture_type_id",param3.typeId,true);
            _loc10_.getModelController().setString("furniture_ad_url",_loc8_,true);
            _loc10_.getModelController().setNumber("furniture_real_room_object",param3.realRoomObject ? 1 : 0,false);
            _loc10_.getModelController().setNumber("furniture_expiry_time",param3.expiryTime);
            _loc10_.getModelController().setNumber("furniture_expirty_timestamp",getTimer());
            _loc10_.getModelController().setNumber("furniture_usage_policy",param3.usagePolicy);
            _loc10_.getModelController().setNumber("furniture_owner_id",param3.ownerId);
            _loc10_.getModelController().setString("furniture_owner_name",param3.ownerName);
            _loc10_.getModelController().setNumber("furniture_extra",param3.extra);
         }
         if(!updateObjectFurniture(param1,param2,param3.loc,param3.dir,param3.state,param3.data,param3.extra))
         {
            return false;
         }
         if(param3.sizeZ >= 0)
         {
            if(!updateObjectFurnitureHeight(param1,param2,param3.sizeZ))
            {
               return false;
            }
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED",param1,param2,10));
         }
         var _loc5_:ISelectedRoomObjectData = getPlacedObjectData(param1);
         if(_loc5_ && Math.abs(_loc5_.id) == param2 && _loc5_.category == 10)
         {
            selectRoomObject(param1,param2,10);
         }
         if(_loc10_.isInitialized() && param3.synchronized)
         {
            addObjectToTileMap(param1,_loc10_);
         }
         return true;
      }
      
      public function changeObjectState(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:IStuffData = null;
         var _loc7_:RoomObjectDataUpdateMessage = null;
         var _loc8_:IRoomObjectController = getObject(getRoomIdentifier(param1),param2,param3);
         if(_loc8_ != null && _loc8_.getModelController() != null)
         {
            _loc6_ = Number(_loc8_.getModelController().getNumber("furniture_automatic_state_index"));
            if(isNaN(_loc6_))
            {
               _loc6_ = 1;
            }
            else
            {
               _loc6_ += 1;
            }
            _loc8_.getModelController().setNumber("furniture_automatic_state_index",_loc6_);
            _loc5_ = int(_loc8_.getModel().getNumber("furniture_data_format"));
            _loc4_ = class_2035.getStuffDataWrapperForType(_loc5_);
            _loc4_.initializeFromRoomObjectModel(_loc8_.getModel());
            _loc7_ = new RoomObjectDataUpdateMessage(_loc6_,_loc4_);
            if(_loc8_.getEventHandler() != null)
            {
               _loc8_.getEventHandler().processUpdateMessage(_loc7_);
            }
         }
      }
      
      public function changeObjectModelData(param1:int, param2:int, param3:int, param4:String, param5:int) : Boolean
      {
         var _loc6_:RoomObjectModelDataUpdateMessage = null;
         var _loc7_:IRoomObjectController = getObject(getRoomIdentifier(param1),param2,param3);
         if(_loc7_ == null)
         {
            return false;
         }
         if(_loc7_ != null && _loc7_.getEventHandler() != null)
         {
            _loc6_ = new RoomObjectModelDataUpdateMessage(param4,param5);
            _loc7_.getEventHandler().processUpdateMessage(_loc6_);
         }
         return true;
      }
      
      public function updateObjectFurniture(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:int, param6:IStuffData, param7:Number = NaN) : Boolean
      {
         var _loc10_:IRoomObjectController = getObjectFurniture(param1,param2);
         if(_loc10_ == null)
         {
            return false;
         }
         var _loc8_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3,param4);
         var _loc9_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param5,param6,param7);
         if(_loc10_ != null && _loc10_.getEventHandler() != null)
         {
            _loc10_.getEventHandler().processUpdateMessage(_loc8_);
            _loc10_.getEventHandler().processUpdateMessage(_loc9_);
         }
         return true;
      }
      
      public function updateObjectFurnitureHeight(param1:int, param2:int, param3:Number) : Boolean
      {
         var _loc4_:RoomObjectHeightUpdateMessage = null;
         var _loc5_:IRoomObjectController = getObjectFurniture(param1,param2);
         if(_loc5_ == null)
         {
            return false;
         }
         if(_loc5_ != null && _loc5_.getEventHandler() != null)
         {
            _loc4_ = new RoomObjectHeightUpdateMessage(null,null,param3);
            _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         }
         return true;
      }
      
      public function updateObjectFurnitureLocation(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:IVector3d, param6:Number = NaN) : Boolean
      {
         var _loc7_:RoomObjectMoveUpdateMessage = null;
         var _loc8_:IRoomObjectController = getObjectFurniture(param1,param2);
         if(_loc8_ == null)
         {
            return false;
         }
         if(_loc8_ != null && _loc8_.getEventHandler() != null)
         {
            _loc7_ = new RoomObjectMoveUpdateMessage(param3,param5,param4,param6,param5 != null);
            _loc8_.getEventHandler().processUpdateMessage(_loc7_);
         }
         return true;
      }
      
      public function updateObjectFurnitureExpiryTime(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:IRoomObjectController = getObjectFurniture(param1,param2);
         if(_loc4_ == null)
         {
            return false;
         }
         _loc4_.getModelController().setNumber("furniture_expiry_time",param3);
         _loc4_.getModelController().setNumber("furniture_expirty_timestamp",getTimer());
         return true;
      }
      
      private function createObjectFurniture(param1:int, param2:int, param3:String) : IRoomObjectController
      {
         return createObject(getRoomIdentifier(param1),param2,param3,10);
      }
      
      private function getObjectFurniture(param1:int, param2:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),param2,10);
      }
      
      public function disposeObjectFurniture(param1:int, param2:int, param3:int = -1, param4:Boolean = false) : void
      {
         var _loc14_:IRoomObject = null;
         var _loc12_:Point = null;
         var _loc9_:IRoomObjectModel = null;
         var _loc10_:* = false;
         var _loc11_:int = 0;
         var _loc7_:String = null;
         var _loc13_:int = 0;
         var _loc8_:IStuffData = null;
         var _loc5_:BitmapData = null;
         var _loc6_:class_1744 = getRoomInstanceData(param1);
         if(_loc6_ != null)
         {
            _loc6_.getFurnitureDataWithId(param2);
         }
         if(_sessionDataManager && param3 == _sessionDataManager.userId && !class_2262.isBuilderClubId(param2))
         {
            _loc14_ = getRoomObject(param1,param2,10);
            if(_loc14_)
            {
               _loc12_ = getRoomObjectScreenLocation(param1,param2,10,var_1223);
               if(_loc12_)
               {
                  _loc9_ = _loc14_.getModel();
                  _loc10_ = _loc9_.getNumber("furniture_disable_picking_animation") == 1;
                  if(!_loc10_)
                  {
                     _loc11_ = _loc9_.getNumber("furniture_type_id");
                     _loc7_ = _loc9_.getString("furniture_extras");
                     _loc13_ = _loc9_.getNumber("furniture_data_format");
                     _loc8_ = class_2035.getStuffDataWrapperForType(_loc13_);
                     _loc5_ = getFurnitureIcon(_loc11_,null,_loc7_,_loc8_).data;
                     if(_loc5_)
                     {
                        _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY",_loc5_,_loc12_.x,_loc12_.y);
                     }
                  }
               }
            }
         }
         disposeObject(param1,param2,10);
         removeButtonMouseCursorOwner(param1,10,param2);
         if(param4)
         {
            refreshTileObjectMap(param1,"RoomEngine.disposeObjectFurniture()");
         }
      }
      
      public function addObjectWallItem(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String, param8:int = 0, param9:int = 0, param10:String = "", param11:int = -1, param12:Boolean = true) : Boolean
      {
         var _loc15_:class_2108 = null;
         var _loc13_:class_1744 = getRoomInstanceData(param1);
         if(_loc13_ != null)
         {
            _loc15_ = new class_2108();
            _loc15_.setString(param7);
            var _loc14_:class_2197 = new class_2197(param2,param3,null,param4,param5,param6,_loc15_,NaN,param11,param8,param9,param10,true,param12);
            _loc13_.addWallItemData(null);
         }
         return true;
      }
      
      private function addObjectWallItemFromData(param1:int, param2:int, param3:class_2197) : Boolean
      {
         if(param3 == null)
         {
            var _loc4_:class_1744 = getRoomInstanceData(param1);
            if(_loc4_ != null)
            {
               param3 = null.getWallItemDataWithId(param2);
            }
         }
         if(param3 == null)
         {
            return false;
         }
         var _loc6_:String = "";
         if(param3.data != null)
         {
            _loc6_ = param3.data.getLegacyString();
         }
         var _loc9_:String = getWallItemType(param3.typeId,_loc6_);
         var _loc7_:int = getWallItemColorIndex(param3.typeId);
         var _loc8_:String = getRoomObjectAdURL(_loc9_);
         if(_loc9_ == null)
         {
            _loc9_ = "";
         }
         var _loc10_:IRoomObjectController = createObjectWallItem(param1,param2,_loc9_);
         if(_loc10_ == null)
         {
            return false;
         }
         if(_loc10_ != null && _loc10_.getModelController() != null)
         {
            _loc10_.getModelController().setNumber("furniture_color",_loc7_,false);
            _loc10_.getModelController().setNumber("furniture_type_id",param3.typeId,true);
            _loc10_.getModelController().setString("furniture_ad_url",_loc8_,true);
            _loc10_.getModelController().setNumber("furniture_real_room_object",param3.realRoomObject ? 1 : 0,false);
            _loc10_.getModelController().setNumber("object_accurate_z_value",1,true);
            _loc10_.getModelController().setNumber("furniture_usage_policy",param3.usagePolicy);
            _loc10_.getModelController().setNumber("furniture_expiry_time",param3.expiryTime);
            _loc10_.getModelController().setNumber("furniture_expirty_timestamp",getTimer());
            _loc10_.getModelController().setNumber("furniture_owner_id",param3.ownerId);
            _loc10_.getModelController().setString("furniture_owner_name",param3.ownerName);
            _loc10_.getModelController().setNumber("furniture_extra",param3.extra);
         }
         _loc6_ = "";
         if(param3.data != null)
         {
            _loc6_ = param3.data.getLegacyString();
         }
         if(!updateObjectWallItem(param1,param2,param3.loc,param3.dir,param3.state,_loc6_))
         {
            return false;
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED",param1,param2,20));
         }
         var _loc5_:ISelectedRoomObjectData = getPlacedObjectData(param1);
         if(_loc5_ && _loc5_.id == param2 && _loc5_.category == 20)
         {
            selectRoomObject(param1,param2,20);
         }
         return true;
      }
      
      public function updateObjectWallItem(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:int, param6:String) : Boolean
      {
         var _loc10_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc10_ == null)
         {
            return false;
         }
         var _loc8_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3,param4);
         var _loc7_:class_2108 = new class_2108();
         _loc7_.setString(param6);
         var _loc9_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param5,_loc7_);
         if(_loc10_ != null && _loc10_.getEventHandler() != null)
         {
            _loc10_.getEventHandler().processUpdateMessage(_loc8_);
            _loc10_.getEventHandler().processUpdateMessage(_loc9_);
         }
         updateObjectRoomWindow(param1,param2);
         return true;
      }
      
      public function updateObjectWallItemState(param1:int, param2:int, param3:int, param4:String) : Boolean
      {
         var _loc7_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc7_ == null)
         {
            return false;
         }
         var _loc5_:class_2108 = new class_2108();
         _loc5_.setString(param4);
         var _loc6_:RoomObjectDataUpdateMessage = new RoomObjectDataUpdateMessage(param3,_loc5_);
         if(_loc7_ != null && _loc7_.getEventHandler() != null)
         {
            _loc7_.getEventHandler().processUpdateMessage(_loc6_);
         }
         return true;
      }
      
      public function updateObjectRoomWindow(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc5_:String = null;
         var _loc4_:IVector3d = null;
         var _loc7_:String = "20_" + param2;
         var _loc6_:RoomObjectRoomMaskUpdateMessage = null;
         var _loc9_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc9_ != null)
         {
            if(_loc9_.getModel() != null)
            {
               if(_loc9_.getModel().getNumber("furniture_uses_plane_mask") > 0)
               {
                  _loc5_ = _loc9_.getModel().getString("furniture_plane_mask_type");
                  _loc4_ = _loc9_.getLocation();
                  if(param3)
                  {
                     _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK",_loc7_,_loc5_,_loc4_);
                  }
                  else
                  {
                     _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK",_loc7_);
                  }
               }
            }
         }
         else
         {
            _loc6_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK",_loc7_);
         }
         var _loc8_:IRoomObjectController = getObjectRoom(param1);
         if(_loc8_ != null && _loc8_.getEventHandler() != null && _loc6_ != null)
         {
            _loc8_.getEventHandler().processUpdateMessage(_loc6_);
         }
      }
      
      public function updateObjectWallItemData(param1:int, param2:int, param3:String) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc5_ == null)
         {
            return false;
         }
         var _loc4_:RoomObjectItemDataUpdateMessage = new RoomObjectItemDataUpdateMessage(param3);
         if(_loc5_ != null && _loc5_.getEventHandler() != null)
         {
            _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         }
         return true;
      }
      
      private function createObjectWallItem(param1:int, param2:int, param3:String) : IRoomObjectController
      {
         return createObject(getRoomIdentifier(param1),param2,param3,20);
      }
      
      private function getObjectWallItem(param1:int, param2:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),param2,20);
      }
      
      public function updateObjectWallItemLocation(param1:int, param2:int, param3:IVector3d, param4:IVector3d = null, param5:Number = NaN) : Boolean
      {
         var _loc7_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc7_ == null)
         {
            return false;
         }
         if(_loc7_.getEventHandler() != null)
         {
            var _loc6_:RoomObjectMoveUpdateMessage = new RoomObjectMoveUpdateMessage(param3,param4,null,param5,param4 != null);
            _loc7_.getEventHandler().processUpdateMessage(null);
         }
         updateObjectRoomWindow(param1,param2);
         return true;
      }
      
      public function updateObjectWallItemExpiryTime(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:IRoomObjectController = getObjectWallItem(param1,param2);
         if(_loc4_ == null)
         {
            return false;
         }
         _loc4_.getModelController().setNumber("furniture_expiry_time",param3);
         _loc4_.getModelController().setNumber("furniture_expirty_timestamp",getTimer());
         return true;
      }
      
      public function disposeObjectWallItem(param1:int, param2:int, param3:int = -1) : void
      {
         var _loc10_:IRoomObject = null;
         var _loc6_:Point = null;
         var _loc8_:IRoomObjectModel = null;
         var _loc9_:int = 0;
         var _loc7_:String = null;
         var _loc4_:BitmapData = null;
         var _loc5_:class_1744 = getRoomInstanceData(param1);
         if(_loc5_ != null)
         {
            _loc5_.getWallItemDataWithId(param2);
         }
         if(_sessionDataManager && param3 == _sessionDataManager.userId && !class_2262.isBuilderClubId(param2))
         {
            _loc10_ = getRoomObject(param1,param2,20);
            if(_loc10_ && _loc10_.getType().indexOf("post_it") == -1 && _loc10_.getType().indexOf("external_image_wallitem") == -1)
            {
               _loc6_ = getRoomObjectScreenLocation(param1,param2,20,var_1223);
               _loc8_ = _loc10_.getModel();
               _loc9_ = _loc8_.getNumber("furniture_type_id");
               _loc7_ = _loc8_.getString("furniture_data");
               _loc4_ = getWallItemIcon(_loc9_,null,_loc7_).data;
               if(_toolbar && _loc6_)
               {
                  _toolbar.createTransitionToIcon("HTIE_ICON_INVENTORY",_loc4_,_loc6_.x,_loc6_.y);
               }
            }
         }
         disposeObject(param1,param2,20);
         updateObjectRoomWindow(param1,param2,false);
         removeButtonMouseCursorOwner(param1,20,param2);
      }
      
      public function addObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Number, param6:int, param7:String = null) : Boolean
      {
         var _loc10_:RoomObjectUpdateMessage = null;
         var _loc8_:RoomObjectAvatarFigureUpdateMessage = null;
         var _loc9_:RoomObjectAvatarBlockedUpdateMessage = null;
         if(getObjectUser(param1,param2) != null)
         {
            return false;
         }
         var _loc11_:String = RoomObjectUserTypes.getName(param6);
         if(_loc11_ == "pet")
         {
            _loc11_ = getPetType(param7);
         }
         var _loc12_:IRoomObjectController = createObjectUser(param1,param2,_loc11_);
         if(_loc12_ == null)
         {
            return false;
         }
         if(_loc12_ != null && _loc12_.getEventHandler() != null)
         {
            _loc10_ = new RoomObjectAvatarUpdateMessage(fixedUserLocation(param1,param3),null,param4,param5,false,0);
            _loc12_.getEventHandler().processUpdateMessage(_loc10_);
            if(param7 != null)
            {
               _loc8_ = new RoomObjectAvatarFigureUpdateMessage(param7);
               _loc12_.getEventHandler().processUpdateMessage(_loc8_);
            }
            if(_loc11_ == "user" && userIsBlocked(param1,param2))
            {
               _loc9_ = new RoomObjectAvatarBlockedUpdateMessage(true);
               _loc12_.getEventHandler().processUpdateMessage(_loc9_);
            }
         }
         if(events != null)
         {
            events.dispatchEvent(new RoomEngineObjectEvent("REOE_ADDED",param1,param2,100));
         }
         return true;
      }
      
      public function addObjectSnowWar(param1:int, param2:int, param3:IVector3d, param4:int) : Boolean
      {
         var _loc5_:String = null;
         if(param4 == 201)
         {
            _loc5_ = "game_snowball";
         }
         else if(param4 == 202)
         {
            _loc5_ = "game_snowsplash";
         }
         var _loc7_:IRoomObjectController = createObjectSnowWar(param1,param2,_loc5_,param4);
         if(!_loc7_)
         {
            return false;
         }
         if(_loc7_.getEventHandler())
         {
            var _loc6_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3,null);
            _loc7_.getEventHandler().processUpdateMessage(null);
         }
         return true;
      }
      
      public function addObjectSnowSplash(param1:int, param2:int, param3:IVector3d) : Boolean
      {
         _roomManager.addObjectUpdateCategory(202);
         var _loc5_:IRoomObjectController = createObjectSnowWar(param1,param2,"game_snowsplash",202);
         if(!_loc5_)
         {
            return false;
         }
         if(_loc5_.getEventHandler())
         {
            var _loc4_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3,null);
            _loc5_.getEventHandler().processUpdateMessage(null);
         }
         return true;
      }
      
      public function updateObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Boolean = false, param6:Number = 0, param7:IVector3d = null, param8:Number = NaN, param9:Number = NaN, param10:Boolean = false) : Boolean
      {
         var _loc12_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc12_ == null || _loc12_.getEventHandler() == null || _loc12_.getModel() == null)
         {
            return false;
         }
         if(param3 == null)
         {
            param3 = _loc12_.getLocation();
         }
         if(param7 == null)
         {
            param7 = _loc12_.getDirection();
         }
         if(isNaN(param8))
         {
            param8 = Number(_loc12_.getModel().getNumber("head_direction"));
         }
         var _loc11_:RoomObjectUpdateMessage = new RoomObjectAvatarUpdateMessage(fixedUserLocation(param1,param3),fixedUserLocation(param1,param4),param7,param8,param5,param6,param9,param10);
         _loc12_.getEventHandler().processUpdateMessage(_loc11_);
         if(roomSessionManager && roomSessionManager.getSession(param1) && param2 == roomSessionManager.getSession(param1).ownUserRoomId)
         {
            _roomObjectFactory.events.dispatchEvent(new RoomToObjectOwnAvatarMoveEvent("ROAME_MOVE_TO",param4));
         }
         return true;
      }
      
      public function updateObjectUserDir(param1:int, param2:int, param3:IVector3d, param4:Number) : Boolean
      {
         var _loc6_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc6_ == null || _loc6_.getEventHandler() == null || _loc6_.getModel() == null)
         {
            return false;
         }
         var _loc5_:RoomObjectUpdateMessage = new RoomObjectAvatarDirectionUpdateMessage(null,param3,param4);
         _loc6_.getEventHandler().processUpdateMessage(_loc5_);
         return true;
      }
      
      public function updateObjectSnowWar(param1:int, param2:int, param3:IVector3d, param4:int) : Boolean
      {
         var _loc5_:IRoomObjectController = getObject(getRoomIdentifier(param1),param2,param4);
         var _loc6_:RoomObjectUpdateMessage = new RoomObjectUpdateMessage(param3,null);
         _loc5_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function disposeObjectSnowWar(param1:int, param2:int, param3:int) : void
      {
         disposeObject(param1,param2,param3);
      }
      
      public function updateObjectUserFlatControl(param1:int, param2:int, param3:String) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc4_:RoomObjectUpdateStateMessage = new RoomObjectAvatarFlatControlUpdateMessage(param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         return true;
      }
      
      public function updateObjectUserOwnUserAvatar(param1:int, param2:int) : Boolean
      {
         var _loc3_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc3_ == null || _loc3_.getEventHandler() == null)
         {
            return false;
         }
         var _loc4_:RoomObjectUpdateMessage = new RoomObjectAvatarOwnMessage();
         _loc3_.getEventHandler().processUpdateMessage(_loc4_);
         return true;
      }
      
      public function updateObjectUserBlocked(param1:int, param2:int, param3:Boolean) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc4_:RoomObjectAvatarBlockedUpdateMessage = new RoomObjectAvatarBlockedUpdateMessage(param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         return true;
      }
      
      public function updateObjectUserFigure(param1:int, param2:int, param3:String, param4:String = null, param5:String = null, param6:Boolean = false) : Boolean
      {
         var _loc8_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc8_ == null || _loc8_.getEventHandler() == null)
         {
            return false;
         }
         var _loc7_:RoomObjectUpdateStateMessage = new RoomObjectAvatarFigureUpdateMessage(param3,param4,param5,param6);
         _loc8_.getEventHandler().processUpdateMessage(_loc7_);
         return true;
      }
      
      private function userIsBlocked(param1:int, param2:int) : Boolean
      {
         var _loc3_:class_2146 = null;
         var _loc4_:IRoomSession = _roomSessionManager.getSession(param1);
         if(_loc4_ && _loc4_.userDataManager)
         {
            _loc3_ = _loc4_.userDataManager.getUserDataByIndex(param2);
            if(_loc3_ != null && _sessionDataManager.isBlocked(_loc3_.webID))
            {
               return true;
            }
         }
         return false;
      }
      
      public function updateObjectUserAction(param1:int, param2:int, param3:String, param4:int, param5:String = null) : Boolean
      {
         var _loc7_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc7_ == null || _loc7_.getEventHandler() == null)
         {
            return false;
         }
         if(userIsBlocked(param1,param2))
         {
            return false;
         }
         var _loc6_:RoomObjectUpdateStateMessage = null;
         switch(param3)
         {
            case "figure_talk":
               _loc6_ = new RoomObjectAvatarChatUpdateMessage(param4);
               break;
            case "figure_sleep":
               _loc6_ = new RoomObjectAvatarSleepUpdateMessage(param4 != 0);
               break;
            case "figure_is_typing":
               _loc6_ = new RoomObjectAvatarTypingUpdateMessage(param4 != 0);
               break;
            case "figure_is_muted":
               _loc6_ = new RoomObjectAvatarMutedUpdateMessage(param4 != 0);
               break;
            case "figure_carry_object":
               _loc6_ = new RoomObjectAvatarCarryObjectUpdateMessage(param4,param5);
               break;
            case "figure_use_object":
               _loc6_ = new RoomObjectAvatarUseObjectUpdateMessage(param4);
               break;
            case "figure_dance":
               _loc6_ = new RoomObjectAvatarDanceUpdateMessage(param4);
               break;
            case "figure_gained_experience":
               _loc6_ = new RoomObjectAvatarExperienceUpdateMessage(param4);
               break;
            case "figure_number_value":
               _loc6_ = new RoomObjectAvatarPlayerValueUpdateMessage(param4);
               break;
            case "figure_sign":
               _loc6_ = new RoomObjectAvatarSignUpdateMessage(param4);
               break;
            case "figure_expression":
               _loc6_ = new RoomObjectAvatarExpressionUpdateMessage(param4);
               break;
            case "figure_is_playing_game":
               _loc6_ = new RoomObjectAvatarPlayingGameMessage(param4 != 0);
               break;
            case "figure_guide_status":
               _loc6_ = new RoomObjectAvatarGuideStatusUpdateMessage(param4);
         }
         _loc7_.getEventHandler().processUpdateMessage(_loc6_);
         return true;
      }
      
      public function updateObjectUserPosture(param1:int, param2:int, param3:String, param4:String = "") : Boolean
      {
         var _loc6_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc6_ == null || _loc6_.getEventHandler() == null)
         {
            return false;
         }
         var _loc5_:RoomObjectUpdateStateMessage = new RoomObjectAvatarPostureUpdateMessage(param3,param4);
         _loc6_.getEventHandler().processUpdateMessage(_loc5_);
         return true;
      }
      
      public function updateObjectUserGesture(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc4_:RoomObjectUpdateStateMessage = new RoomObjectAvatarGestureUpdateMessage(param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         return true;
      }
      
      public function updateObjectPetGesture(param1:int, param2:int, param3:String) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         var _loc4_:RoomObjectUpdateStateMessage = new RoomObjectAvatarPetGestureUpdateMessage(param3);
         _loc5_.getEventHandler().processUpdateMessage(_loc4_);
         return true;
      }
      
      public function updateObjectUserEffect(param1:int, param2:int, param3:int, param4:int = 0) : Boolean
      {
         var _loc5_:IRoomObjectController = getObjectUser(param1,param2);
         if(_loc5_ == null || _loc5_.getEventHandler() == null)
         {
            return false;
         }
         _loc5_.getEventHandler().processUpdateMessage(new RoomObjectAvatarEffectUpdateMessage(param3,param4));
         return true;
      }
      
      private function createObjectUser(param1:int, param2:int, param3:String) : IRoomObjectController
      {
         return createObject(getRoomIdentifier(param1),param2,param3,100);
      }
      
      private function createObjectSnowWar(param1:int, param2:int, param3:String, param4:int) : IRoomObjectController
      {
         return createObject(getRoomIdentifier(param1),param2,param3,param4);
      }
      
      private function getObjectUser(param1:int, param2:int) : IRoomObjectController
      {
         return getObject(getRoomIdentifier(param1),param2,100);
      }
      
      public function disposeObjectUser(param1:int, param2:int) : void
      {
         disposeObject(param1,param2,100);
      }
      
      private function createObject(param1:String, param2:int, param3:String, param4:int) : IRoomObjectController
      {
         var _loc5_:IRoomInstance = _roomManager.getRoom(param1);
         if(_loc5_ == null)
         {
            return null;
         }
         var _loc6_:IRoomObjectController = null;
         return _loc5_.createRoomObject(param2,param3,param4) as IRoomObjectController;
      }
      
      private function getObject(param1:String, param2:int, param3:int) : IRoomObjectController
      {
         if(_roomManager != null)
         {
            var _loc4_:IRoomInstance = _roomManager.getRoom(param1);
         }
         return null;
      }
      
      private function disposeObject(param1:int, param2:int, param3:int) : void
      {
         if(_roomManager != null)
         {
            var _loc4_:IRoomInstance = getRoom(param1);
            if(_loc4_ == null)
            {
               return;
            }
            if(null.disposeObject(param2,param3))
            {
               if(events != null)
               {
                  events.dispatchEvent(new RoomEngineObjectEvent("REOE_REMOVED",param1,param2,param3));
               }
            }
         }
      }
      
      private function roomObjectEventHandler(param1:RoomObjectEvent) : void
      {
         if(var_126 != null)
         {
            var _loc2_:String = getRoomObjectRoomIdentifier(param1.object);
         }
      }
      
      private function getRoomObjectRoomIdentifier(param1:IRoomObject) : String
      {
         if(param1 != null && param1.getModel() != null)
         {
            return param1.getModel().getString("object_room_id");
         }
         return null;
      }
      
      public function createScreenShot(param1:int, param2:int, param3:String) : void
      {
         var _loc10_:ByteArray = null;
         var _loc7_:FileReference = null;
         var _loc4_:RegExp = /[:\/\\\*\?"<>\|%]/g;
         param3 = param3.replace(_loc4_,"");
         var _loc9_:IRoomRenderingCanvas = getRoomCanvas(param1,param2);
         if(!_loc9_)
         {
            return;
         }
         var _loc8_:BitmapData = _loc9_.takeScreenShot();
         if(class_2130.isVersionAtLeast(11,3))
         {
         }
         if(_loc10_ == null)
         {
            _loc10_ = class_1791.encode(_loc8_);
         }
         try
         {
            _loc7_ = new FileReference();
            _loc7_.save(_loc10_,param3);
         }
         catch(error:Error)
         {
            var _loc5_:Date = new Date();
            var _loc6_:String = [_loc5_.getFullYear(),null.getMonth(),null.getDate()].join("-") + " " + [null.getHours(),null.getMinutes(),null.getSeconds()].join(".");
            param3 = "Habbo " + null;
            _loc7_ = new FileReference();
            _loc7_.save(_loc10_,param3);
         }
      }
      
      public function purgeRoomContent() : void
      {
         if(var_27)
         {
            var_27.purge();
         }
      }
      
      public function getFurnitureIconUrl(param1:int) : String
      {
         if(var_27 != null)
         {
            var _loc3_:String = var_27.getActiveObjectType(param1);
            var _loc2_:String = String(var_27.getActiveObjectColorIndex(param1));
         }
         return var_27.getObjectUrl(null,"");
      }
      
      public function getFurnitureIcon(param1:int, param2:class_1829, param3:String = null, param4:IStuffData = null, param5:Boolean = false) : class_2198
      {
         return getFurnitureImage(param1,new Vector3d(),1,param2,0,param3,-1,-1,param4,param5);
      }
      
      public function getWallItemIconUrl(param1:int, param2:String = null) : String
      {
         if(var_27 != null)
         {
            var _loc4_:String = var_27.getWallItemType(param1,param2);
            var _loc3_:String = String(var_27.getWallItemColorIndex(param1));
         }
         return var_27.getObjectUrl(null,"");
      }
      
      public function getWallItemIcon(param1:int, param2:class_1829, param3:String = null) : class_2198
      {
         return getWallItemImage(param1,new Vector3d(),1,param2,0,param3);
      }
      
      public function getFurnitureImage(param1:int, param2:IVector3d, param3:int, param4:class_1829, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1, param9:IStuffData = null, param10:Boolean = false) : class_2198
      {
         if(var_27 != null)
         {
            var _loc12_:String = var_27.getActiveObjectType(param1);
            var _loc11_:String = String(var_27.getActiveObjectColorIndex(param1));
         }
         if(param3 == 1 && param4 != null && !param10)
         {
            return getGenericRoomObjectThumbnail(null,"",param4,param6,param9);
         }
         return getGenericRoomObjectImage(null,"",param2,param3,param4,param5,param6,param9,param7,param8);
      }
      
      public function getPetImage(param1:int, param2:int, param3:int, param4:IVector3d, param5:int, param6:class_1829, param7:Boolean = true, param8:uint = 0, param9:Array = null, param10:String = null) : class_2198
      {
         var _loc11_:String = null;
         var _loc13_:String = param1 + " " + param2 + " " + param3.toString(16);
         if(!param7)
         {
            _loc13_ += " head";
         }
         if(param9 != null)
         {
            _loc13_ += " " + param9.length;
            for each(var _loc12_ in param9)
            {
               _loc13_ += " " + _loc12_.layerId + " " + _loc12_.partId + " " + _loc12_.paletteId;
            }
         }
         if(var_27 != null)
         {
            _loc11_ = var_27.getPetType(param1);
         }
         return getGenericRoomObjectImage(_loc11_,_loc13_,param4,param5,param6,param8,null,null,-1,-1,param10);
      }
      
      public function getWallItemImage(param1:int, param2:IVector3d, param3:int, param4:class_1829, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1) : class_2198
      {
         if(var_27 != null)
         {
            var _loc10_:String = var_27.getWallItemType(param1,param6);
            var _loc9_:String = String(var_27.getWallItemColorIndex(param1));
         }
         if(param3 == 1 && param4 != null)
         {
            return getGenericRoomObjectThumbnail(null,"",param4,param6,null);
         }
         return getGenericRoomObjectImage(null,"",param2,param3,param4,param5,param6,null,param7,param8);
      }
      
      public function getRoomImage(param1:String, param2:String, param3:String, param4:int, param5:class_1829, param6:String = null) : class_2198
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2 == null)
         {
            param2 = "";
         }
         if(param3 == null)
         {
            param3 = "";
         }
         var _loc7_:String = param1 + "\n" + param2 + "\n" + param3 + "\n";
         if(param6 != null)
         {
            _loc7_ += param6;
         }
         return getGenericRoomObjectImage("room",_loc7_,new Vector3d(),param4,param5);
      }
      
      public function getRoomObjectImage(param1:int, param2:int, param3:int, param4:IVector3d, param5:int, param6:class_1829, param7:uint = 0) : class_2198
      {
         var _loc12_:String = getRoomIdentifier(param1);
         var _loc11_:IRoomInstance = _roomManager.getRoom(_loc12_);
         if(_loc11_ != null)
         {
            var _loc16_:IRoomObject = _loc11_.getObject(param2,param3);
            if(_loc16_ != null && null.getModel() != null)
            {
               var _loc10_:String = null.getType();
               var _loc15_:int = int(null.getId());
               switch(param3)
               {
                  case 10:
                  case 20:
                     var _loc13_:String = String(null.getModel().getNumber("furniture_color"));
                     var _loc9_:String = null.getModel().getString("furniture_extras");
                     var _loc8_:int = int(null.getModel().getNumber("furniture_data_format"));
                     if(_loc8_ != 0)
                     {
                        var _loc14_:IStuffData = class_2035.getStuffDataWrapperForType(0);
                        _loc14_.initializeFromRoomObjectModel(null.getModel());
                     }
                     break;
                  case 100:
                     _loc13_ = null.getModel().getString("figure");
               }
            }
         }
         return getGenericRoomObjectImage(null,"",param4,param5,param6,param7,null,null,-1,-1,null,-1);
      }
      
      private function initializeRoomForGettingImage(param1:IRoomObjectController, param2:String) : void
      {
         var _loc3_:Array = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc12_:String = null;
         var _loc4_:String = null;
         var _loc11_:int = 0;
         var _loc5_:RoomPlaneParser = null;
         var _loc14_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:RoomObjectRoomMaskUpdateMessage = null;
         var _loc10_:String = null;
         if(param2 != null)
         {
            _loc3_ = param2.split("\n");
            if(_loc3_.length >= 3)
            {
               _loc8_ = _loc3_[0];
               _loc9_ = _loc3_[1];
               _loc12_ = _loc3_[2];
               _loc4_ = _loc3_[3];
               _loc11_ = 6;
               _loc5_ = new RoomPlaneParser();
               _loc5_.initializeTileMap(_loc11_ + 2,_loc11_ + 2);
               _loc14_ = 1;
               while(_loc14_ < 1 + _loc11_)
               {
                  _loc13_ = 1;
                  while(_loc13_ < 1 + _loc11_)
                  {
                     _loc5_.setTileHeight(_loc13_,_loc14_,0);
                     _loc13_++;
                  }
                  _loc14_++;
               }
               _loc5_.wallHeight = _loc11_;
               _loc5_.initializeFromTileData();
               _loc6_ = _loc5_.getXML();
               param1.getEventHandler().initialize(_loc6_);
               param1.getModelController().setString("room_floor_type",_loc8_);
               param1.getModelController().setString("room_wall_type",_loc9_);
               param1.getModelController().setString("room_landscape_type",_loc12_);
               if(_loc4_ != null)
               {
                  _loc7_ = null;
                  _loc10_ = "20_1";
                  _loc7_ = new RoomObjectRoomMaskUpdateMessage("RORMUM_ADD_MASK",_loc10_,_loc4_,new Vector3d(2.5,0.5,2));
                  param1.getEventHandler().processUpdateMessage(_loc7_);
               }
               _loc5_.dispose();
            }
         }
      }
      
      public function getGenericRoomObjectThumbnail(param1:String, param2:String, param3:class_1829, param4:String = null, param5:IStuffData = null) : class_2198
      {
         var _loc6_:AssetCallbackInfo = null;
         var _loc13_:BitmapDataAsset = null;
         var _loc9_:BitmapData = null;
         var _loc8_:class_2198 = new class_2198();
         _loc8_.id = -1;
         if(!var_871 || param1 == null)
         {
            return _loc8_;
         }
         var _loc7_:IRoomInstance = _roomManager.getRoom("temporary_room");
         if(_loc7_ == null)
         {
            _loc7_ = _roomManager.createRoom("temporary_room",null);
            if(_loc7_ == null)
            {
               return _loc8_;
            }
         }
         var _loc11_:int = var_1184.reserveNumber();
         var _loc12_:int = getRoomObjectCategory(param1);
         if(_loc11_ < 0)
         {
            return _loc8_;
         }
         _loc11_ += 1;
         _loc8_.id = _loc11_;
         _loc8_.data = null;
         var _loc10_:String = [param1,param2].join("_");
         if(!assets.hasAsset(_loc10_) && param3 != null)
         {
            _loc6_ = var_1717.getValue(_loc10_);
            if(_loc6_ == null)
            {
               _loc6_ = new AssetCallbackInfo(_loc11_);
               var_1717.add(_loc10_,_loc6_);
               var_27.loadThumbnailContent(_loc11_,param1,param2,null);
            }
            else
            {
               var_1184.freeNumber(_loc11_ - 1);
               _loc8_.id = _loc6_.id;
            }
            _loc6_.listeners.push(param3);
         }
         else
         {
            _loc13_ = assets.getAssetByName(_loc10_) as BitmapDataAsset;
            if(_loc13_ && !_loc13_.disposed)
            {
               _loc9_ = _loc13_.content as BitmapData;
               try
               {
                  if(_loc9_ != null && _loc9_ is BitmapData && _loc9_.width > 0 && _loc9_.height > 0)
                  {
                     _loc8_.data = _loc9_.clone();
                  }
                  else
                  {
                     class_21.log("Could not process thumbnail for icon (disposed?): " + _loc10_);
                  }
               }
               catch(error:Error)
               {
                  class_21.log("Could not process thumbnail for icon: " + _loc10_);
               }
            }
            var_1184.freeNumber(_loc11_ - 1);
            _loc8_.id = 0;
         }
         return _loc8_;
      }
      
      public function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:class_1829, param6:uint = 0, param7:String = null, param8:IStuffData = null, param9:int = -1, param10:int = -1, param11:String = null, param12:int = -1) : class_2198
      {
         var _loc23_:RoomObjectDataUpdateMessage = null;
         var _loc15_:int = 0;
         var _loc17_:class_2198 = new class_2198();
         _loc17_.id = -1;
         if(!var_871 || param1 == null)
         {
            return _loc17_;
         }
         var _loc16_:IRoomInstance = _roomManager.getRoom("temporary_room");
         if(_loc16_ == null)
         {
            _loc16_ = _roomManager.createRoom("temporary_room",null);
            if(_loc16_ == null)
            {
               return _loc17_;
            }
         }
         var _loc21_:int = var_1321.reserveNumber();
         var _loc22_:int = getRoomObjectCategory(param1);
         if(_loc21_ < 0)
         {
            return _loc17_;
         }
         _loc21_ += 1;
         var _loc24_:IRoomObjectController = _loc16_.createRoomObject(_loc21_,param1,_loc22_) as IRoomObjectController;
         if(_loc24_ == null || _loc24_.getModelController() == null || _loc24_.getEventHandler() == null)
         {
            return _loc17_;
         }
         var _loc13_:IRoomObjectModelController = _loc24_.getModelController();
         switch(_loc22_)
         {
            case 10:
            case 20:
               _loc13_.setNumber("furniture_color",int(param2));
               _loc13_.setString("furniture_extras",param7);
               break;
            case 100:
               if(param1 == "user" || param1 == "bot" || param1 == "rentable_bot" || param1 == "pet")
               {
                  _loc13_.setString("figure",param2);
                  break;
               }
               var _loc18_:PetFigureData = new PetFigureData(param2);
               _loc13_.setNumber("pet_palette_index",null.paletteId);
               _loc13_.setNumber("pet_color",null.color);
               if(null.headOnly)
               {
                  _loc13_.setNumber("pet_head_only",1);
               }
               if(null.hasCustomParts)
               {
                  _loc13_.setNumberArray("pet_custom_layer_ids",null.customLayerIds);
                  _loc13_.setNumberArray("pet_custom_part_ids",null.customPartIds);
                  _loc13_.setNumberArray("pet_custom_palette_ids",null.customPaletteIds);
               }
               if(param11 != null)
               {
                  _loc13_.setString("figure_posture",param11);
               }
               break;
            case 0:
               initializeRoomForGettingImage(_loc24_,param2);
         }
         _loc24_.setDirection(param3);
         var _loc14_:IRoomObjectSpriteVisualization = null;
         _loc14_ = _loc24_.getVisualization() as IRoomObjectSpriteVisualization;
         if(_loc14_ == null)
         {
            _loc16_.disposeObject(_loc21_,_loc22_);
            return _loc17_;
         }
         if(param9 > -1 || param8)
         {
            if(param8 != null && param8.getLegacyString() != "")
            {
               _loc23_ = new RoomObjectDataUpdateMessage(int(param8.getLegacyString()),param8);
            }
            else
            {
               _loc23_ = new RoomObjectDataUpdateMessage(param9,param8);
            }
            if(_loc24_.getEventHandler() != null)
            {
               _loc24_.getEventHandler().processUpdateMessage(_loc23_);
            }
         }
         var _loc20_:RoomGeometry = new RoomGeometry(param4,new Vector3d(-135,30,0),new Vector3d(11,11,5));
         _loc14_.update(_loc20_,0,true,false);
         if(param10 > 0)
         {
            _loc15_ = 0;
            while(_loc15_ < param10)
            {
               _loc14_.update(_loc20_,0,true,false);
               _loc15_++;
            }
         }
         var _loc19_:BitmapData = _loc14_.getImage(param6,param12);
         _loc17_.data = _loc19_;
         _loc17_.id = _loc21_;
         if(!isRoomObjectContentAvailable(param1) && param5 != null)
         {
            var_2656.add(String(_loc21_),param5);
            _loc13_.setNumber("image_query_scale",param4,true);
         }
         else
         {
            _loc16_.disposeObject(_loc21_,_loc22_);
            var_1321.freeNumber(_loc21_ - 1);
            _loc17_.id = 0;
         }
         _loc20_.dispose();
         return _loc17_;
      }
      
      public function getRoomObjectBoundingRectangle(param1:int, param2:int, param3:int, param4:int) : Rectangle
      {
         var _loc9_:Number = NaN;
         var _loc10_:IRoomGeometry = getRoomCanvasGeometry(param1,param4);
         if(_loc10_ != null)
         {
            var _loc11_:IRoomObject = getRoomObject(param1,param2,param3);
            if(_loc11_ != null)
            {
               var _loc6_:IRoomObjectVisualization = null.getVisualization();
               if(_loc6_ != null)
               {
                  var _loc5_:Rectangle = null.boundingRectangle;
                  var _loc7_:IRoomRenderingCanvas = getRoomCanvas(param1,param4);
                  _loc9_ = Number(_loc7_ ? null.scale : 1);
                  var _loc8_:Point = _loc10_.getScreenPoint(null.getLocation());
                  if(_loc8_ != null)
                  {
                     null.left *= _loc9_;
                     null.top *= _loc9_;
                     null.width *= _loc9_;
                     null.height *= _loc9_;
                     null.x *= _loc9_;
                     null.y *= _loc9_;
                     null.offset(null.x,null.y);
                  }
               }
            }
         }
         return null;
      }
      
      public function getRoomObjectScreenLocation(param1:int, param2:int, param3:int, param4:int = -1) : Point
      {
         var _loc8_:IRoomObject = null;
         var _loc6_:Point = null;
         var _loc5_:IRoomRenderingCanvas = null;
         if(param4 == -1)
         {
            param4 = var_1223;
         }
         var _loc7_:IRoomGeometry = getRoomCanvasGeometry(param1,param4);
         if(_loc7_ != null)
         {
            _loc8_ = getRoomObject(param1,param2,param3);
            if(_loc8_ != null)
            {
               _loc6_ = _loc7_.getScreenPoint(_loc8_.getLocation());
               if(_loc6_ != null)
               {
                  _loc5_ = getRoomCanvas(param1,param4);
                  if(_loc5_ != null)
                  {
                     _loc6_.x *= _loc5_.scale;
                     _loc6_.y *= _loc5_.scale;
                     _loc6_.offset(_loc5_.width / 2 + _loc5_.screenOffsetX,_loc5_.height / 2 + _loc5_.screenOffsetY);
                  }
                  return _loc6_;
               }
            }
         }
         return null;
      }
      
      public function getActiveRoomBoundingRectangle(param1:int) : Rectangle
      {
         return getRoomObjectBoundingRectangle(var_71,-1,0,param1);
      }
      
      public function getActiveRoomActiveCanvas() : IRoomRenderingCanvas
      {
         return getRoomCanvas(var_71,var_1223);
      }
      
      public function isRoomObjectContentAvailable(param1:String) : Boolean
      {
         return _roomManager.isContentAvailable(param1);
      }
      
      public function iconLoaded(param1:int, param2:String, param3:Boolean) : void
      {
         if(var_27 == null)
         {
            return;
         }
         if(param1 == -1)
         {
            return;
         }
         var_1184.freeNumber(param1 - 1);
         var _loc5_:AssetCallbackInfo = var_1717.getValue(param2);
         if(_loc5_ != null)
         {
            if(_loc5_.id != param1)
            {
               return;
            }
            var_1717.remove(param2);
            var _loc7_:BitmapDataAsset = assets.getAssetByName(param2) as BitmapDataAsset;
            var _loc4_:BitmapData = _loc7_.content as BitmapData;
         }
      }
      
      public function contentLoaded(param1:String, param2:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc14_:IRoomObject = null;
         var _loc11_:int = 0;
         var _loc9_:BitmapData = null;
         var _loc4_:IRoomObjectSpriteVisualization = null;
         var _loc7_:Number = NaN;
         var _loc5_:class_1829 = null;
         if(!param2)
         {
            class_21.log("[RoomEngine] Failed to load content:  " + param1);
         }
         var _loc8_:IRoomInstance = _roomManager.getRoom("temporary_room");
         if(_loc8_ == null)
         {
            class_21.log("No room instance for " + param1 + " room: " + "temporary_room");
            return;
         }
         if(var_27 == null)
         {
            return;
         }
         var _loc10_:RoomGeometry = null;
         var _loc13_:Number = 0;
         var _loc12_:int = var_27.getObjectCategory(param1);
         var _loc3_:int = _loc8_.getObjectCount(_loc12_);
         _loc6_ = _loc3_ - 1;
         while(_loc6_ >= 0)
         {
            _loc14_ = _loc8_.getObjectWithIndex(_loc6_,_loc12_);
            if(_loc14_ != null && _loc14_.getModel() != null && _loc14_.getType() == param1)
            {
               _loc11_ = _loc14_.getId();
               _loc9_ = null;
               _loc4_ = null;
               _loc4_ = _loc14_.getVisualization() as IRoomObjectSpriteVisualization;
               if(_loc4_ != null)
               {
                  _loc7_ = _loc14_.getModel().getNumber("image_query_scale");
                  if(_loc10_ != null && _loc13_ != _loc7_)
                  {
                     _loc10_.dispose();
                     _loc10_ = null;
                  }
                  if(_loc10_ == null)
                  {
                     _loc13_ = _loc7_;
                     _loc10_ = new RoomGeometry(_loc7_,new Vector3d(-135,30,0),new Vector3d(11,11,5));
                  }
                  _loc4_.update(_loc10_,0,true,false);
                  _loc9_ = _loc4_.image;
               }
               _loc8_.disposeObject(_loc11_,_loc12_);
               var_1321.freeNumber(_loc11_ - 1);
               _loc5_ = var_2656.remove(String(_loc11_)) as class_1829;
               if(_loc5_ != null)
               {
                  if(_loc9_ != null)
                  {
                     _loc5_.imageReady(_loc11_,_loc9_);
                  }
                  else
                  {
                     _loc5_.imageFailed(_loc11_);
                  }
               }
               else if(_loc9_ != null)
               {
                  _loc9_.dispose();
               }
            }
            _loc6_--;
         }
         if(_loc10_ != null)
         {
            _loc10_.dispose();
         }
      }
      
      public function objectInitialized(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:int = 0;
         var _loc4_:IStuffData = null;
         var _loc6_:int = 0;
         var _loc7_:RoomObjectDataUpdateMessage = null;
         var _loc8_:int = getRoomId(param1);
         if(param3 == 20)
         {
            updateObjectRoomWindow(_loc8_,param2);
         }
         var _loc9_:IRoomObjectController = getRoomObject(_loc8_,param2,param3) as IRoomObjectController;
         if(_loc9_ != null && _loc9_.getModel() != null && _loc9_.getEventHandler() != null)
         {
            if(!isNaN(_loc9_.getModel().getNumber("furniture_data_format")))
            {
               _loc5_ = int(_loc9_.getModel().getNumber("furniture_data_format"));
               _loc4_ = class_2035.getStuffDataWrapperForType(_loc5_);
               _loc4_.initializeFromRoomObjectModel(_loc9_.getModel());
               _loc6_ = int(_loc9_.getState(0));
               _loc7_ = new RoomObjectDataUpdateMessage(_loc6_,_loc4_);
               _loc9_.getEventHandler().processUpdateMessage(_loc7_);
            }
            if(events != null)
            {
               events.dispatchEvent(new RoomEngineObjectEvent("REOE_CONTENT_UPDATED",_loc8_,param2,param3));
            }
         }
         if(param1 != "temporary_room")
         {
            addObjectToTileMap(_loc8_,_loc9_);
         }
      }
      
      public function objectsInitialized(param1:String) : void
      {
         if(events != null)
         {
            var _loc2_:int = getRoomId(param1);
            events.dispatchEvent(new RoomEngineEvent("REE_OBJECTS_INITIALIZED",0));
         }
      }
      
      public function selectAvatar(param1:int, param2:int) : void
      {
         if(var_126 != null)
         {
            var_126.setSelectedAvatar(param1,param2,true);
         }
      }
      
      public function getSelectedAvatarId() : int
      {
         if(var_126 != null)
         {
            return var_126.getSelectedAvatarId();
         }
         return -1;
      }
      
      public function selectRoomObject(param1:int, param2:int, param3:int) : void
      {
         if(var_126 == null)
         {
            return;
         }
         var_126.setSelectedObject(param1,param2,param3);
      }
      
      protected function addObjectToTileMap(param1:int, param2:IRoomObject) : void
      {
         var _loc3_:class_2247 = getRoomInstanceData(param1).tileObjectMap;
         if(_loc3_)
         {
            _loc3_.addRoomObject(param2);
         }
      }
      
      public function refreshTileObjectMap(param1:int, param2:String) : void
      {
         var _loc3_:class_2247 = getRoomInstanceData(param1).tileObjectMap;
         if(_loc3_)
         {
            _loc3_.populate(getRoomObjects(param1,10));
         }
         var_126.recalibrateMovements(param1);
      }
      
      private function showRoomAd(param1:AdEvent) : void
      {
         if(var_27 != null)
         {
            var _loc3_:IRoomObjectController = getObjectRoom(param1.roomId);
            return;
         }
      }
      
      public function requestRoomAdImage(param1:int, param2:int, param3:int, param4:String, param5:String) : void
      {
         if(_adManager != null)
         {
            _adManager.loadRoomAdImage(param1,param2,param3,param4,param5);
         }
      }
      
      private function onRoomAdImageLoaded(param1:AdEvent) : void
      {
         var _loc2_:RoomObjectRoomAdUpdateMessage = null;
         var _loc3_:IRoomObjectController = getObjectRoom(param1.roomId);
         if(_loc3_ == null)
         {
            return;
         }
         var _loc4_:IRoomObjectController = getObjectFurniture(param1.roomId,param1.objectId);
         if(_loc4_ == null || _loc4_.getEventHandler() == null)
         {
            return;
         }
         if(param1.image != null)
         {
            var_27.addGraphicAsset(_loc4_.getType(),param1.imageUrl,param1.image,true);
         }
         switch(param1.type)
         {
            case "AE_ROOM_AD_IMAGE_LOADED":
               _loc2_ = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADED",param1.imageUrl,param1.clickUrl,param1.objectId,param1.image);
               break;
            case "AE_ROOM_AD_IMAGE_LOADING_FAILED":
               _loc2_ = new RoomObjectRoomAdUpdateMessage("RORUM_ROOM_BILLBOARD_IMAGE_LOADING_FAILED",param1.imageUrl,param1.clickUrl,param1.objectId,param1.image);
         }
         if(_loc2_ != null)
         {
            _loc4_.getEventHandler().processUpdateMessage(_loc2_);
         }
      }
      
      public function insertContentLibrary(param1:int, param2:int, param3:class_40) : Boolean
      {
         return var_27.insertObjectContent(param1,param2,param3);
      }
      
      public function setActiveObjectType(param1:int, param2:String) : void
      {
         var_27.setActiveObjectType(param1,param2);
      }
      
      override public function purge() : void
      {
         super.purge();
         if(var_27)
         {
            var_27.purge();
         }
      }
      
      public function requestBadgeImageAsset(param1:int, param2:int, param3:int, param4:String, param5:Boolean = true) : void
      {
         var _loc10_:IRoomInstance = null;
         var _loc6_:Array = null;
         var _loc11_:IRoomObjectController = null;
         if(param1 == 0)
         {
            _loc10_ = _roomManager.getRoom("temporary_room");
            if(_loc10_ != null)
            {
               _loc11_ = _loc10_.getObject(param2,param3) as IRoomObjectController;
            }
         }
         else
         {
            _loc11_ = getObjectFurniture(param1,param2);
         }
         if(_loc11_ == null || _loc11_.getEventHandler() == null)
         {
            return;
         }
         var _loc8_:Function = param5 ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName;
         var _loc7_:String = _loc8_.call(null,param4);
         if(!_loc7_)
         {
            _loc7_ = "loading_icon";
            if(!var_671)
            {
               var_671 = new class_55();
            }
            if(var_671.length == 0)
            {
               _sessionDataManager.events.addEventListener("BIRE_BADGE_IMAGE_READY",onBadgeLoaded);
            }
            _loc6_ = var_671.getValue(param4);
            if(_loc6_ == null)
            {
               _loc6_ = [];
            }
            _loc6_.push(new class_2070(_loc11_,param5));
            var_671[param4] = _loc6_;
         }
         else
         {
            addBadgeGraphicAssets(_loc11_,param4,param5);
         }
         var _loc9_:RoomObjectGroupBadgeUpdateMessage = new RoomObjectGroupBadgeUpdateMessage(param4,_loc7_);
         if(_loc9_ != null)
         {
            _loc11_.getEventHandler().processUpdateMessage(_loc9_);
         }
      }
      
      private function addBadgeGraphicAssets(param1:IRoomObjectController, param2:String, param3:Boolean = false) : void
      {
         var _loc9_:Function = param3 ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName;
         var _loc10_:Function = param3 ? _sessionDataManager.getGroupBadgeSmallAssetName : _sessionDataManager.getBadgeImageSmallAssetName;
         var _loc11_:Function = param3 ? _sessionDataManager.getGroupBadgeImage : _sessionDataManager.getBadgeImage;
         var _loc8_:Function = param3 ? _sessionDataManager.getGroupBadgeSmallImage : _sessionDataManager.getBadgeSmallImage;
         var _loc7_:String = String(_loc9_.call(null,param2));
         var _loc4_:BitmapData = BitmapData(_loc11_.call(null,param2));
         var_27.addGraphicAsset(param1.getType(),_loc7_,_loc4_,false);
         var _loc5_:String = String(_loc10_.call(null,param2));
         var _loc6_:BitmapData = _loc8_.call(null,param2);
         if(_loc6_)
         {
            var_27.addGraphicAsset(param1.getType(),_loc5_,_loc6_,false);
         }
      }
      
      private function onBadgeLoaded(param1:BadgeImageReadyEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:class_2070 = null;
         var _loc5_:Function = null;
         var _loc6_:RoomObjectGroupBadgeUpdateMessage = null;
         var _loc2_:Array = var_671.getValue(param1.badgeId) as Array;
         if(_loc2_ == null)
         {
            class_21.log("Could not find matching objects for group badge asset request " + param1.badgeId);
            return;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_];
            addBadgeGraphicAssets(_loc3_.object,param1.badgeId,_loc3_.groupBadge);
            _loc5_ = _loc3_.groupBadge ? _sessionDataManager.getGroupBadgeAssetName : _sessionDataManager.getBadgeImageAssetName;
            _loc6_ = new RoomObjectGroupBadgeUpdateMessage(param1.badgeId,String(_loc5_.call(null,param1.badgeId)));
            if(_loc6_ != null && _loc3_.object.getEventHandler() != null)
            {
               _loc3_.object.getEventHandler().processUpdateMessage(_loc6_);
            }
            _loc4_++;
         }
         var_671.remove(param1.badgeId);
         if(var_671.length == 0)
         {
            _sessionDataManager.events.removeEventListener("BIRE_BADGE_IMAGE_READY",onBadgeLoaded);
         }
      }
      
      public function get isDecorateMode() : Boolean
      {
         if(!_roomSessionManager)
         {
            return false;
         }
         var _loc1_:IRoomSession = _roomSessionManager.getSession(var_71);
         return _loc1_ && _loc1_.isUserDecorating;
      }
      
      public function get isGameMode() : Boolean
      {
         return var_1798;
      }
      
      public function set isGameMode(param1:Boolean) : void
      {
         var_1798 = param1;
      }
      
      public function showUseProductSelection(param1:int, param2:int, param3:int = -1) : void
      {
         if(var_27 != null)
         {
            var _loc4_:String = var_27.getActiveObjectType(param2);
            var _loc5_:int = getRoomObjectCategory(null);
            events.dispatchEvent(new RoomEngineUseProductEvent("ROSM_USE_PRODUCT_FROM_INVENTORY",var_71,param3,0,param1,param2));
         }
      }
      
      public function setAvatarEffect(param1:int) : void
      {
         if(_sessionDataManager == null || _roomSessionManager == null)
         {
            return;
         }
         var _loc2_:IRoomSession = _roomSessionManager.getSession(var_71);
         if(_loc2_ == null)
         {
            return;
         }
         updateObjectUserEffect(activeRoomId,_loc2_.ownUserRoomId,param1);
      }
      
      public function setFpsCounterEnabled(param1:Boolean) : void
      {
         if(_sessionDataManager == null || _roomSessionManager == null)
         {
            return;
         }
         var _loc2_:IRoomRenderingCanvas = getActiveRoomActiveCanvas();
         if(_loc2_ != null)
         {
            _loc2_.fpsCounterEnabled = param1;
         }
      }
      
      public function get playerUnderCursor() : int
      {
         return var_3105;
      }
      
      public function get roomSessionManager() : IRoomSessionManager
      {
         return _roomSessionManager;
      }
      
      public function get sessionDataManager() : ISessionDataManager
      {
         return _sessionDataManager;
      }
      
      public function get toolbar() : IHabboToolbar
      {
         return _toolbar;
      }
      
      public function get catalog() : IHabboCatalog
      {
         return _catalog;
      }
      
      public function get roomEvents() : IHabboUserDefinedRoomEvents
      {
         return _roomEvents;
      }
      
      private function fixedUserLocation(param1:int, param2:IVector3d) : IVector3d
      {
         if(param2 == null)
         {
            return null;
         }
         var _loc5_:class_1934 = getFurniStackingHeightMap(param1);
         var _loc7_:class_1821 = getLegacyGeometry(param1);
         if(_loc5_ == null || _loc7_ == null)
         {
            return param2;
         }
         var _loc6_:Number = param2.z;
         var _loc3_:Number = _loc5_.getTileHeight(param2.x,param2.y);
         var _loc4_:Number = _loc7_.getTileHeight(param2.x,param2.y);
         if(Math.abs(_loc6_ - _loc3_) < 0.02 && Math.abs(_loc3_ - _loc4_) < 0.02)
         {
            _loc6_ = _loc7_.getFloorAltitude(param2.x,param2.y);
         }
         return new Vector3d(param2.x,param2.y,_loc6_);
      }
      
      private function get cameraFollowDuration() : int
      {
         return getBoolean("room.camera.follow_user") ? 1000 : 0;
      }
      
      public function get windowManager() : class_38
      {
         return _windowManager;
      }
      
      public function getRenderRoomMessage(param1:Rectangle, param2:uint, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false, param6:int = -1) : IMessageComposer
      {
         var _loc8_:IRoomRenderingCanvas = null;
         if(param6 > -1)
         {
            _loc8_ = getRoomCanvas(var_71,param6);
         }
         else
         {
            _loc8_ = getActiveRoomActiveCanvas();
         }
         if(!_loc8_)
         {
            return null;
         }
         if(param5)
         {
            _loc8_.skipSpriteVisibilityChecking();
         }
         var _loc12_:int = -1;
         if(!param4 && _roomSessionManager.getSession(var_71) != null)
         {
            _loc12_ = _roomSessionManager.getSession(var_71).ownUserRoomId;
         }
         var _loc11_:class_2200 = new class_2200();
         var _loc10_:String = _loc11_.getFurniData(param1,_loc8_,this,_loc12_);
         var _loc9_:String = _loc11_.getRoomRenderingModifiers(this);
         var _loc7_:Array = _loc11_.getRoomPlanes(param1,_loc8_,this,param2);
         if(param5)
         {
            _loc8_.resumeSpriteVisibilityChecking();
         }
         if(param3)
         {
            return new class_2077(_loc7_,_loc10_,_loc9_,var_71,_sessionDataManager.topSecurityLevel);
         }
         return new class_2076(_loc7_,_loc10_,_loc9_,var_71,_sessionDataManager.topSecurityLevel);
      }
      
      public function get roomContentLoader() : class_1835
      {
         return var_27;
      }
      
      public function isWhereYouClickWhereYouGo() : Boolean
      {
         return var_5339 && !isAreaSelectionMode();
      }
      
      public function isAreaSelectionMode() : Boolean
      {
         return var_1003.areaSelectionState != RoomAreaSelectionManager.NOT_ACTIVE;
      }
      
      public function setMoveBlocked(param1:Boolean) : void
      {
         var_4759 = param1;
      }
      
      public function isMoveBlocked() : Boolean
      {
         return var_4759;
      }
      
      public function get areaSelectionManager() : IRoomAreaSelectionManager
      {
         return var_1003;
      }
   }
}

