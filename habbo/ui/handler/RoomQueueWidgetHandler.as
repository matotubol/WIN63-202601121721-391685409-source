package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.events.RoomSessionQueueEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomQueueUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetRoomQueueMessage;
   import flash.events.Event;
   
   public class RoomQueueWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function RoomQueueWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_CHAT_WIDGET";
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
         var _loc1_:Array = [];
         _loc1_.push("RWRQM_EXIT_QUEUE");
         _loc1_.push("RWRQM_CHANGE_TO_SPECTATOR_QUEUE");
         _loc1_.push("RWRQM_CHANGE_TO_VISITOR_QUEUE");
         _loc1_.push("RWRQM_CLUB_LINK");
         return _loc1_;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         if(_container == null || _container.roomSession == null)
         {
            return null;
         }
         var _loc2_:RoomWidgetRoomQueueMessage = param1 as RoomWidgetRoomQueueMessage;
         if(_loc2_ == null)
         {
            return null;
         }
         switch(param1.type)
         {
            case "RWRQM_EXIT_QUEUE":
               _container.roomSession.quit();
               break;
            case "RWRQM_CHANGE_TO_SPECTATOR_QUEUE":
               _container.roomSession.changeQueue(1);
               break;
            case "RWRQM_CHANGE_TO_VISITOR_QUEUE":
               _container.roomSession.changeQueue(2);
               break;
            case "RWRQM_CLUB_LINK":
               if(_container.catalog != null)
               {
                  _container.catalog.openClubCenter();
               }
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSQE_QUEUE_STATUS"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc5_:RoomSessionQueueEvent = null;
         var _loc8_:String = null;
         var _loc2_:* = false;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:RoomWidgetRoomQueueUpdateEvent = null;
         if(_container == null || _container.events == null)
         {
            return;
         }
         var _loc9_:* = param1.type;
         if("RSQE_QUEUE_STATUS" === _loc9_)
         {
            _loc5_ = param1 as RoomSessionQueueEvent;
            if(_loc5_ == null)
            {
               return;
            }
            switch(_loc5_.queueSetTarget - 1)
            {
               case 0:
                  _loc8_ = "RWRQUE_SPECTATOR_QUEUE_STATUS";
                  break;
               case 1:
                  _loc8_ = "RWRQUE_VISITOR_QUEUE_STATUS";
            }
            if(_loc8_ == null)
            {
               return;
            }
            _loc2_ = true;
            if(_container.inventory != null)
            {
               _loc2_ = _container.inventory.clubDays > 0;
            }
            _loc6_ = _loc5_.queueTypes;
            _loc3_ = false;
            if(_loc6_.length > 1)
            {
               while(true)
               {
                  if(_loc2_ && _loc5_.queueTypes.indexOf("c") != -1)
                  {
                     _loc7_ = _loc5_.getQueueSize("c") + 1;
                     _loc3_ = true;
                  }
                  else
                  {
                     _loc7_ = _loc5_.getQueueSize("d") + 1;
                  }
               }
               §§goto(addr012f);
            }
            else
            {
               _loc7_ = _loc5_.getQueueSize(_loc6_[0]) + 1;
            }
            _loc4_ = new RoomWidgetRoomQueueUpdateEvent(_loc8_,_loc7_,_loc2_,_loc5_.isActive,_loc3_);
            _container.events.dispatchEvent(_loc4_);
         }
         addr012f:
      }
      
      public function update() : void
      {
      }
   }
}

