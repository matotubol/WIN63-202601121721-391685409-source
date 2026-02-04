package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomToObjectOwnAvatarMoveEvent;
   import com.sulake.room.utils.IVector3d;
   
   public class class_2220 extends class_1738
   {
      
      public function class_2220()
      {
         super();
      }
      
      override public function initialize(param1:XML) : void
      {
         super.initialize(param1);
         eventDispatcher.addEventListener("ROAME_MOVE_TO",onOwnAvatarMove);
      }
      
      override public function tearDown() : void
      {
         eventDispatcher.removeEventListener("ROAME_MOVE_TO",onOwnAvatarMove);
         super.tearDown();
      }
      
      private function onOwnAvatarMove(param1:RoomToObjectOwnAvatarMoveEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:IVector3d = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(object == null)
         {
            return;
         }
         var _loc2_:IVector3d = object.getLocation();
         if(param1.targetLoc)
         {
            _loc6_ = int(object.getModel().getNumber("furniture_size_x"));
            _loc5_ = int(object.getModel().getNumber("furniture_size_y"));
            _loc7_ = object.getDirection();
            _loc3_ = 0;
            _loc4_ = (int(_loc7_.x + 45)) % 360 / 90;
            if(_loc4_ == 1 || _loc4_ == 3)
            {
               _loc3_ = _loc6_;
               _loc6_ = _loc5_;
               _loc5_ = _loc3_;
            }
            if(param1.targetLoc.x >= _loc2_.x && param1.targetLoc.x < _loc2_.x + _loc6_ && (param1.targetLoc.y >= _loc2_.y && param1.targetLoc.y < _loc2_.y + _loc5_))
            {
               object.setState(1,0);
            }
            else
            {
               object.setState(0,0);
            }
         }
      }
   }
}

