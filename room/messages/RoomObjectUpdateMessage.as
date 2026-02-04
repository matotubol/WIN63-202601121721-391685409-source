package com.sulake.room.messages
{
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectUpdateMessage
   {
      
      protected var var_190:IVector3d;
      
      protected var var_772:IVector3d;
      
      public function RoomObjectUpdateMessage(param1:IVector3d, param2:IVector3d)
      {
         super();
         var_190 = param1;
         var_772 = param2;
      }
      
      public function get loc() : IVector3d
      {
         return var_190;
      }
      
      public function get dir() : IVector3d
      {
         return var_772;
      }
   }
}

