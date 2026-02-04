package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   import com.sulake.room.events.RoomObjectEvent;
   
   public class class_1868 extends FurnitureMultiStateLogic
   {
      
      public function class_1868()
      {
         super();
      }
      
      override public function get contextMenu() : String
      {
         return "EFFECT_BOX";
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_EFFECTBOX_OPEN_DIALOG"]);
      }
      
      override public function useObject() : void
      {
         var _loc1_:RoomObjectEvent = null;
         if(eventDispatcher != null && object != null)
         {
            _loc1_ = new RoomObjectWidgetRequestEvent("ROWRE_EFFECTBOX_OPEN_DIALOG",object);
            eventDispatcher.dispatchEvent(_loc1_);
         }
      }
   }
}

