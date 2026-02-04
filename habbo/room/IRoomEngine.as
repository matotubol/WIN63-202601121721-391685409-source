package com.sulake.habbo.room
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.core.utils.class_55;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public interface IRoomEngine extends IUnknown
   {
      
      function get events() : IEventDispatcher;
      
      function get isInitialized() : Boolean;
      
      function get activeRoomId() : int;
      
      function createRoomCanvas(param1:int, param2:int, param3:int, param4:int, param5:int) : DisplayObject;
      
      function setRoomCanvasScale(param1:int, param2:int, param3:Number, param4:Point = null, param5:Point = null, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false) : void;
      
      function modifyRoomCanvas(param1:int, param2:int, param3:int, param4:int) : Boolean;
      
      function getObjectsByCategory(param1:int) : Array;
      
      function setRoomCanvasMask(param1:int, param2:int, param3:Boolean) : void;
      
      function getRoomCanvasGeometry(param1:int, param2:int = -1) : IRoomGeometry;
      
      function updateRoomCamera(param1:int, param2:int, param3:IVector3d, param4:uint) : void;
      
      function getRoomCanvasScreenOffset(param1:int, param2:int = -1) : Point;
      
      function setRoomCanvasScreenOffset(param1:int, param2:int, param3:Point) : Boolean;
      
      function getRoomCanvasScale(param1:int = -1000, param2:int = -1) : Number;
      
      function handleRoomCanvasMouseEvent(param1:int, param2:int, param3:int, param4:String, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean) : void;
      
      function setActiveRoom(param1:int) : void;
      
      function getRoomNumberValue(param1:int, param2:String) : Number;
      
      function getRoomStringValue(param1:int, param2:String) : String;
      
      function getFurnitureIconUrl(param1:int) : String;
      
      function getFurnitureIcon(param1:int, param2:class_1829, param3:String = null, param4:IStuffData = null, param5:Boolean = false) : class_2198;
      
      function getWallItemIconUrl(param1:int, param2:String = null) : String;
      
      function getWallItemIcon(param1:int, param2:class_1829, param3:String = null) : class_2198;
      
      function getFurnitureImage(param1:int, param2:IVector3d, param3:int, param4:class_1829, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1, param9:IStuffData = null, param10:Boolean = false) : class_2198;
      
      function getGenericRoomObjectImage(param1:String, param2:String, param3:IVector3d, param4:int, param5:class_1829, param6:uint = 0, param7:String = null, param8:IStuffData = null, param9:int = -1, param10:int = -1, param11:String = null, param12:int = -1) : class_2198;
      
      function getWallItemImage(param1:int, param2:IVector3d, param3:int, param4:class_1829, param5:uint = 0, param6:String = null, param7:int = -1, param8:int = -1) : class_2198;
      
      function getPetImage(param1:int, param2:int, param3:int, param4:IVector3d, param5:int, param6:class_1829, param7:Boolean = true, param8:uint = 0, param9:Array = null, param10:String = null) : class_2198;
      
      function getRoomImage(param1:String, param2:String, param3:String, param4:int, param5:class_1829, param6:String = null) : class_2198;
      
      function getRoomObjectImage(param1:int, param2:int, param3:int, param4:IVector3d, param5:int, param6:class_1829, param7:uint = 0) : class_2198;
      
      function getRoomObjectBoundingRectangle(param1:int, param2:int, param3:int, param4:int) : Rectangle;
      
      function getRoomObjectScreenLocation(param1:int, param2:int, param3:int, param4:int = -1) : Point;
      
      function getActiveRoomBoundingRectangle(param1:int) : Rectangle;
      
      function getRoomObjectCount(param1:int, param2:int) : int;
      
      function getRoomObject(param1:int, param2:int, param3:int) : IRoomObject;
      
      function getRoomObjectWithIndex(param1:int, param2:int, param3:int) : IRoomObject;
      
      function modifyRoomObject(param1:int, param2:int, param3:String) : Boolean;
      
      function modifyRoomObjectDataWithMap(param1:int, param2:int, param3:String, param4:class_55) : Boolean;
      
      function modifyRoomObjectData(param1:int, param2:int, param3:String, param4:String) : Boolean;
      
      function deleteRoomObject(param1:int, param2:int) : Boolean;
      
      function initializeRoomObjectInsert(param1:String, param2:int, param3:int, param4:int, param5:String = null, param6:IStuffData = null, param7:int = -1, param8:int = -1, param9:String = null, param10:Boolean = false) : Boolean;
      
      function cancelRoomObjectInsert() : void;
      
      function setObjectMoverIconSpriteVisible(param1:Boolean) : void;
      
      function getObjectMoverIconSpriteVisible() : Boolean;
      
      function selectAvatar(param1:int, param2:int) : void;
      
      function selectRoomObject(param1:int, param2:int, param3:int) : void;
      
      function getWorldType(param1:int) : String;
      
      function getSelectedObjectData(param1:int) : ISelectedRoomObjectData;
      
      function getSelectedAvatarId() : int;
      
      function updateObjectRoomColor(param1:int, param2:uint, param3:int, param4:Boolean) : Boolean;
      
      function updateObjectRoomBackgroundColor(param1:int, param2:Boolean, param3:int, param4:int, param5:int) : Boolean;
      
      function getPetColor(param1:int, param2:int) : PetColorResult;
      
      function getPetColorsByTag(param1:int, param2:String) : Array;
      
      function getPetLayerIdForTag(param1:int, param2:String) : int;
      
      function getPetDefaultPalette(param1:int, param2:String) : PetColorResult;
      
      function addObjectFurniture(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1) : Boolean;
      
      function changeObjectState(param1:int, param2:int, param3:int) : void;
      
      function changeObjectModelData(param1:int, param2:int, param3:int, param4:String, param5:int) : Boolean;
      
      function disposeObjectFurniture(param1:int, param2:int, param3:int = -1, param4:Boolean = false) : void;
      
      function addObjectWallItem(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String, param8:int = 0, param9:int = 0, param10:String = "", param11:int = -1, param12:Boolean = true) : Boolean;
      
      function updateObjectWallItemLocation(param1:int, param2:int, param3:IVector3d, param4:IVector3d = null, param5:Number = NaN) : Boolean;
      
      function disposeObjectWallItem(param1:int, param2:int, param3:int = -1) : void;
      
      function addObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Number, param6:int, param7:String = null) : Boolean;
      
      function addObjectSnowWar(param1:int, param2:int, param3:IVector3d, param4:int) : Boolean;
      
      function updateObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Boolean = false, param6:Number = 0, param7:IVector3d = null, param8:Number = NaN, param9:Number = NaN, param10:Boolean = false) : Boolean;
      
      function updateObjectUserFigure(param1:int, param2:int, param3:String, param4:String = null, param5:String = null, param6:Boolean = false) : Boolean;
      
      function updateObjectUserPosture(param1:int, param2:int, param3:String, param4:String = "") : Boolean;
      
      function updateObjectUserGesture(param1:int, param2:int, param3:int) : Boolean;
      
      function updateObjectUserEffect(param1:int, param2:int, param3:int, param4:int = 0) : Boolean;
      
      function updateObjectSnowWar(param1:int, param2:int, param3:IVector3d, param4:int) : Boolean;
      
      function disposeObjectSnowWar(param1:int, param2:int, param3:int) : void;
      
      function updateObjectUserAction(param1:int, param2:int, param3:String, param4:int, param5:String = null) : Boolean;
      
      function disposeObjectUser(param1:int, param2:int) : void;
      
      function updateObjectRoom(param1:int, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false) : Boolean;
      
      function getFurnitureType(param1:int) : String;
      
      function getFurnitureTypeId(param1:String) : int;
      
      function getWallItemType(param1:int, param2:String = null) : String;
      
      function useRoomObjectInActiveRoom(param1:int, param2:int) : Boolean;
      
      function initializeRoom(param1:int, param2:XML, param3:IVector3d = null, param4:Vector.<IAreaHideInfo> = null) : void;
      
      function disposeRoom(param1:int) : void;
      
      function get isDecorateMode() : Boolean;
      
      function set isGameMode(param1:Boolean) : void;
      
      function get isGameMode() : Boolean;
      
      function showUseProductSelection(param1:int, param2:int, param3:int = -1) : void;
      
      function setAvatarEffect(param1:int) : void;
      
      function setFpsCounterEnabled(param1:Boolean) : void;
      
      function setTileCursorState(param1:int, param2:int) : void;
      
      function toggleTileCursorVisibility(param1:int, param2:Boolean) : void;
      
      function addObjectUpdateCategory(param1:int) : void;
      
      function removeObjectUpdateCategory(param1:int) : void;
      
      function snapshotRoomCanvasToBitmap(param1:int, param2:int, param3:BitmapData, param4:Matrix, param5:Boolean) : Boolean;
      
      function set disableUpdate(param1:Boolean) : void;
      
      function runUpdate() : void;
      
      function updateObjectRoomVisibilities(param1:int, param2:Boolean, param3:Boolean = true) : Boolean;
      
      function get mouseEventsDisabledAboveY() : int;
      
      function set mouseEventsDisabledAboveY(param1:int) : void;
      
      function get mouseEventsDisabledLeftToX() : int;
      
      function set mouseEventsDisabledLeftToX(param1:int) : void;
      
      function getRenderRoomMessage(param1:Rectangle, param2:uint, param3:Boolean = false, param4:Boolean = true, param5:Boolean = false, param6:int = -1) : IMessageComposer;
      
      function createScreenShot(param1:int, param2:int, param3:String) : void;
      
      function purgeRoomContent() : void;
      
      function setMoveBlocked(param1:Boolean) : void;
      
      function get areaSelectionManager() : IRoomAreaSelectionManager;
      
      function get activeRoomHasHanditemControlBlocked() : Boolean;
   }
}

