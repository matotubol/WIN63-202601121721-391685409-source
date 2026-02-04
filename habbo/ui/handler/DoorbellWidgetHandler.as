package com.sulake.habbo.ui.handler
{
   import com.sulake.habbo.session.events.RoomSessionDoorbellEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetDoorbellEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetLetUserInMessage;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   
   public class DoorbellWidgetHandler implements IRoomWidgetHandler
   {
      
      private var var_1134:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      public function DoorbellWidgetHandler()
      {
         super();
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      public function get type() : String
      {
         return "RWE_DOORBELL";
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
         return ["RWLUIM_LET_USER_IN"];
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         var _loc2_:RoomWidgetLetUserInMessage = null;
         var _loc3_:* = param1.type;
         if("RWLUIM_LET_USER_IN" === _loc3_)
         {
            _loc2_ = param1 as RoomWidgetLetUserInMessage;
            _container.roomSession.letUserIn(_loc2_.userName,_loc2_.canEnter);
         }
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RSDE_DOORBELL","RSDE_REJECTED","RSDE_ACCEPTED"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomSessionDoorbellEvent = null;
         switch(param1.type)
         {
            case "RSDE_DOORBELL":
               _loc2_ = param1 as RoomSessionDoorbellEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_RINGING",_loc2_.userName));
               break;
            case "RSDE_REJECTED":
               _loc2_ = param1 as RoomSessionDoorbellEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_REJECTED",_loc2_.userName));
               break;
            case "RSDE_ACCEPTED":
               _loc2_ = param1 as RoomSessionDoorbellEvent;
               if(_loc2_ == null)
               {
                  return;
               }
               _container.events.dispatchEvent(new RoomWidgetDoorbellEvent("RWDE_ACCEPTED",_loc2_.userName));
         }
      }
      
      public function update() : void
      {
      }
   }
}

