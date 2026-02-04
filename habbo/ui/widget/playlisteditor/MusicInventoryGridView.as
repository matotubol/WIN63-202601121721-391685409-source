package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.sound.ISongInfo;
   import com.sulake.habbo.sound.class_1912;
   import com.sulake.habbo.sound.events.SongInfoReceivedEvent;
   import flash.geom.ColorTransform;
   
   public class MusicInventoryGridView
   {
      
      private var var_424:class_1912;
      
      private var var_1189:IItemGridWindow;
      
      private var _items:class_55 = new class_55();
      
      private var var_16:PlayListEditorWidget;
      
      private var var_165:MusicInventoryGridItem;
      
      public function MusicInventoryGridView(param1:PlayListEditorWidget, param2:IItemGridWindow, param3:class_1912)
      {
         super();
         var_424 = param3;
         var_1189 = param2;
         var_16 = param1;
         var_165 = null;
         var_424.events.addEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
      }
      
      public function get itemCount() : int
      {
         return _items.length;
      }
      
      public function destroy() : void
      {
         if(var_1189 != null)
         {
            var_1189.destroyGridItems();
            var_1189 = null;
         }
         if(var_424 != null)
         {
            if(var_424.events != null)
            {
               var_424.events.removeEventListener("SIR_TRAX_SONG_INFO_RECEIVED",onSongInfoReceivedEvent);
            }
            var_424 = null;
         }
         if(_items)
         {
            _items.reset();
            _items = null;
         }
         var_165 = null;
         var_16 = null;
      }
      
      public function refresh() : void
      {
         if(var_1189 == null)
         {
            return;
         }
         var_1189.removeGridItems();
         var _loc8_:class_55 = _items;
         var _loc2_:class_55 = new class_55();
         var _loc5_:Array = _loc8_.getKeys();
         _items = new class_55();
         var _loc6_:int = var_424.getSongDiskInventorySize();
         var _loc4_:int = 0;
         while(0 < _loc6_)
         {
            var _loc9_:int = var_424.getSongDiskInventoryDiskId(0);
            var _loc11_:int = var_424.getSongDiskInventorySongId(0);
            var _loc12_:ISongInfo = var_424.getSongInfo(0);
            var _loc1_:String = null;
            var _loc13_:ColorTransform = null;
            if(_loc5_.indexOf(0) == -1)
            {
               var _loc3_:MusicInventoryGridItem = new MusicInventoryGridItem(var_16,0,0,null,null);
            }
            else
            {
               _loc3_ = _loc8_[0];
               _loc5_.splice(_loc5_.indexOf(0),1);
            }
            null.window.procedure = gridItemEventProc;
            null.toPlayListButton.procedure = gridItemEventProc;
            var_1189.addGridItem(null.window);
            _items.add(0,null);
            _loc4_++;
         }
         for each(var _loc10_ in _loc5_)
         {
            var _loc7_:MusicInventoryGridItem = _loc8_[_loc10_];
            _loc7_.destroy();
            _loc8_.remove(_loc10_);
         }
      }
      
      public function setPreviewIconToPause() : void
      {
         if(var_165 != null)
         {
            var_165.playButtonState = 1;
         }
      }
      
      public function setPreviewIconToPlay() : void
      {
         if(var_165 != null)
         {
            var_165.playButtonState = 0;
         }
      }
      
      public function deselectAny() : void
      {
         if(var_165 != null)
         {
            var_165.deselect();
            var_165 = null;
         }
      }
      
      private function gridItemEventProc(param1:class_1758, param2:class_1741) : void
      {
         var _loc4_:int = 0;
         var _loc5_:MusicInventoryGridItem = null;
         var _loc3_:* = param1.type == "WME_DOUBLE_CLICK";
         if(param1.type == "WME_CLICK" || _loc3_)
         {
            if(param2.name == "button_to_playlist" || _loc3_)
            {
               if(var_165 != null)
               {
                  var_165.deselect();
                  stopPreview();
                  var_16.sendAddToPlayListMessage(var_165.diskId);
                  var_165 = null;
               }
            }
            else if(param2.name == "button_play_pause")
            {
               if(var_165.playButtonState == 0)
               {
                  var_165.playButtonState = 2;
                  var_16.playUserSong(var_165.songId);
               }
               else
               {
                  stopPreview();
               }
            }
            else
            {
               _loc4_ = var_1189.getGridItemIndex(param1.window);
               if(_loc4_ != -1)
               {
                  _loc5_ = _items.getWithIndex(_loc4_);
                  if(_loc5_ != var_165)
                  {
                     if(var_165 != null)
                     {
                        var_165.deselect();
                     }
                     var_165 = _loc5_;
                     var_165.select();
                     stopPreview();
                  }
                  if(var_16.mainWindowHandler != null)
                  {
                     var_16.mainWindowHandler.playListEditorView.deselectAny();
                  }
               }
            }
         }
      }
      
      private function stopPreview() : void
      {
         var_16.stopUserSong();
         setPreviewIconToPlay();
      }
      
      private function onSongInfoReceivedEvent(param1:SongInfoReceivedEvent) : void
      {
         if(var_424 != null)
         {
            var _loc4_:ISongInfo = var_424.getSongInfo(param1.id);
            if(_loc4_ != null)
            {
               var _loc2_:String = null.name;
               var _loc5_:ColorTransform = var_16.getDiskColorTransformFromSongData(null.songData);
               var _loc3_:MusicInventoryGridItem = _items[param1.id];
            }
         }
      }
   }
}

