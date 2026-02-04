package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetRoomChangedEvent extends Event
   {
      
      public function CatalogWidgetRoomChangedEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("CWE_ROOM_CHANGED",param1,param2);
      }
   }
}

