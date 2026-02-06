package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.requirementsmissing.CustomUserNotificationWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.CustomUserNotificationMessageEvent;
   
   public class CustomUserNotificationWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1134:Boolean = false;
      
      private var var_16:CustomUserNotificationWidget;
      
      private var var_1591:IMessageEvent;
      
      public function CustomUserNotificationWidgetHandler()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_CUSTOM_USER_NOTIFICATION";
      }
      
      public function set widget(param1:CustomUserNotificationWidget) : void
      {
         var_16 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         if(!var_1591)
         {
            var_1591 = new CustomUserNotificationMessageEvent(onFurnitureUsageRequirementMissingMessage);
            _container.connection.addMessageEvent(var_1591);
         }
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
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
         return null;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(_container.connection && var_1591)
            {
               _container.connection.removeMessageEvent(var_1591);
            }
            var_1591 = null;
            var_16 = null;
            _container = null;
            var_1134 = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function onFurnitureUsageRequirementMissingMessage(param1:CustomUserNotificationMessageEvent) : void
      {
         var _loc2_:int = param1.getParser().code;
         if(var_16)
         {
            switch(_loc2_ - 1)
            {
               case 0:
                  var_16.open("costumehopper");
                  break;
               case 1:
                  var_16.open("viphopper");
                  break;
               case 2:
                  var_16.open("vipgate");
                  break;
               case 3:
                  var_16.open("respectfailedstage");
                  break;
               case 4:
                  var_16.open("respectfailedaudience");
            }
         }
      }
   }
}

