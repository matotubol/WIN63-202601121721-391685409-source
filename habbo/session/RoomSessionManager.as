package com.sulake.habbo.session
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.ComponentDependency;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_15;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.utils.class_55;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.freeflowchat.class_51;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.events.RoomSessionEvent;
   import com.sulake.habbo.session.handler.AvatarEffectsHandler;
   import com.sulake.habbo.session.handler.BaseHandler;
   import com.sulake.habbo.session.handler.GenericErrorHandler;
   import com.sulake.habbo.session.handler.PetPackageHandler;
   import com.sulake.habbo.session.handler.PollHandler;
   import com.sulake.habbo.session.handler.PresentHandler;
   import com.sulake.habbo.session.handler.RoomChatHandler;
   import com.sulake.habbo.session.handler.RoomDataHandler;
   import com.sulake.habbo.session.handler.RoomDimmerPresetsHandler;
   import com.sulake.habbo.session.handler.RoomPermissionsHandler;
   import com.sulake.habbo.session.handler.RoomSessionHandler;
   import com.sulake.habbo.session.handler.RoomUsersHandler;
   import com.sulake.habbo.session.handler.WordQuizHandler;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.iid.*;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.Vector3d;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.system.System;
   import com.sulake.habbo.communication.messages.incoming.room.engine.RoomVisualizationSettingsEvent;
   import com.sulake.habbo.communication.messages.outgoing.roomdirectory.RoomNetworkOpenConnectionMessageComposer;
   
   public class RoomSessionManager extends class_17 implements IRoomSessionManager, IRoomHandlerListener
   {
      
      public static const const_38:uint = 2;
      
      public static const SETUP_WITHOUT_TRACKING:uint = 3;
      
      public static const const_532:uint = 4;
      
      private static const const_691:Number = 0.26;
      
      private var _communication:class_57 = null;
      
      private var _handlers:Array = null;
      
      private var var_3632:Boolean = false;
      
      private var var_332:class_55 = null;
      
      private var var_2290:RoomSession;
      
      private var var_2005:Boolean = false;
      
      private var _habboTracking:class_53;
      
      private var _roomEngine:IRoomEngine;
      
      private var _freeFlowChat:class_51;
      
      private var var_3965:Boolean;
      
      private var _avatarRenderer:class_48;
      
      private var var_2667:Boolean;
      
      private var var_1610:Array;
      
      private var var_4173:RoomSession;
      
      public function RoomSessionManager(param1:class_15, param2:uint = 0)
      {
         super(param1,param2);
         var_2667 = (param2 & 1) != 0;
         _handlers = [];
         var_332 = new class_55();
      }
      
      public function get initialized() : Boolean
      {
         return allRequiredDependenciesInjected && var_3632;
      }
      
      public function get sessionStarting() : Boolean
      {
         return var_2005;
      }
      
      override protected function get dependencies() : Vector.<ComponentDependency>
      {
         return super.dependencies.concat(new <ComponentDependency>[new ComponentDependency(new IIDHabboCommunicationManager(),function(param1:class_57):void
         {
            _communication = param1;
         },(flags & 2) == 0),new ComponentDependency(new IIDHabboTracking(),function(param1:class_53):void
         {
            _habboTracking = param1;
         },(flags & 3) == 0),new ComponentDependency(new IIDHabboFreeFlowChat(),function(param1:class_51):void
         {
            _freeFlowChat = param1;
         },false),new ComponentDependency(new IIDHabboConfigurationManager(),null),new ComponentDependency(new IIDRoomEngine(),function(param1:IRoomEngine):void
         {
            _roomEngine = param1;
         },(flags & 4) == 0,[{
            "type":"REE_ENGINE_INITIALIZED",
            "callback":onRoomEngineInitialized
         }]),new ComponentDependency(new IIDAvatarRenderManager(),function(param1:class_48):void
         {
            _avatarRenderer = param1;
         })]);
      }
      
      override protected function initComponent() : void
      {
         createHandlers();
         if(var_2667 && _communication != null)
         {
            _communication.addHabboConnectionMessageEvent(new RoomVisualizationSettingsEvent(onRoomVisualizationSettings));
         }
         executePendingSessionRequest();
      }
      
      override public function dispose() : void
      {
         var _loc4_:String = null;
         var _loc2_:RoomSession = null;
         var _loc3_:int = 0;
         var _loc1_:class_13 = null;
         if(disposed)
         {
            return;
         }
         if(var_332)
         {
            while(var_332.length > 0)
            {
               _loc4_ = var_332.getKey(0) as String;
               _loc2_ = var_332.remove(_loc4_) as RoomSession;
               if(_loc2_ != null)
               {
                  _loc2_.dispose();
               }
            }
            var_332.dispose();
            var_332 = null;
         }
         if(_handlers)
         {
            _loc3_ = 0;
            while(_loc3_ < _handlers.length)
            {
               _loc1_ = _handlers[_loc3_] as class_13;
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
               _loc3_++;
            }
            _handlers = null;
         }
         super.dispose();
      }
      
      private function onRoomEngineInitialized(param1:RoomEngineEvent) : void
      {
         var_3632 = true;
         executePendingSessionRequest();
      }
      
      private function createHandlers() : void
      {
         var _loc1_:IConnection = null;
         if(_communication)
         {
            _loc1_ = _communication.connection;
            _handlers.push(new RoomSessionHandler(_loc1_,this));
            _handlers.push(new RoomChatHandler(_loc1_,this));
            _handlers.push(new RoomUsersHandler(_loc1_,this));
            _handlers.push(new RoomPermissionsHandler(_loc1_,this));
            _handlers.push(new AvatarEffectsHandler(_loc1_,this));
            _handlers.push(new RoomDataHandler(_loc1_,this));
            _handlers.push(new PresentHandler(_loc1_,this));
            _handlers.push(new GenericErrorHandler(_loc1_,this));
            _handlers.push(new PollHandler(_loc1_,this));
            _handlers.push(new WordQuizHandler(_loc1_,this));
            _handlers.push(new RoomDimmerPresetsHandler(_loc1_,this));
            _handlers.push(new PetPackageHandler(_loc1_,this));
         }
      }
      
      private function executePendingSessionRequest() : void
      {
         if(initialized && var_2290 != null)
         {
            createSession(var_2290);
            var_2290 = null;
         }
      }
      
      private function onRoomVisualizationSettings(param1:RoomVisualizationSettingsEvent) : void
      {
         if(var_3965 || !var_2667)
         {
            return;
         }
         var_3965 = true;
         var _loc5_:IRoomSession = getSession(0);
         if(_loc5_ != null)
         {
            var _loc3_:int = 1;
            var _loc8_:int = 2;
            var _loc2_:int = 2;
            var _loc6_:int = 1024;
            var _loc9_:int = 768;
            var _loc4_:DisplayObject = _roomEngine.createRoomCanvas(_loc5_.roomId,0,0,0,64);
            if(_loc4_ != null)
            {
               context.displayObjectContainer.addChild(null);
               context.displayObjectContainer.addEventListener("resize",onResize);
               _roomEngine.setRoomCanvasMask(_loc5_.roomId,0,true);
               var _loc7_:IRoomGeometry = _roomEngine.getRoomCanvasGeometry(_loc5_.roomId,0);
               if(_loc7_ != null)
               {
                  null.adjustLocation(new Vector3d(0,0,0),30);
               }
               _roomEngine.setRoomCanvasScreenOffset(_loc5_.roomId,0,new Point(0,-400));
            }
            if(_freeFlowChat != null && _freeFlowChat.displayObject)
            {
               context.displayObjectContainer.addChild(_freeFlowChat.displayObject);
            }
         }
      }
      
      private function onResize(param1:Event) : void
      {
         if(!var_2667)
         {
            return;
         }
         var _loc2_:IRoomSession = getSession(0);
         if(_loc2_ == null)
         {
            return;
         }
         _roomEngine.modifyRoomCanvas(_loc2_.roomId,1,context.displayObjectContainer.width,context.displayObjectContainer.height);
      }
      
      public function gotoRoom(param1:int, param2:String = "", param3:String = "", param4:Boolean = false) : Boolean
      {
         var _loc5_:RoomSession = new RoomSession();
         _loc5_.roomId = param1;
         _loc5_.roomPassword = param2;
         _loc5_.roomResources = param3;
         _loc5_.skipOpc = param4;
         _loc5_.habboTracking = _habboTracking;
         return createSession(_loc5_);
      }
      
      public function gotoRoomNetwork(param1:int, param2:int) : Boolean
      {
         var _loc3_:RoomSession = new RoomSession();
         _loc3_.roomId = 1;
         _loc3_.roomPassword = "";
         _loc3_.habboTracking = _habboTracking;
         _loc3_.openConnectionComposer = new RoomNetworkOpenConnectionMessageComposer(param1,param2);
         return createSession(_loc3_);
      }
      
      private function createSession(param1:RoomSession) : Boolean
      {
         if(!initialized)
         {
            class_21.log("[RoomSessionManager] Not initialized, crating pending session for room: " + param1.roomId + ". Room Engine Initialized: " + var_3632);
            var_2290 = param1;
            return false;
         }
         var _loc2_:String = getRoomIdentifier(param1.roomId);
         var_2005 = true;
         if(var_332.getValue(_loc2_) != null)
         {
            disposeSession(param1.roomId,false);
         }
         param1.connection = _communication ? _communication.connection : null;
         var_332.add(_loc2_,param1);
         events.dispatchEvent(new RoomSessionEvent("RSE_CREATED",param1));
         if(var_2667)
         {
            _roomEngine.events.addEventListener("RCLE_SUCCESS",onRoomContentLoaded);
            var_1610 = [];
            var_4173 = param1;
            if(var_1610.length == 0)
            {
               startSession(param1);
            }
         }
         return true;
      }
      
      private function onRoomContentLoaded(param1:Event) : void
      {
         if(var_1610 == null || var_1610.length == 0)
         {
            return;
         }
         var _loc2_:int = int(var_1610.indexOf(param1["contentType"]));
         if(_loc2_ != -1)
         {
            var_1610.splice(_loc2_,1);
         }
         if(var_1610.length == 0)
         {
            startSession(var_4173);
         }
      }
      
      public function startSession(param1:IRoomSession) : Boolean
      {
         if(param1.state == "RSE_STARTED")
         {
            return false;
         }
         if(param1.isGameSession)
         {
            return true;
         }
         if(param1.start())
         {
            var_2005 = false;
            events.dispatchEvent(new RoomSessionEvent("RSE_STARTED",param1));
            updateHandlers(param1);
            return true;
         }
         disposeSession(param1.roomId);
         var_2005 = false;
         return false;
      }
      
      public function startGameSession() : void
      {
         var _loc1_:RoomSession = new RoomSession();
         _loc1_.roomId = 1;
         _loc1_.habboTracking = _habboTracking;
         _loc1_.isGameSession = true;
         _loc1_.connection = _communication.connection;
         var_332.add(getRoomIdentifier(_loc1_.roomId),_loc1_);
         events.dispatchEvent(new RoomSessionEvent("RSE_CREATED",_loc1_));
      }
      
      public function disposeGameSession() : void
      {
         var _loc2_:String = getRoomIdentifier(1);
         var _loc1_:RoomSession = var_332.getValue(_loc2_);
         if(_loc1_ && _loc1_.isGameSession)
         {
            disposeSession(1,false);
         }
      }
      
      public function sessionUpdate(param1:int, param2:String) : void
      {
         var _loc3_:IRoomSession = getSession(param1);
         if(_loc3_ != null)
         {
            switch(param2)
            {
               case "RS_DISCONNECTED":
                  disposeSession(param1);
                  break;
               case "RS_CONNECTED":
               case "RS_READY":
            }
         }
      }
      
      public function sessionReinitialize(param1:int, param2:int) : void
      {
         var _loc5_:String = getRoomIdentifier(param1);
         var _loc3_:RoomSession = var_332.remove(_loc5_) as RoomSession;
         if(_loc3_ == null)
         {
            _loc3_ = new RoomSession();
            _loc3_.roomId = param1;
            _loc3_.skipOpc = true;
            _loc3_.habboTracking = _habboTracking;
            createSession(_loc3_);
         }
         _loc3_.reset(param2);
         _loc5_ = getRoomIdentifier(param2);
         var _loc4_:RoomSession = var_332.remove(_loc5_);
         if(_loc4_ != null)
         {
         }
         var_332.add(_loc5_,_loc3_);
         updateHandlers(_loc3_);
      }
      
      public function getSession(param1:int) : IRoomSession
      {
         var _loc2_:String = getRoomIdentifier(param1);
         return var_332.getValue(_loc2_) as IRoomSession;
      }
      
      public function disposeSession(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:String = getRoomIdentifier(param1);
         var _loc3_:RoomSession = var_332.remove(_loc4_) as RoomSession;
         if(_loc3_ != null)
         {
            events.dispatchEvent(new RoomSessionEvent("RSE_ENDED",_loc3_,param2));
            _loc3_.dispose();
            _roomEngine.purgeRoomContent();
            if(!_avatarRenderer)
            {
            }
            System.pauseForGCIfCollectionImminent(0.26);
         }
      }
      
      private function updateHandlers(param1:IRoomSession) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseHandler = null;
         if(param1 != null && _handlers != null)
         {
            _loc3_ = 0;
            while(_loc3_ < _handlers.length)
            {
               _loc2_ = _handlers[_loc3_] as BaseHandler;
               if(_loc2_ != null)
               {
                  _loc2_.var_56 = param1.roomId;
               }
               _loc3_++;
            }
         }
      }
      
      private function getRoomIdentifier(param1:int) : String
      {
         return "hard_coded_room_id";
      }
   }
}

