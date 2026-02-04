package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.habbo.room.messages.RoomObjectMoveUpdateMessage;
   import com.sulake.habbo.room.object.data.class_2108;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class FurniturePushableLogic extends FurnitureMultiStateLogic
   {
      
      private static const ANIMATION_NOT_MOVING:int = 0;
      
      private static const ANIMATION_MOVING:int = 1;
      
      private static const MAX_ANIMATION_COUNT:int = 10;
      
      private var var_3538:Vector3d = null;
      
      public function FurniturePushableLogic()
      {
         super();
         moveUpdateInterval = 500;
         var_3538 = new Vector3d();
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc3_:IVector3d = null;
         var _loc5_:IVector3d = null;
         var _loc6_:IVector3d = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:RoomObjectMoveUpdateMessage = param1 as RoomObjectMoveUpdateMessage;
         if(object != null && _loc4_ == null)
         {
            if(param1.loc != null)
            {
               _loc3_ = object.getLocation();
               _loc5_ = Vector3d.dif(param1.loc,_loc3_);
               if(_loc5_ != null)
               {
                  if(Math.abs(_loc5_.x) < 2 && Math.abs(_loc5_.y) < 2)
                  {
                     _loc6_ = _loc3_;
                     if(Math.abs(_loc5_.x) > 1 || Math.abs(_loc5_.y) > 1)
                     {
                        _loc6_ = Vector3d.sum(_loc3_,Vector3d.product(_loc5_,0.5));
                     }
                     _loc4_ = new RoomObjectMoveUpdateMessage(_loc6_,param1.loc,param1.dir);
                     super.processUpdateMessage(_loc4_);
                     return;
                  }
               }
            }
         }
         if(param1.loc != null && _loc4_ == null)
         {
            _loc4_ = new RoomObjectMoveUpdateMessage(param1.loc,param1.loc,param1.dir);
            super.processUpdateMessage(_loc4_);
         }
         var _loc2_:Number = Number(_loc4_ == null || isNaN(_loc4_.animationTime) ? 500 : _loc4_.animationTime);
         var _loc7_:RoomObjectDataUpdateMessage = param1 as RoomObjectDataUpdateMessage;
         if(_loc7_ != null)
         {
            if(_loc7_.state > 0)
            {
               moveUpdateInterval = _loc2_ / getUpdateIntervalValue(_loc7_.state);
            }
            else
            {
               moveUpdateInterval = 1;
            }
            handleDataUpdateMessage(_loc7_);
            return;
         }
         super.processUpdateMessage(param1);
      }
      
      protected function getUpdateIntervalValue(param1:int) : int
      {
         return param1 / 10;
      }
      
      protected function getAnimationValue(param1:int) : int
      {
         return param1 % 10;
      }
      
      private function handleDataUpdateMessage(param1:RoomObjectDataUpdateMessage) : void
      {
         var _loc2_:class_2108 = null;
         var _loc3_:int = getAnimationValue(param1.state);
         if(_loc3_ != param1.state)
         {
            _loc2_ = new class_2108();
            _loc2_.setString(String(_loc3_));
            param1 = new RoomObjectDataUpdateMessage(_loc3_,_loc2_,param1.extra);
         }
         super.processUpdateMessage(param1);
      }
      
      override public function update(param1:int) : void
      {
         if(object != null)
         {
            var_3538.assign(object.getLocation());
            super.update(param1);
            if(Vector3d.dif(object.getLocation(),var_3538).length == 0)
            {
               if(object.getState(0) != 0)
               {
                  object.setState(0,0);
               }
            }
         }
      }
   }
}

