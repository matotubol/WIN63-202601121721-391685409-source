package com.sulake.habbo.room
{
   import com.sulake.core.runtime.class_16;
   import com.sulake.habbo.room.utils.class_1821;
   import com.sulake.habbo.room.utils.class_1934;
   import com.sulake.habbo.room.utils.class_2247;
   import com.sulake.habbo.session.IRoomSessionManager;
   import com.sulake.habbo.session.ISessionDataManager;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.IRoomInstance;
   import com.sulake.room.object.IRoomObjectController;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.RoomGeometry;
   
   [SecureSWF(rename="true")]
   public interface class_30 extends class_29
   {
      
      function initializeRoom(param1:int, param2:XML, param3:IVector3d = null, param4:Vector.<IAreaHideInfo> = null) : void;
      
      function getRoom(param1:int) : IRoomInstance;
      
      function disposeRoom(param1:int) : void;
      
      function setOwnUserId(param1:int, param2:int) : void;
      
      function setWorldType(param1:int, param2:String) : void;
      
      function getObjectRoom(param1:int) : IRoomObjectController;
      
      function setFurniStackingHeightMap(param1:int, param2:class_1934) : void;
      
      function getFurniStackingHeightMap(param1:int) : class_1934;
      
      function getLegacyGeometry(param1:int) : class_1821;
      
      function getRoomGeometry(param1:int) : RoomGeometry;
      
      function getTileObjectMap(param1:int) : class_2247;
      
      function getRoomNumberValue(param1:int, param2:String) : Number;
      
      function getRoomStringValue(param1:int, param2:String) : String;
      
      function setIsPlayingGame(param1:int, param2:Boolean) : void;
      
      function leaveSpectate() : void;
      
      function setHanditemControlBlocked(param1:int, param2:Boolean) : void;
      
      function refreshTileObjectMap(param1:int, param2:String) : void;
      
      function get configuration() : class_16;
      
      function get roomSessionManager() : IRoomSessionManager;
      
      function get sessionDataManager() : ISessionDataManager;
      
      function get windowManager() : class_38;
   }
}

