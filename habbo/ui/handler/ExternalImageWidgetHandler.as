package com.sulake.habbo.ui.handler
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.habbo.room.events.RoomEngineToWidgetEvent;
   import com.sulake.habbo.room.events.RoomEngineUseProductEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.furniture.externalimage.ExternalImageWidget;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import com.sulake.room.object.IRoomObject;
   import flash.events.Event;
   
   public class ExternalImageWidgetHandler implements IRoomWidgetHandler
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer;
      
      private var var_16:ExternalImageWidget;
      
      public function ExternalImageWidgetHandler()
      {
         super();
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function set widget(param1:ExternalImageWidget) : void
      {
         var_16 = param1;
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
         return ["ROSM_USE_PRODUCT_FROM_INVENTORY"];
      }
      
      public function processEvent(param1:Event) : void
      {
         var _loc2_:RoomEngineUseProductEvent = null;
         if(_container.roomEngine == null)
         {
            return;
         }
         if(param1 is RoomEngineUseProductEvent)
         {
            _loc2_ = param1 as RoomEngineUseProductEvent;
            if(_loc2_.type == "ROSM_USE_PRODUCT_FROM_INVENTORY")
            {
               var_16.showWithFurniID(_loc2_.objectId);
            }
         }
         var _loc4_:RoomEngineToWidgetEvent = param1 as RoomEngineToWidgetEvent;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:IRoomObject = _container.roomEngine.getRoomObject(_loc4_.roomId,_loc4_.objectId,_loc4_.category);
         switch(param1.type)
         {
            case "RETWE_OPEN_WIDGET":
               if(_loc3_ != null)
               {
                  var_16.showWithRoomObject(_loc3_);
               }
               break;
            case "RETWE_CLOSE_WIDGET":
               var_16.hide();
         }
      }
      
      public function deleteCard(param1:int) : void
      {
         if(_container != null && _container.roomEngine != null)
         {
            _container.roomEngine.deleteRoomObject(param1,20);
         }
      }
      
      public function isRoomOwner() : Boolean
      {
         return _container.roomSession.isRoomOwner;
      }
      
      public function hasRightsToRemove() : Boolean
      {
         return _container.roomSession.roomControllerLevel >= 4;
      }
      
      public function sendMessage(param1:IMessageComposer) : void
      {
         _container.connection.send(param1);
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         _container = null;
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get type() : String
      {
         return "RWE_EXTERNAL_IMAGE";
      }
      
      public function get storiesImageUrlBase() : String
      {
         return _container.config.getProperty("stories.image_url_base");
      }
      
      public function get storiesImageShareUrl() : String
      {
         return _container.config.getProperty("stories.image.sharing_url_base");
      }
      
      public function get extraDataServiceUrl() : String
      {
         return _container.config.getProperty("extra_data_service_url");
      }
      
      public function isSelfieReportingEnabled() : Boolean
      {
         return _container.config.getProperty("stories.report.selfie.enabled") == "true";
      }
   }
}

