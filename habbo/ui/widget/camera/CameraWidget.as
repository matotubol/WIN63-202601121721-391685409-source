package com.sulake.habbo.ui.widget.camera
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.utils.ErrorReportStorage;
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.communication.messages.outgoing.camera.RenderRoomMessageComposer;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.quest.class_498;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.habbo.session.IRoomSession;
   import com.sulake.habbo.ui.IRoomDesktop;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.IRoomWidgetHandlerContainer;
   import com.sulake.habbo.ui.RoomDesktop;
   import com.sulake.habbo.ui.RoomUI;
   import com.sulake.habbo.ui.handler.CameraWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import com.sulake.habbo.communication.messages.incoming.camera.CameraPublishStatusMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.camera.CompetitionStatusMessageEvent;
   
   public class CameraWidget extends RoomWidgetBase
   {
      
      private var var_59:RoomUI;
      
      private var var_825:CameraViewFinder;
      
      private var var_161:CameraPhotoLab;
      
      public var url:String;
      
      public function CameraWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_16, param5:class_27, param6:RoomUI)
      {
         super(param1,param2,param3,param5);
         var_59 = param6;
         this.handler.widget = this;
         var_825 = new CameraViewFinder(this);
         if(roomEngine)
         {
            roomEngine.events.addEventListener("REE_DISPOSED",onRoomDisposed);
            roomEngine.events.addEventListener("REE_ROOM_ZOOMED",onRoomZoomed);
         }
         this.handler.sendInitCameraMessage();
         var _loc7_:class_498 = this.handler.roomDesktop.questEngine;
         if(_loc7_ != null)
         {
            _loc7_.ensureAchievementsInitialized();
         }
      }
      
      public function get catalog() : IHabboCatalog
      {
         return var_59.catalog;
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         if(var_825)
         {
            var_825.dispose();
            var_825 = null;
         }
         if(var_161)
         {
            var_161.dispose();
            var_161 = null;
         }
         super.dispose();
      }
      
      public function get container() : IRoomWidgetHandlerContainer
      {
         return handler ? handler.container : null;
      }
      
      public function get handler() : CameraWidgetHandler
      {
         return var_41 as CameraWidgetHandler;
      }
      
      public function get roomEngine() : IRoomEngine
      {
         return container ? container.roomEngine : null;
      }
      
      public function startTakingPhoto(param1:String) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            windowManager.alert(var_167.getLocalization("camera.zoom.missing.header"),var_167.getLocalization("camera.zoom.missing.body"),0,null);
            return;
         }
         if(component.getProperty("camera.effects.enabled") == "true")
         {
            CameraPhotoLab.preloadEffects(var_59.context.configuration.getProperty("image.library.url"),var_59.getProperty("camera.available.effects"),var_167);
         }
         if(var_161)
         {
            var_161.dispose();
         }
         var_825.toggleVisible(param1);
      }
      
      public function get component() : RoomUI
      {
         return var_59;
      }
      
      public function getXmlWindow(param1:String, param2:uint = 1) : class_1741
      {
         var _loc5_:IAsset = null;
         var _loc3_:XmlAsset = null;
         var _loc4_:class_1741 = null;
         try
         {
            _loc5_ = assets.getAssetByName(param1 + "_xml");
            _loc3_ = XmlAsset(_loc5_);
            _loc4_ = windowManager.buildFromXML(XML(_loc3_.content),param2);
         }
         catch(e:Error)
         {
            ErrorReportStorage.addDebugData("HabboNavigator","Failed to build window " + param1 + "_xml, " + _loc5_ + ", " + windowManager + "!");
            throw e;
         }
         return _loc4_;
      }
      
      private function onRoomDisposed(param1:RoomEngineEvent) : void
      {
         hide();
      }
      
      private function onRoomZoomed(param1:RoomEngineEvent) : void
      {
         if(roomEngine && roomEngine.getRoomCanvasScale() != 1)
         {
            hide();
         }
      }
      
      private function hide() : void
      {
         if(var_825)
         {
            var_825.hide();
         }
         if(var_161)
         {
            var_161.dispose();
         }
      }
      
      public function snapShotRoomCanvas(param1:BitmapData, param2:Matrix, param3:Boolean) : Boolean
      {
         var _loc4_:IRoomSession = container.roomSession;
         return roomEngine.snapshotRoomCanvasToBitmap(_loc4_.roomId,container.getFirstCanvasId(),param1,param2,param3);
      }
      
      public function triggetCameraShutterSound() : void
      {
         container.soundManager.playSound("CAMERA_shutter");
      }
      
      public function editPhoto(param1:BitmapData) : void
      {
         var_161 = new CameraPhotoLab(this);
         var_161.openPhotoLab(param1);
      }
      
      public function changeCaptionFieldText(param1:String, param2:Boolean = false) : void
      {
         if(var_161)
         {
            var_161.setCaptionText(param1);
            if(param2)
            {
               var_161.show();
               var_161.closePurchaseConfirmation();
            }
         }
      }
      
      public function getViewPort() : Rectangle
      {
         if(var_825)
         {
            return var_825.getViewPort();
         }
         return new Rectangle(0,0,0,0);
      }
      
      public function purchaseSuccessful() : void
      {
         if(var_161)
         {
            var_161.animateSuccessfulPurchase();
         }
      }
      
      public function setRenderedPhotoUrl(param1:String) : void
      {
         if(var_161)
         {
            var_161.setRenderedPhotoUrl(param1);
         }
      }
      
      public function publishingStatus(param1:CameraPublishStatusMessageEvent) : void
      {
         if(var_161)
         {
            var_161.publishingStatus(param1);
         }
      }
      
      public function competitionStatus(param1:CompetitionStatusMessageEvent) : void
      {
         if(var_161)
         {
            var_161.competitionStatus(param1);
         }
      }
      
      public function sendPhotoData() : Boolean
      {
         var _loc1_:RenderRoomMessageComposer = var_825.getRenderRoomMessage();
         if(var_161)
         {
            _loc1_.addEffectData(var_161.getEffectDataJson());
            _loc1_.setZoom(var_161.getZoom());
         }
         _loc1_.compressData();
         if(_loc1_.isSendable())
         {
            handler.sendPhotoData(_loc1_);
            return true;
         }
         return false;
      }
      
      override public function release() : void
      {
         super.release();
         (var_41 as CameraWidgetHandler).roomDesktop = null;
      }
      
      override public function reuse(param1:IRoomDesktop) : void
      {
         super.reuse(param1);
         (var_41 as CameraWidgetHandler).roomDesktop = param1 as RoomDesktop;
      }
   }
}

