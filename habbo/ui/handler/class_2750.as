package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.IRoomObjectModel;
   import flash.events.Event;
   
   public class class_2750 implements IRoomWidgetHandler
   {
      
      private static const INTERNAL_LINK_KEY:String = "internalLink";
      
      private var _container:IRoomWidgetHandlerContainer;
      
      public function class_2750()
      {
         super();
      }
      
      public function get type() : String
      {
         return "RWE_INTERNAL_LINK";
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function getProcessedEvents() : Array
      {
         return ["RETWE_REQUEST_INTERNAL_LINK"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc5_:RoomEngineToWidgetEvent = null;
         var _loc2_:IRoomObject = null;
         var _loc4_:IRoomObjectModel = null;
         var _loc3_:String = null;
         var _loc6_:* = param1.type;
         if("RETWE_REQUEST_INTERNAL_LINK" === _loc6_)
         {
            _loc5_ = param1 as RoomEngineToWidgetEvent;
            if(param1 != null && _container.roomEngine != null)
            {
               _loc2_ = _container.roomEngine.getRoomObject(_loc5_.roomId,_loc5_.objectId,_loc5_.category);
               if(_loc2_ != null)
               {
                  _loc4_ = _loc2_.getModel();
                  _loc3_ = _loc4_.getStringToStringMap("furniture_data").getValue("internalLink");
                  if(_loc3_ == null || _loc3_.length == 0)
                  {
                     _loc3_ = _loc4_.getString("furniture_internal_link");
                  }
                  if(_loc3_ != null && _loc3_.length > 0)
                  {
                     (_container.roomEngine as class_17).context.createLinkEvent(_loc3_);
                  }
               }
            }
         }
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _container = null;
      }
      
      public function get disposed() : Boolean
      {
         return _container == null;
      }
   }
}

