package com.sulake.habbo.room.messages
{
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectAvatarDirectionUpdateMessage extends RoomObjectUpdateMessage
   {
      
      private var var_3962:int;
      
      public function RoomObjectAvatarDirectionUpdateMessage(param1:IVector3d, param2:IVector3d, param3:int)
      {
         super(param1,param2);
         var_3962 = param3;
      }
      
      public function get dirHead() : int
      {
         return var_3962;
      }
   }
}

