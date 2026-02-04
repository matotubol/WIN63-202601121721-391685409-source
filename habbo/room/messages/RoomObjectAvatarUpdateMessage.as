package com.sulake.habbo.room.messages
{
   import com.sulake.room.utils.IVector3d;
   
   public class RoomObjectAvatarUpdateMessage extends RoomObjectMoveUpdateMessage
   {
      
      private var var_3962:int;
      
      private var var_4738:Boolean;
      
      private var var_3100:Number;
      
      public function RoomObjectAvatarUpdateMessage(param1:IVector3d, param2:IVector3d, param3:IVector3d, param4:int, param5:Boolean, param6:Number, param7:Number = NaN, param8:* = false)
      {
         super(param1,param2,param3,param7,false,param8);
         var_3962 = param4;
         var_4738 = param5;
         var_3100 = param6;
      }
      
      public function get dirHead() : int
      {
         return var_3962;
      }
      
      public function get canStandUp() : Boolean
      {
         return var_4738;
      }
      
      public function get baseY() : Number
      {
         return var_3100;
      }
   }
}

