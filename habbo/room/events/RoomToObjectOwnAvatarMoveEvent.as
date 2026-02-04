package com.sulake.habbo.room.events
{
   import com.sulake.room.events.RoomToObjectEvent;
   import com.sulake.room.utils.IVector3d;
   
   public class RoomToObjectOwnAvatarMoveEvent extends RoomToObjectEvent
   {
      
      public static const MOVE_TO:String = "ROAME_MOVE_TO";
      
      private var var_318:IVector3d;
      
      public function RoomToObjectOwnAvatarMoveEvent(param1:String, param2:IVector3d, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         var_318 = param2;
      }
      
      public function get targetLoc() : IVector3d
      {
         return var_318;
      }
   }
}

