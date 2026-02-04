package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   
   public class class_1990 extends FurnitureMultiStateLogic
   {
      
      public function class_1990()
      {
         super();
      }
      
      override public function get contextMenu() : String
      {
         return "MONSTERPLANT_SEED";
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG"]);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_MONSTERPLANT_SEED_PLANT_CONFIRMATION_DIALOG",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

