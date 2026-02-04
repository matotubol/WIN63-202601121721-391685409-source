package com.sulake.room.object
{
   import com.sulake.core.runtime.IUnknown;
   import com.sulake.room.object.visualization.IRoomObjectGraphicVisualization;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.object.visualization.utils.class_1805;
   
   public interface IRoomObjectVisualizationFactory extends IUnknown
   {
      
      function createRoomObjectVisualization(param1:String) : IRoomObjectGraphicVisualization;
      
      function createGraphicAssetCollection() : class_1805;
      
      function getRoomObjectVisualizationData(param1:String, param2:String, param3:XML) : IRoomObjectVisualizationData;
   }
}

