package com.sulake.habbo.room
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public interface IStuffData
   {
      
      function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void;
      
      function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void;
      
      function writeRoomObjectModel(param1:IRoomObjectModelController) : void;
      
      function getLegacyString() : String;
      
      function getJSONValue(param1:String) : String;
      
      function compare(param1:IStuffData) : Boolean;
      
      function set flags(param1:int) : void;
      
      function get uniqueSerialNumber() : int;
      
      function get uniqueSeriesSize() : int;
      
      function set uniqueSerialNumber(param1:int) : void;
      
      function set uniqueSeriesSize(param1:int) : void;
      
      function get rarityLevel() : int;
   }
}

