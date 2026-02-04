package com.sulake.room.renderer
{
   import com.sulake.room.object.IRoomObject;
   
   [SecureSWF(rename="true")]
   public interface class_2018
   {
      
      function get roomObjectVariableAccurateZ() : String;
      
      function getRoomObject(param1:String) : IRoomObject;
      
      function getRoomObjectWithIndex(param1:int) : IRoomObject;
      
      function getRoomObjectIdWithIndex(param1:int) : String;
      
      function getRoomObjectCount() : int;
      
      function getRoomObjectIdentifier(param1:IRoomObject) : String;
   }
}

