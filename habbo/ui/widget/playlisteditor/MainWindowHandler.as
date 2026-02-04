package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IScrollbarWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_1912;
   import com.sulake.habbo.sound.class_3073;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPlayListEditorNowPlayingEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MainWindowHandler
   {
      
      private static const SHOW_BUY_MORE_MUSIC_DISK_COUNT:int = 6;
      
      private static const MY_MUSIC_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 9;
      
      private static const PLAYLIST_SHOW_SCROLLBAR_ITEM_COUNT_LIMIT:int = 5;
      
      private var var_16:PlayListEditorWidget;
      
      private var var_424:class_1912;
      
      private var var_30:class_1812;
      
      private var var_2118:class_1993;
      
      private var var_1910:class_1993;
      
      private var var_933:MusicInventoryGridView;
      
      private var var_1460:PlayListEditorItemListView;
      
      private var var_426:MusicInventoryStatusView;
      
      private var var_589:PlayListStatusView;
      
      private var var_3786:IScrollbarWindow;
      
      private var var_3428:IScrollbarWindow;
      
      public function MainWindowHandler(param1:PlayListEditorWidget, param2:class_1912)
      {
         super();
         var_16 = param1;
         var_424 = param2;
         var _loc5_:Array = ["title_mymusic","title_playlist","background_preview_playing","background_get_more_music","background_add_songs"];
         for each(var _loc4_ in _loc5_)
         {
            var _loc3_:BitmapData = var_16.getImageGalleryAssetBitmap(_loc4_);
            var_16.retrieveWidgetImage(_loc4_);
         }
         createWindow();
         var_933 = new MusicInventoryGridView(param1,getMusicInventoryGrid(),param2);
         var_1460 = new PlayListEditorItemListView(param1,getPlayListEditorItemList());
         var_426 = new MusicInventoryStatusView(param1,getMusicInventoryStatusContainer());
         var_589 = new PlayListStatusView(param1,getPlayListStatusContainer());
         refreshLoadableAsset();
      }
      
      public function get window() : class_1741
      {
         return var_30;
      }
      
      public function get musicInventoryView() : MusicInventoryGridView
      {
         return var_933;
      }
      
      public function get playListEditorView() : PlayListEditorItemListView
      {
         return var_1460;
      }
      
      public function destroy() : void
      {
         if(var_424)
         {
            var_424.stop(2);
            var_424 = null;
         }
         if(var_933)
         {
            var_933.destroy();
            var_933 = null;
         }
         if(var_1460)
         {
            var_1460.destroy();
            var_1460 = null;
         }
         if(var_589)
         {
            var_589.destroy();
            var_589 = null;
         }
         if(var_426)
         {
            var_426.destroy();
            var_426 = null;
         }
         var_30.destroy();
         var_30 = null;
      }
      
      public function hide() : void
      {
         var_30.visible = false;
         if(var_16 != null)
         {
            var_16.stopUserSong();
         }
      }
      
      public function show() : void
      {
         var_424.requestUserSongDisks();
         var _loc1_:class_3073 = var_424.getRoomItemPlaylist();
         if(_loc1_ != null)
         {
            _loc1_.requestPlayList();
            selectPlayListStatusViewByFurniPlayListState();
         }
         var_30.visible = true;
      }
      
      public function refreshLoadableAsset(param1:String = "") : void
      {
         if(param1 == "" || param1 == "title_mymusic")
         {
            assignWindowBitmapByAsset(var_2118,"music_inventory_splash_image","title_mymusic");
         }
         if(param1 == "" || param1 == "title_playlist")
         {
            assignWindowBitmapByAsset(var_1910,"playlist_editor_splash_image","title_playlist");
         }
         if(param1 == "" || param1 == "background_preview_playing")
         {
            var_426.setPreviewPlayingBackgroundImage(var_16.getImageGalleryAssetBitmap("background_preview_playing"));
         }
         if(param1 == "" || param1 == "background_get_more_music")
         {
            var_426.setGetMoreMusicBackgroundImage(var_16.getImageGalleryAssetBitmap("background_get_more_music"));
         }
         if(param1 == "" || param1 == "background_add_songs")
         {
            var_589.addSongsBackgroundImage = var_16.getImageGalleryAssetBitmap("background_add_songs");
         }
      }
      
      private function assignWindowBitmapByAsset(param1:class_1812, param2:String, param3:String) : void
      {
         var _loc5_:class_2251 = param1.getChildByName(param2) as class_2251;
         if(_loc5_ != null)
         {
            var _loc4_:BitmapData = var_16.getImageGalleryAssetBitmap(param3);
            if(_loc4_ != null)
            {
               _loc5_.bitmap = null;
               _loc5_.width = null.width;
               _loc5_.height = null.height;
            }
         }
      }
      
      private function createWindow() : void
      {
         if(var_16 == null)
         {
            return;
         }
         var _loc2_:XmlAsset = var_16.assets.getAssetByName("playlisteditor_main_window") as XmlAsset;
         var_30 = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(var_30 == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_30.position = new Point(80,0);
         var _loc3_:class_1812 = var_30.getChildByName("content_area") as class_1812;
         if(_loc3_ == null)
         {
            throw new Error("Window is missing \'content_area\' element");
         }
         var_2118 = _loc3_.getChildByName("my_music_border") as class_1993;
         var_1910 = _loc3_.getChildByName("playlist_border") as class_1993;
         if(var_2118 == null)
         {
            throw new Error("Window content area is missing \'my_music_border\' window element");
         }
         if(var_1910 == null)
         {
            throw new Error("Window content area is missing \'playlist_border\' window element");
         }
         var_3786 = var_2118.getChildByName("music_inventory_scrollbar") as IScrollbarWindow;
         var_3428 = var_1910.getChildByName("playlist_scrollbar") as IScrollbarWindow;
         if(var_3786 == null)
         {
            throw new Error("Window content area is missing \'music_inventory_scrollbar\' window element");
         }
         if(var_3428 == null)
         {
            throw new Error("Window content area is missing \'playlist_scrollbar\' window element");
         }
         var _loc1_:class_1741 = var_30.findChildByTag("close");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onClose);
         }
      }
      
      private function getMusicInventoryGrid() : IItemGridWindow
      {
         return var_2118.getChildByName("music_inventory_itemgrid") as IItemGridWindow;
      }
      
      private function getPlayListEditorItemList() : IItemListWindow
      {
         return var_1910.getChildByName("playlist_editor_itemlist") as IItemListWindow;
      }
      
      private function getMusicInventoryStatusContainer() : class_1812
      {
         return var_2118.getChildByName("preview_play_container") as class_1812;
      }
      
      private function getPlayListStatusContainer() : class_1812
      {
         return var_1910.getChildByName("now_playing_container") as class_1812;
      }
      
      private function selectPlayListStatusViewByFurniPlayListState() : void
      {
         var _loc1_:class_3073 = var_424.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         if(_loc1_.isPlaying)
         {
            var_589.selectView("PLSV_NOW_PLAYING");
         }
         else if(_loc1_.length > 0)
         {
            var_589.selectView("PLSV_START_PLAYBACK");
         }
         else
         {
            var_589.selectView("PLSV_ADD_SONGS");
         }
      }
      
      private function selectMusicStatusViewByMusicState() : void
      {
         if(isPreviewPlaying())
         {
            var_426.show();
            var_426.selectView("MISV_PREVIEW_PLAYING");
         }
         else if(var_424.getSongDiskInventorySize() <= 6)
         {
            var_426.show();
            var_426.selectView("MISV_BUY_MORE");
         }
         else
         {
            var_426.hide();
         }
      }
      
      private function updatePlaylistEditorView() : void
      {
         var _loc4_:int = 0;
         var _loc5_:ISongInfo = null;
         var _loc2_:class_3073 = var_424.getRoomItemPlaylist();
         var _loc3_:Array = [];
         var _loc1_:int = -1;
         if(_loc2_ != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc5_ = _loc2_.getEntry(_loc4_);
               if(_loc5_ != null)
               {
                  _loc3_.push(_loc5_);
               }
               _loc4_++;
            }
            _loc1_ = _loc2_.playPosition;
         }
         var_1460.refresh(_loc3_,_loc1_);
      }
      
      public function onPlayListUpdated() : void
      {
         updatePlaylistEditorView();
         selectPlayListStatusViewByFurniPlayListState();
         var _loc1_:class_3073 = var_424.getRoomItemPlaylist();
         if(_loc1_ == null)
         {
            return;
         }
         var _loc2_:int = _loc1_.nowPlayingSongId;
         if(_loc2_ != -1)
         {
            var _loc3_:ISongInfo = var_424.getSongInfo(_loc2_);
            var_589.nowPlayingTrackName = null.name;
            var_589.nowPlayingAuthorName = null.creator;
         }
         var_3428.visible = _loc1_.length > 5;
      }
      
      public function onSongDiskInventoryReceived() : void
      {
         var_933.refresh();
         selectMusicStatusViewByMusicState();
         var_3786.visible = var_933.itemCount > 9;
      }
      
      public function onNowPlayingChanged(param1:RoomWidgetPlayListEditorNowPlayingEvent) : void
      {
         switch(param1.type)
         {
            case "RWPLENPE_SONG_CHANGED":
               selectPlayListStatusViewByFurniPlayListState();
               var_1460.setItemIndexPlaying(param1.position);
               if(param1.id != -1)
               {
                  var _loc3_:ISongInfo = var_424.getSongInfo(param1.id);
                  var_589.nowPlayingTrackName = "";
                  var_589.nowPlayingAuthorName = "";
               }
               break;
            case "RWPLENPE_USER_PLAY_SONG":
               var_933.setPreviewIconToPause();
               var _loc2_:ISongInfo = var_424.getSongInfo(param1.id);
               var_426.songName = "";
               var_426.songName = "";
               var_426.authorName = "";
               selectMusicStatusViewByMusicState();
               break;
            case "RWPLENPW_USER_STOP_SONG":
               var_933.setPreviewIconToPlay();
               selectMusicStatusViewByMusicState();
         }
      }
      
      private function onClose(param1:WindowMouseEvent) : void
      {
         hide();
      }
      
      private function isPreviewPlaying() : Boolean
      {
         return var_424.getSongIdPlayingAtPriority(2) != -1;
      }
   }
}

