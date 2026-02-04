package com.sulake.habbo.room
{
   import com.sulake.room.utils.IVector3d;
   
   [SecureSWF(rename="true")]
   public interface class_29
   {
      
      function addObjectFurniture(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN, param9:int = -1, param10:int = 0, param11:int = 0, param12:String = "", param13:Boolean = true, param14:Boolean = true, param15:Number = -1) : Boolean;
      
      function addObjectFurnitureByName(param1:int, param2:int, param3:String, param4:IVector3d, param5:IVector3d, param6:int, param7:IStuffData, param8:Number = NaN) : Boolean;
      
      function updateObjectFurniture(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:int, param6:IStuffData, param7:Number = NaN) : Boolean;
      
      function updateObjectFurnitureHeight(param1:int, param2:int, param3:Number) : Boolean;
      
      function updateObjectFurnitureLocation(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:IVector3d, param6:Number = NaN) : Boolean;
      
      function updateObjectFurnitureExpiryTime(param1:int, param2:int, param3:int) : Boolean;
      
      function disposeObjectFurniture(param1:int, param2:int, param3:int = -1, param4:Boolean = false) : void;
      
      function addObjectWallItem(param1:int, param2:int, param3:int, param4:IVector3d, param5:IVector3d, param6:int, param7:String, param8:int = 0, param9:int = 0, param10:String = "", param11:int = -1, param12:Boolean = true) : Boolean;
      
      function updateObjectWallItem(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:int, param6:String) : Boolean;
      
      function updateObjectWallItemState(param1:int, param2:int, param3:int, param4:String) : Boolean;
      
      function updateObjectWallItemData(param1:int, param2:int, param3:String) : Boolean;
      
      function updateObjectWallItemLocation(param1:int, param2:int, param3:IVector3d, param4:IVector3d = null, param5:Number = NaN) : Boolean;
      
      function updateObjectWallItemExpiryTime(param1:int, param2:int, param3:int) : Boolean;
      
      function disposeObjectWallItem(param1:int, param2:int, param3:int = -1) : void;
      
      function addObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Number, param6:int, param7:String = null) : Boolean;
      
      function updateObjectUser(param1:int, param2:int, param3:IVector3d, param4:IVector3d, param5:Boolean = false, param6:Number = 0, param7:IVector3d = null, param8:Number = NaN, param9:Number = NaN, param10:Boolean = false) : Boolean;
      
      function updateObjectUserDir(param1:int, param2:int, param3:IVector3d, param4:Number) : Boolean;
      
      function updateObjectUserFlatControl(param1:int, param2:int, param3:String) : Boolean;
      
      function updateObjectUserOwnUserAvatar(param1:int, param2:int) : Boolean;
      
      function updateObjectUserFigure(param1:int, param2:int, param3:String, param4:String = null, param5:String = null, param6:Boolean = false) : Boolean;
      
      function updateObjectUserBlocked(param1:int, param2:int, param3:Boolean) : Boolean;
      
      function updateObjectUserAction(param1:int, param2:int, param3:String, param4:int, param5:String = null) : Boolean;
      
      function updateObjectUserPosture(param1:int, param2:int, param3:String, param4:String = "") : Boolean;
      
      function updateObjectUserGesture(param1:int, param2:int, param3:int) : Boolean;
      
      function updateObjectPetGesture(param1:int, param2:int, param3:String) : Boolean;
      
      function updateObjectUserEffect(param1:int, param2:int, param3:int, param4:int = 0) : Boolean;
      
      function disposeObjectUser(param1:int, param2:int) : void;
      
      function updateObjectRoom(param1:int, param2:String = null, param3:String = null, param4:String = null, param5:Boolean = false) : Boolean;
      
      function updateObjectRoomColor(param1:int, param2:uint, param3:int, param4:Boolean) : Boolean;
      
      function updateObjectRoomBackgroundColor(param1:int, param2:Boolean, param3:int, param4:int, param5:int) : Boolean;
      
      function updateObjectRoomVisibilities(param1:int, param2:Boolean, param3:Boolean = true) : Boolean;
      
      function updateObjectRoomPlaneThicknesses(param1:int, param2:Number, param3:Number) : Boolean;
      
      function updateAreaHide(param1:int, param2:int, param3:Boolean, param4:int, param5:int, param6:int, param7:int, param8:Boolean) : Boolean;
      
      function setRoomObjectAlias(param1:String, param2:String) : void;
      
      function getPetTypeId(param1:String) : int;
   }
}

