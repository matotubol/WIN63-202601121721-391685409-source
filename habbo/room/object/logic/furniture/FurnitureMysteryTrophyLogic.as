package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   
   public class FurnitureMysteryTrophyLogic extends FurnitureMultiStateLogic
   {
      
      public function FurnitureMysteryTrophyLogic()
      {
         super();
      }
      
      override public function get contextMenu() : String
      {
         return "MYSTERY_TROPHY";
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_MYSTERYTROPHY_OPEN_DIALOG"]);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_MYSTERYTROPHY_OPEN_DIALOG",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

