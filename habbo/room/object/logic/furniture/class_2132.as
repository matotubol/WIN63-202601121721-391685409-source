package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectFloorHoleEvent;
   import com.sulake.habbo.room.messages.RoomObjectDataUpdateMessage;
   import com.sulake.room.messages.RoomObjectUpdateMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.Vector3d;
   
   public class class_2132 extends FurnitureMultiStateLogic
   {
      
      private static const STATE_HOLE:int = 0;
      
      private var var_1857:int = -1;
      
      private var var_235:Vector3d = null;
      
      public function class_2132()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(var_1857 == 0)
         {
            eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent("ROFHO_REMOVE_HOLE",object));
         }
         super.dispose();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROFHO_ADD_HOLE","ROFHO_REMOVE_HOLE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function processUpdateMessage(param1:RoomObjectUpdateMessage) : void
      {
         var _loc4_:RoomObjectDataUpdateMessage = null;
         var _loc3_:int = 0;
         var _loc2_:IVector3d = null;
         super.processUpdateMessage(param1);
         if(object != null)
         {
            _loc4_ = param1 as RoomObjectDataUpdateMessage;
            if(_loc4_ != null)
            {
               _loc3_ = int(object.getState(0));
               handleStateUpdate(_loc3_);
            }
            _loc2_ = object.getLocation();
            if(var_235 == null)
            {
               var_235 = new Vector3d();
            }
            else if(_loc2_.x != var_235.x || _loc2_.y != var_235.y)
            {
               if(var_1857 == 0)
               {
                  if(eventDispatcher != null)
                  {
                     eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent("ROFHO_ADD_HOLE",object));
                  }
               }
            }
            var_235.assign(_loc2_);
         }
      }
      
      private function handleStateUpdate(param1:int) : void
      {
         if(param1 != var_1857)
         {
            if(eventDispatcher != null)
            {
               if(param1 == 0)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent("ROFHO_ADD_HOLE",object));
               }
               else if(var_1857 == 0)
               {
                  eventDispatcher.dispatchEvent(new RoomObjectFloorHoleEvent("ROFHO_REMOVE_HOLE",object));
               }
            }
            var_1857 = param1;
         }
      }
      
      private function handleAutomaticStateUpdate() : void
      {
         var _loc3_:IRoomObjectModel = null;
         var _loc2_:Number = NaN;
         var _loc4_:int = 0;
         var _loc1_:IRoomObject = object;
         if(_loc1_ != null)
         {
            _loc3_ = _loc1_.getModel();
            if(_loc3_ != null)
            {
               _loc2_ = _loc3_.getNumber("furniture_automatic_state_index");
               if(!isNaN(_loc2_))
               {
                  _loc4_ = _loc2_;
                  _loc4_ = _loc4_ % 2;
                  handleStateUpdate(_loc4_);
               }
            }
         }
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         handleAutomaticStateUpdate();
      }
   }
}

