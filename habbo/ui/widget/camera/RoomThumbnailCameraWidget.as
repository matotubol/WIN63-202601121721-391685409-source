package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.runtime.class_17;
   import com.sulake.core.runtime.class_31;
   import com.sulake.core.runtime.events.ILinkEventTracker;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.communication.messages.outgoing.camera.class_2077;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.RoomThumbnailCameraWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RoomThumbnailCameraWidget extends RoomWidgetBase implements class_31, ILinkEventTracker
   {
      
      private var var_59:RoomUI;
      
      private var _window:class_2250 = null;
      
      private var var_239:class_2251;
      
      public function RoomThumbnailCameraWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_16, param5:class_27, param6:RoomUI)
      {
         super(param1,param2,param3,param5);
         var_59 = param6;
         this.handler.widget = this;
         if(roomEngine)
         {
            roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
            roomEngine.events.addEventListener("REE_ROOM_ZOOMED",onRoomZoomed);
         }
         (param2 as class_17).context.addLinkEventTracker(this);
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         (windowManager as class_17).context.removeLinkEventTracker(this);
         super.dispose();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return handler ? handler.container : null;
      }
      
      public function get handler() : RoomThumbnailCameraWidgetHandler
      {
         return var_41 as RoomThumbnailCameraWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return container ? container.roomEngine : null;
      }
      
      public function update(param1:uint) : void
      {
         var _loc2_:Point = null;
         var _loc3_:Matrix = null;
         var _loc4_:IRoomSession = null;
         if(_window && var_239)
         {
            if(var_239.bitmap == null)
            {
               var_239.bitmap = new BitmapData(var_239.width,var_239.height,false,0);
            }
            var_239.bitmap.fillRect(var_239.bitmap.rect,handler.roomDesktop.roomBackgroundColor);
            _loc2_ = new Point(0,0);
            var_239.getGlobalPosition(_loc2_);
            _loc3_ = new Matrix();
            _loc3_.translate(-_loc2_.x,-_loc2_.y);
            _loc4_ = container.roomSession;
            roomEngine.snapshotRoomCanvasToBitmap(_loc4_.roomId,container.getFirstCanvasId(),var_239.bitmap,_loc3_,false);
            var_239.invalidate();
         }
      }
      
      public function startTakingPhoto() : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            windowManager.alert("Camera only works on normal zoom!","Return to normal zoom level and try again!",0,null);
            return;
         }
         if(!_window)
         {
            createWindow();
         }
      }
      
      private function createWindow() : void
      {
         if(_window)
         {
            destroy();
         }
         _window = class_2250(windowManager.buildFromXML(XML(var_59.assets.getAssetByName("iro_room_thumbnail_camera_xml").content)));
         var_239 = class_2251(_window.findChildByName("viewfinder"));
         _window.procedure = windowProcedure;
         _window.center();
         var_59.registerUpdateReceiver(this,10);
      }
      
      public function destroy() : void
      {
         if(_window)
         {
            _window.destroy();
            _window = null;
            var_59.removeUpdateReceiver(this);
         }
      }
      
      public function get viewPort() : Rectangle
      {
         var _loc1_:Point = new Point(0,0);
         var_239.getGlobalPosition(_loc1_);
         return new Rectangle(_loc1_.x,_loc1_.y,var_239.width,var_239.height);
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         destroy();
      }
      
      private function onRoomZoomed(param1:RoomEngineEvent) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            destroy();
         }
      }
      
      public function triggerCameraShutterSound() : void
      {
         container.soundManager.playSound("CAMERA_shutter");
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:class_2077 = null;
         var _loc4_:WindowMouseEvent = param1 as WindowMouseEvent;
         if(_loc4_ && _loc4_.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "button_capture":
                  triggerCameraShutterSound();
                  _loc3_ = RoomThumbnailCameraWidgetHandler(handler).collectPhotoData();
                  if(_loc3_ != null && _loc3_.isSendable())
                  {
                     handler.sendPhotoData(_loc3_);
                     _window.findChildByName("button_capture").disable();
                     _window.findChildByName("button_cancel").disable();
                     var_59.removeUpdateReceiver(this);
                  }
                  else
                  {
                     windowManager.alert("${generic.alert.title}","${camera.alert.too_much_stuff}",0,null);
                  }
                  return;
               case "header_button_close":
               case "button_cancel":
                  destroy();
            }
         }
      }
      
      public function get linkPattern() : String
      {
         return "roomThumbnailCamera";
      }
      
      public function linkReceived(param1:String) : void
      {
         var _loc2_:Array = param1.split("/");
         var _loc3_:int = int(_loc2_.length);
         if(_loc3_ < 2)
         {
            return;
         }
         if(_loc2_[1] == "open")
         {
            startTakingPhoto();
         }
      }
   }
}

