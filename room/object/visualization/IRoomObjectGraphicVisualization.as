package com.sulake.room.object.visualization
{
   import com.sulake.room.object.visualization.utils.class_1805;
   
   public interface IRoomObjectGraphicVisualization extends IRoomObjectVisualization
   {
      
      function get assetCollection() : class_1805;
      
      function set assetCollection(param1:class_1805) : void;
      
      function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void;
   }
}

