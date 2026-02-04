package com.sulake.habbo.ui
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.runtime.class_16;
   import com.sulake.habbo.avatar.class_141;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
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
   import com.sulake.habbo.roomevents.IHabboUserDefinedRoomEvents;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.toolbar.IHabboToolbar;
   import com.sulake.habbo.tracking.class_53;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public interface IRoomWidgetHandlerContainer
   {
      
      function get habboTracking() : class_53;
      
      function get roomSession() : IRoomSession;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function get events() : IEventDispatcher;
      
      function get roomEngine() : IRoomEngine;
      
      function get friendList() : class_258;
      
      function get avatarRenderManager() : class_48;
      
      function get inventory() : class_61;
      
      function get toolbar() : IHabboToolbar;
      
      function get navigator() : class_41;
      
      function get habboGroupsManager() : class_140;
      
      function get roomWidgetFactory() : IRoomWidgetFactory;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get avatarEditor() : class_141;
      
      function get catalog() : IHabboCatalog;
      
      function get localization() : class_27;
      
      function get habboHelp() : IHabboHelp;
      
      function get config() : class_16;
      
      function get soundManager() : class_544;
      
      function get messenger() : class_46;
      
      function get moderation() : IHabboModeration;
      
      function get windowManager() : class_38;
      
      function get userDefinedRoomEvents() : IHabboUserDefinedRoomEvents;
      
      function get connection() : IConnection;
      
      function get gameManager() : class_45;
      
      function get questEngine() : class_498;
      
      function get freeFlowChat() : class_51;
      
      function get layoutManager() : class_3019;
      
      function setRoomViewColor(param1:uint, param2:int) : void;
      
      function getFirstCanvasId() : int;
      
      function getRoomViewRect() : Rectangle;
      
      function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent;
      
      function addUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function removeUpdateListener(param1:IRoomWidgetHandler) : void;
      
      function isOwnerOfFurniture(param1:IRoomObject) : Boolean;
      
      function getFurnitureOwnerId(param1:IRoomObject) : int;
      
      function isOwnerOfPet(param1:class_2146) : Boolean;
      
      function setRoomBackgroundColor(param1:int, param2:int, param3:int) : void;
   }
}

