package com.sulake.habbo.ui.handler
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_2076;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_3385;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_3473;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_3501;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_3596;
   import com.sulake.habbo.toolbar.events.HabboToolbarEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.widget.camera.CameraWidget;
   import com.sulake.habbo.ui.widget.events.RoomWidgetUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetMessage;
   import flash.events.Event;
   import package_147.class_2609;
   import package_147.class_2801;
   import package_147.class_2876;
   import package_147.class_2987;
   import package_147.class_3640;
   
   public class CameraWidgetHandler implements IRoomWidgetHandler, class_13
   {
      
      private var _disposed:Boolean = false;
      
      private var _container:IRoomWidgetHandlerContainer = null;
      
      private var var_16:CameraWidget;
      
      private var var_3093:class_2609;
      
      private var var_3044:class_3640;
      
      private var var_3301:class_2801;
      
      private var var_3042:class_2876;
      
      private var var_3096:class_2987;
      
      private var var_1099:RoomDesktop;
      
      private var var_3230:int = 999;
      
      private var var_3273:int = 999;
      
      private var var_3114:int = 999;
      
      public function CameraWidgetHandler(param1:RoomDesktop)
      {
         super();
         var_1099 = param1;
         var_3093 = new class_2609(onCameraStorageUrlEvent);
         var_3044 = new class_3640(onPurchaseOK);
         var_3301 = new class_2801(onPublishStatus);
         var_3042 = new class_2876(onCompetitionStatus);
         var_3096 = new class_2987(onInitCameraEvent);
      }
      
      public function get creditPrice() : int
      {
         return var_3230;
      }
      
      public function get ducketPrice() : int
      {
         return var_3273;
      }
      
      public function get publishDucketPrice() : int
      {
         return var_3114;
      }
      
      public function get type() : String
      {
         return "RWE_CAMERA";
      }
      
      public function get roomDesktop() : RoomDesktop
      {
         return var_1099;
      }
      
      public function set roomDesktop(param1:RoomDesktop) : void
      {
         var_1099 = param1;
      }
      
      public function set container(param1:IRoomWidgetHandlerContainer) : void
      {
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.removeEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         if(_container && _container.connection)
         {
            _container.connection.removeMessageEvent(var_3093);
            _container.connection.removeMessageEvent(var_3044);
            _container.connection.removeMessageEvent(var_3301);
            _container.connection.removeMessageEvent(var_3042);
            _container.connection.removeMessageEvent(var_3096);
         }
         _container = param1;
         if(_container && _container.toolbar)
         {
            _container.toolbar.events.addEventListener("HTE_ICON_CAMERA",onCameraRequested);
         }
         if(_container)
         {
            _container.connection.addMessageEvent(var_3093);
            _container.connection.addMessageEvent(var_3044);
            _container.connection.addMessageEvent(var_3301);
            _container.connection.addMessageEvent(var_3042);
            _container.connection.addMessageEvent(var_3096);
         }
      }
      
      public function sendInitCameraMessage() : void
      {
         if(_container.sessionDataManager.isPerkAllowed("CAMERA"))
         {
            _container.connection.send(new class_3385());
         }
      }
      
      private function onInitCameraEvent(param1:class_2987) : void
      {
         var_3230 = param1.getParser().getCreditPrice();
         var_3273 = param1.getParser().getDucketPrice();
         var_3114 = param1.getParser().getPublishDucketPrice();
      }
      
      private function onPurchaseOK(param1:class_3640) : void
      {
         if(var_16)
         {
            var_16.purchaseSuccessful();
         }
      }
      
      private function onPublishStatus(param1:class_2801) : void
      {
         if(var_16)
         {
            var_16.publishingStatus(param1);
         }
      }
      
      private function onCompetitionStatus(param1:class_2876) : void
      {
         if(var_16)
         {
            var_16.competitionStatus(param1);
         }
      }
      
      private function onCameraStorageUrlEvent(param1:class_2609) : void
      {
         if(!var_16)
         {
            return;
         }
         var _loc2_:String = param1.getParser().url;
         var_16.setRenderedPhotoUrl(_loc2_);
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return _container;
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
         return [];
      }
      
      public function processEvent(param1:Event) : void
      {
      }
      
      public function update() : void
      {
      }
      
      public function dispose() : void
      {
         if(_container && container.connection)
         {
            _container.connection.removeMessageEvent(var_3093);
            _container.connection.removeMessageEvent(var_3044);
            _container.connection.removeMessageEvent(var_3301);
            _container.connection.removeMessageEvent(var_3042);
            _container.connection.removeMessageEvent(var_3096);
         }
         _disposed = true;
         _container = null;
         var_1099 = null;
         var_16 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function set widget(param1:CameraWidget) : void
      {
         var_16 = param1;
      }
      
      private function onCameraRequested(param1:HabboToolbarEvent) : void
      {
         if(param1.type == "HTE_ICON_CAMERA")
         {
            if(var_16)
            {
               var_16.startTakingPhoto(param1.iconName);
            }
         }
      }
      
      public function confirmPhotoPurchase() : void
      {
         _container.connection.send(new class_3501());
      }
      
      public function confirmPhotoPublish() : void
      {
         _container.connection.send(new class_3596());
      }
      
      public function confirmPhotoCompetitionSubmit() : void
      {
         _container.connection.send(new class_3473());
      }
      
      public function collectPhotoData() : class_2076
      {
         if(var_1099 == null)
         {
            return null;
         }
         return var_1099.roomEngine.getRenderRoomMessage(var_16.getViewPort(),var_1099.roomBackgroundColor) as class_2076;
      }
      
      public function sendPhotoData(param1:class_2076) : void
      {
         _container.connection.send(param1);
      }
   }
}

