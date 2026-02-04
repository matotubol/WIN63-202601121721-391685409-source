package com.sulake.habbo.room.object.logic.furniture
{
   import com.sulake.habbo.room.events.RoomObjectWidgetRequestEvent;
   
   public class class_1905 extends FurnitureGuildCustomizedLogic
   {
      
      public function class_1905()
      {
         super();
      }
      
      override protected function openContextMenu() : void
      {
      }
      
      override protected function updateGuildId(param1:String) : void
      {
         super.updateGuildId(param1);
         object.getModelController().setString("furniture_internal_link","groupforum/" + param1);
      }
      
      override public function useObject() : void
      {
         if(eventDispatcher != null && object != null)
         {
            eventDispatcher.dispatchEvent(new RoomObjectWidgetRequestEvent("ROWRE_INTERNAL_LINK",object));
         }
         super.useObject();
      }
      
      override public function getEventTypes() : Array
      {
         return getAllEventTypes(super.getEventTypes(),["ROWRE_INTERNAL_LINK"]);
      }
   }
}

