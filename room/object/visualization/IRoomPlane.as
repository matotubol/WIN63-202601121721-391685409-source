package com.sulake.room.object.visualization
{
   import com.sulake.room.utils.IRoomGeometry;
   import com.sulake.room.utils.IVector3d;
   
   public interface IRoomPlane
   {
      
      function get uniqueId() : int;
      
      function get location() : IVector3d;
      
      function get leftSide() : IVector3d;
      
      function get rightSide() : IVector3d;
      
      function get color() : uint;
      
      function getDrawingDatas(param1:IRoomGeometry) : Array;
   }
}

