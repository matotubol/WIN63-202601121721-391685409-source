package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectStateChangeEvent;
   import com.sulake.room.events.RoomObjectEvent;
   import com.sulake.room.events.RoomSpriteMouseEvent;
   import com.sulake.room.utils.IRoomGeometry;
   
   public class FurnitureHockeyScoreLogic extends class_1738
   {
      
      public function FurnitureHockeyScoreLogic()
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
         switch(param1.type)
         {
            case "doubleClick":
               var _loc4_:* = param1.spriteTag;
               if("off" !== _loc4_)
               {
                  break;
               }
               _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,3);
               break;
            case "click":
               switch(param1.spriteTag)
               {
                  case "inc":
                     _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,2);
                     break;
                  case "dec":
                     _loc3_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,1);
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
            _loc1_ = new RoomObjectStateChangeEvent("ROSCE_STATE_CHANGE",object,3);
            if(eventDispatcher != null)
            {
               eventDispatcher.dispatchEvent(_loc1_);
            }
         }
      }
   }
}

