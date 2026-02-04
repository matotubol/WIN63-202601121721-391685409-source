package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class LoadingBarWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function LoadingBarWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_LOADINGBAR";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function dispose() : void
      {
         var_1134 = true;
         _container = null;
      }
      
      public function getWidgetMessages() : Array
      {
         return [];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push("RWLBUE_SHOW_LOADING_BAR");
         _loc1_.push("RWLBUW_HIDE_LOADING_BAR");
         return _loc1_;
      }
      
      public function processEvent(param1:Event) : void
      {
         if(_container == null || _container.events == null)
         {
            return;
         }
         switch(param1.type)
         {
            case "RWLBUE_SHOW_LOADING_BAR":
               _container.events.dispatchEvent(param1);
               break;
            case "RWLBUW_HIDE_LOADING_BAR":
               _container.events.dispatchEvent(param1);
         }
      }
      
      public function update() : void
      {
      }
   }
}

