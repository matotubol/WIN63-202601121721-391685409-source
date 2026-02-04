package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_544;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import package_154.class_3194;
   import package_60.class_2394;
   
   public class SongDiskProductViewCatalogWidget extends ProductViewCatalogWidget
   {
      
      private var _soundManager:class_544;
      
      private var var_37:IConnection;
      
      private var _playPreviewContainer:class_1812;
      
      private var var_1040:class_1775;
      
      private var var_2261:class_1741;
      
      private var var_914:int = -1;
      
      private var _officialSongId:String = "";
      
      private var var_5373:String = "";
      
      private var _officialSongIdListener:IMessageEvent = null;
      
      public function SongDiskProductViewCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1,param2);
         var_1040 = _window.findChildByName("listen") as class_1775;
         var_2261 = _window.findChildByName("ctlg_song_length");
         if(var_1040 != null)
         {
            var_1040.addEventListener("WME_CLICK",onClickPlay);
            var_1040.disable();
         }
         _playPreviewContainer = _window.findChildByName("playPreviewContainer") as class_1812;
         if(_playPreviewContainer != null)
         {
            _playPreviewContainer.visible = false;
         }
         _soundManager = param2.soundManager;
         if(_soundManager != null)
         {
            _soundManager.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
         }
         var_37 = param2.connection;
         if(var_37 && !_officialSongIdListener)
         {
            _officialSongIdListener = new class_3194(onOfficialSongIdMessageEvent);
            var_37.addMessageEvent(_officialSongIdListener);
         }
      }
      
      override public function dispose() : void
      {
         if(var_1040 != null)
         {
            var_1040.removeEventListener("WME_CLICK",onClickPlay);
         }
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
            if(_soundManager.events != null)
            {
               _soundManager.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            _soundManager = null;
            if(var_37 && _officialSongIdListener)
            {
               var_37.removeMessageEvent(_officialSongIdListener);
               _officialSongIdListener = null;
            }
            var_37 = null;
         }
         super.dispose();
      }
      
      override public function closed() : void
      {
         super.closed();
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _soundManager.musicController.stop(3);
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(page.offers.length == 0)
         {
            return false;
         }
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onClickPlay(param1:WindowMouseEvent) : void
      {
         if(_soundManager != null && _soundManager.musicController != null)
         {
            forceNoFadeoutOnPlayingSong(0);
            forceNoFadeoutOnPlayingSong(3);
            _soundManager.musicController.playSong(var_914,3,15,40,0.5,2);
         }
      }
      
      private function forceNoFadeoutOnPlayingSong(param1:int) : void
      {
         var _loc3_:int = _soundManager.musicController.getSongIdPlayingAtPriority(param1);
         if(_loc3_ != -1)
         {
            var _loc2_:ISongInfo = _soundManager.musicController.getSongInfo(_loc3_);
            if(null.soundObject != null)
            {
               null.soundObject.fadeOutSeconds = 0;
            }
         }
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null || param1.offer == null)
         {
            return;
         }
         var _loc2_:class_1857 = param1.offer.product;
         if(_loc2_.extraParam.length > 0)
         {
            var_914 = parseInt(_loc2_.extraParam);
            if(var_914 == 0)
            {
               _officialSongId = _loc2_.extraParam;
               if(var_37)
               {
                  var_37.send(new class_2394(_officialSongId));
               }
            }
            if(_playPreviewContainer != null)
            {
               _playPreviewContainer.visible = true;
            }
         }
         else
         {
            var_914 = -1;
         }
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc6_:String = null;
         var _loc3_:class_27 = null;
         var _loc7_:String = null;
         var _loc2_:Boolean = false;
         var _loc5_:int = getSongLength();
         if(_loc5_ >= 0)
         {
            _loc1_ = _loc5_ / 60;
            _loc4_ = _loc5_ % 60;
            _loc8_ = "" + _loc1_;
            _loc6_ = "" + _loc4_;
            if(_loc4_ < 10)
            {
               _loc6_ = "0" + _loc6_;
            }
            _loc3_ = (page.viewer.catalog as HabboCatalog).localization;
            _loc3_.registerParameter("catalog.song.length","min",_loc8_);
            _loc7_ = _loc3_.registerParameter("catalog.song.length","sec",_loc6_);
            _loc2_ = true;
            if(var_2261 != null)
            {
               var_2261.caption = _loc7_;
            }
         }
         else if(var_2261 != null)
         {
            var_2261.caption = "";
         }
         if(var_1040 != null)
         {
            if(_loc2_)
            {
               var_1040.enable();
            }
            else
            {
               var_1040.disable();
            }
         }
      }
      
      private function getSongLength() : int
      {
         var _loc1_:ISongInfo = null;
         if(_soundManager != null && _soundManager.musicController != null)
         {
            _loc1_ = _soundManager.musicController.getSongInfo(var_914);
            if(_loc1_ != null)
            {
               return _loc1_.length / 1000;
            }
            _soundManager.musicController.requestSongInfoWithoutSamples(var_914);
         }
         return -1;
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(param1.id == var_914)
         {
            updateView();
         }
      }
      
      private function onOfficialSongIdMessageEvent(param1:class_3194) : void
      {
         if(param1.getParser().officialSongId == _officialSongId)
         {
            var_914 = param1.getParser().songId;
            updateView();
         }
      }
   }
}

