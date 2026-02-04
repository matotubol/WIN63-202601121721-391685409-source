package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetShowPlaceholderEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class PlaceholderWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function PlaceholderWidgetHandler()
      {
         super();
      }
      
      public function dispose() : void
      {
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function get type() : String
      {
         return null;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return ["RWFWM_MESSAGE_REQUEST_PLACEHOLDER"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetShowPlaceholderEvent = null;
         var _loc3_:* = param1.type;
         _loc2_ = new RoomWidgetShowPlaceholderEvent("RWSPE_SHOW_PLACEHOLDER");
         _container.events.dispatchEvent(_loc2_);
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
   }
}

