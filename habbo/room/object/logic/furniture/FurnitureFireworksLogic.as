package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.object.IRoomObjectModelController;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureFireworksLogic extends class_1738
   {
      
      public function FurnitureFireworksLogic()
      {
         super();
      }
      
      override public function getEventTypes() : Array
      {
         var _loc1_:Array = ["ROSCE_STATE_CHANGE"];
         return getAllEventTypes(super.getEventTypes(),_loc1_);
      }
      
      override public function mouseEvent(param1:RoomSpriteMouseEvent, param2:IRoomGeometry) : void
      {
         var _loc3_:RoomObjectEvent = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(object == null)
         {
            return;
         }
         var _loc4_:* = param1.type;
         if("doubleClick" === _loc4_)
         {
            switch(param1.spriteTag)
            {
               case "start_stop":
                  _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,1);
                  break;
               case "reset":
                  _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,2);
            }
         }
         if(eventDispatcher != null && _loc3_ != null)
         {
            eventDispatcher.dispatchEvent(_loc3_);
         }
         else
         {
            super.mouseEvent(param1,param2);
         }
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(object != null)
         {
            _loc1_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,0);
            if(eventDispatcher != null)
            {
               eventDispatcher.dispatchEvent(_loc1_);
            }
         }
      }
      
      override public function initialize(param1:XML) : void
      {
         var _loc3_:IRoomObjectModelController = null;
         super.initialize(param1);
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.particlesystems;
         if(_loc2_.length() == 0)
         {
            return;
         }
         if(object != null)
         {
            _loc3_ = object.getModelController();
            if(_loc3_ != null)
            {
               _loc3_.setString("furniture_fireworks_data",String(_loc2_));
            }
         }
      }
   }
}

