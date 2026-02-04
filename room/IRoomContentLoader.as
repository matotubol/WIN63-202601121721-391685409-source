package com.sulake.room
{
   import com.sulake.core.assets.class_40;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.class_1805;
   import flash.events.IEventDispatcher;
   
   public interface IRoomContentLoader
   {
      
      function dispose() : void;
      
      function getPlaceHolderType(param1:String) : String;
      
      function getPlaceHolderTypes() : Array;
      
      function getContentType(param1:String) : String;
      
      function hasInternalContent(param1:String) : Boolean;
      
      function loadObjectContent(param1:String, param2:IEventDispatcher) : Boolean;
      
      function insertObjectContent(param1:int, param2:int, param3:class_40) : Boolean;
      
      function getVisualizationType(param1:String) : String;
      
      function getLogicType(param1:String) : String;
      
      function hasVisualizationXML(param1:String) : Boolean;
      
      function getVisualizationXML(param1:String) : XML;
      
      function hasAssetXML(param1:String) : Boolean;
      
      function getAssetXML(param1:String) : XML;
      
      function hasLogicXML(param1:String) : Boolean;
      
      function getLogicXML(param1:String) : XML;
      
      function getGraphicAssetCollection(param1:String) : class_1805;
      
      function roomObjectCreated(param1:IRoomObject, param2:String) : void;
   }
}

