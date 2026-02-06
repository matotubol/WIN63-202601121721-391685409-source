package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomThumbnailMessageComposer;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.camera.RoomThumbnailCameraWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import com.sulake.habbo.communication.messages.incoming.camera.ThumbnailStatusMessageEvent;
   
   public class RoomThumbnailCameraWidgetHandler implements IRoomWidgetHandler, class_13
   {
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_1099:RoomDesktop;
      
      private var var_16:RoomThumbnailCameraWidget;
      
      private var var_3293:ThumbnailStatusMessageEvent;
      
      public function RoomThumbnailCameraWidgetHandler(param1:RoomDesktop)
      {
         super();
         var_1099 = param1;
      }
      
      public function get roomDesktop() : RoomDesktop
      {
         return var_1099;
      }
      
      public function getProcessedEvents() : Array
      {
         return [];
      }
      
      public function getWidgetMessages() : Array
      {
         return null;
      }
      
      public function processWidgetMessage(param1:RoomWidgetMessage) : RoomWidgetUpdateEvent
      {
         return null;
      }
      
      public function set widget(param1:RoomThumbnailCameraWidget) : void
      {
         var_16 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         _container = param1;
         var_3293 = new ThumbnailStatusMessageEvent(onThumbnailStatus);
         _container.connection.addMessageEvent(var_3293);
      }
      
      public function dispose() : void
      {
         if(_container && _container.connection && var_3293)
         {
            _container.connection.removeMessageEvent(var_3293);
         }
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function get type() : String
      {
         return "RWE_ROOM_THUMBNAIL_CAMERA";
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
      }
      
      public function collectPhotoData() : RenderRoomThumbnailMessageComposer
      {
         return RenderRoomThumbnailMessageComposer(var_1099.roomEngine.getRenderRoomMessage(var_16.viewPort,var_1099.roomBackgroundColor,true));
      }
      
      public function sendPhotoData(param1:RenderRoomThumbnailMessageComposer) : void
      {
         _container.connection.send(param1);
      }
      
      private function onThumbnailStatus(param1:ThumbnailStatusMessageEvent) : void
      {
         var_16.destroy();
         if(param1.getParser().isOk())
         {
            _container.windowManager.alert("${navigator.thumbnail.camera.title}","${navigator.thumbnail.camera.success}",16,null);
         }
         else if(param1.getParser().isRenderLimitHit())
         {
            _container.windowManager.alert("${generic.alert.title}","${camera.render.count.info}",0,null);
         }
      }
   }
}

