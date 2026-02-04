package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   
   public class PlayListStatusView
   {
      
      public static const ADD_SONGS:String = "PLSV_ADD_SONGS";
      
      public static const START_PLAYBACK:String = "PLSV_START_PLAYBACK";
      
      public static const NOW_PLAYING:String = "PLSV_NOW_PLAYING";
      
      private var _container:class_1812;
      
      private var var_860:class_55 = new class_55();
      
      private var var_16:PlayListEditorWidget;
      
      private var var_78:String;
      
      public function PlayListStatusView(param1:PlayListEditorWidget, param2:class_1812)
      {
         super();
         _container = param2;
         var_16 = param1;
         createWindows();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in var_860.getValues())
         {
            _loc1_.destroy();
         }
         var_860 = null;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(var_860[param1] as class_1812,0);
         var_78 = param1;
      }
      
      public function set nowPlayingTrackName(param1:String) : void
      {
         if(var_78 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:class_1812 = var_860[var_78];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_track_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set nowPlayingAuthorName(param1:String) : void
      {
         if(var_78 != "PLSV_NOW_PLAYING")
         {
            return;
         }
         var _loc2_:class_1812 = var_860[var_78];
         var _loc3_:ITextWindow = _loc2_.getChildByName("now_playing_author_name") as ITextWindow;
         if(_loc3_ != null)
         {
            _loc3_.text = param1;
         }
      }
      
      public function set addSongsBackgroundImage(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1812 = var_860["PLSV_ADD_SONGS"];
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:class_2251 = _loc2_.getChildByName("background_image") as class_2251;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.bitmap = param1.clone();
         _loc3_.width = param1.width;
         _loc3_.height = param1.height;
      }
      
      private function createWindows() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:XmlAsset = null;
         _loc2_ = var_16.assets.getAssetByName("playlisteditor_playlist_subwindow_add_songs") as XmlAsset;
         _loc3_ = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc3_ != null)
         {
            var_860.add("PLSV_ADD_SONGS",_loc3_);
         }
         _loc2_ = var_16.assets.getAssetByName("playlisteditor_playlist_subwindow_play_now") as XmlAsset;
         _loc3_ = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc3_ != null)
         {
            var_860.add("PLSV_START_PLAYBACK",_loc3_);
            var _loc4_:class_1775 = _loc3_.getChildByName("play_now_button") as class_1775;
            _loc4_.addEventListener("WME_CLICK",onPlayPauseClicked);
         }
         _loc2_ = var_16.assets.getAssetByName("playlisteditor_playlist_subwindow_nowplaying") as XmlAsset;
         _loc3_ = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc3_ != null)
         {
            var_860.add("PLSV_NOW_PLAYING",_loc3_);
            var _loc1_:class_2143 = _loc3_.getChildByName("button_pause") as class_2143;
            null.addEventListener("WME_CLICK",onPlayPauseClicked);
            assignAssetToElement("icon_pause_large",null.getChildByName("pause_image") as class_2251);
            assignAssetToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as class_2251);
            assignAssetToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as class_2251);
         }
      }
      
      private function assignAssetToElement(param1:String, param2:class_2251) : void
      {
         var _loc3_:BitmapData = null;
         var _loc4_:BitmapDataAsset = var_16.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc4_ != null)
         {
            if(param2 != null && _loc4_.content != null)
            {
               _loc3_ = _loc4_.content as BitmapData;
               param2.bitmap = _loc3_.clone();
            }
         }
      }
      
      private function onPlayPauseClicked(param1:WindowMouseEvent) : void
      {
         var_16.sendTogglePlayPauseStateMessage();
      }
   }
}

