package com.sulake.room.object
{
   import com.sulake.room.object.logic.IRoomObjectMouseHandler;
   import com.sulake.room.object.visualization.IRoomObjectVisualization;
   import com.sulake.room.utils.IVector3d;
   
   public interface IRoomObject
   {
      
      function getId() : int;
      
      function getInstanceId() : int;
      
      function getType() : String;
      
      function isInitialized() : Boolean;
      
      function getLocation() : IVector3d;
      
      function getDirection() : IVector3d;
      
      function getModel() : IRoomObjectModel;
      
      function getVisualization() : IRoomObjectVisualization;
      
      function getMouseHandler() : IRoomObjectMouseHandler;
      
      function getAvatarLibraryAssetName() : String;
      
      function getState(param1:int) : int;
      
      function getUpdateID() : int;
      
      function tearDown() : void;
   }
}

