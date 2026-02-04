package com.sulake.habbo.ui.widget.playlisteditor
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class MusicInventoryStatusView
   {
      
      public static const BUY_MORE:String = "MISV_BUY_MORE";
      
      public static const PREVIEW_PLAYING:String = "MISV_PREVIEW_PLAYING";
      
      private var _container:class_1812;
      
      private var var_860:class_55 = new class_55();
      
      private var var_16:PlayListEditorWidget;
      
      private var var_78:String;
      
      private var var_3810:ITextWindow;
      
      private var var_3569:ITextWindow;
      
      public function MusicInventoryStatusView(param1:PlayListEditorWidget, param2:class_1812)
      {
         super();
         _container = param2;
         var_16 = param1;
         createWindows();
         hide();
      }
      
      public function destroy() : void
      {
         for each(var _loc1_ in var_860.getValues())
         {
            _loc1_.destroy();
         }
         var_860 = null;
      }
      
      public function show() : void
      {
         _container.visible = true;
      }
      
      public function hide() : void
      {
         _container.visible = false;
      }
      
      public function selectView(param1:String) : void
      {
         _container.removeChildAt(0);
         _container.addChildAt(var_860[param1] as class_1812,0);
         var_78 = param1;
      }
      
      public function set songName(param1:String) : void
      {
         if(var_3810 == null)
         {
            return;
         }
         var_3810.text = param1;
      }
      
      public function set authorName(param1:String) : void
      {
         if(var_3569 == null)
         {
            return;
         }
         var_3569.text = param1;
      }
      
      public function setPreviewPlayingBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_PREVIEW_PLAYING","preview_play_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      public function setGetMoreMusicBackgroundImage(param1:BitmapData, param2:Boolean = true) : void
      {
         blitBackgroundImage("MISV_BUY_MORE","get_more_music_background_image",param1);
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      private function createWindows() : void
      {
         var _loc3_:class_1812 = null;
         var _loc2_:XmlAsset = null;
         _loc2_ = var_16.assets.getAssetByName("playlisteditor_inventory_subwindow_play_preview") as XmlAsset;
         _loc3_ = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc3_ != null)
         {
            var_860.add("MISV_PREVIEW_PLAYING",_loc3_);
            var_3810 = _loc3_.getChildByName("preview_play_track_name") as ITextWindow;
            var_3569 = _loc3_.getChildByName("preview_play_author_name") as ITextWindow;
            var _loc1_:class_1775 = _loc3_.getChildByName("stop_preview_button") as class_1775;
            null.addEventListener("WME_CLICK",onStopPreviewClicked);
            setPreviewPlayingBackgroundImage(var_16.getImageGalleryAssetBitmap("background_preview_playing"));
            assignAssetByNameToElement("jb_icon_disc",_loc3_.getChildByName("song_name_icon_bitmap") as class_2251);
            assignAssetByNameToElement("jb_icon_composer",_loc3_.getChildByName("author_name_icon_bitmap") as class_2251);
         }
         _loc2_ = var_16.assets.getAssetByName("playlisteditor_inventory_subwindow_get_more_music") as XmlAsset;
         _loc3_ = var_16.windowManager.buildFromXML(_loc2_.content as XML) as class_1812;
         if(_loc3_ != null)
         {
            var_860.add("MISV_BUY_MORE",_loc3_);
            var _loc4_:class_1775 = _loc3_.getChildByName("open_catalog_button") as class_1775;
            _loc4_.addEventListener("WME_CLICK",onOpenCatalogButtonClicked);
            setGetMoreMusicBackgroundImage(var_16.getImageGalleryAssetBitmap("background_get_more_music"));
         }
      }
      
      private function blitBackgroundImage(param1:String, param2:String, param3:BitmapData) : void
      {
         var _loc6_:class_1812 = var_860[param1] as class_1812;
         if(_loc6_ == null)
         {
            return;
         }
         var _loc4_:class_2251 = _loc6_.getChildByName(param2) as class_2251;
         if(_loc4_ == null)
         {
            return;
         }
         if(param3 != null)
         {
            var _loc5_:BitmapData = new BitmapData(_loc4_.width,_loc4_.height,false,4294967295);
            _loc5_.copyPixels(param3,param3.rect,new Point(0,0));
            _loc4_.bitmap = null;
         }
      }
      
      private function assignAssetByNameToElement(param1:String, param2:class_2251) : void
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
      
      private function onOpenCatalogButtonClicked(param1:WindowMouseEvent) : void
      {
         var_16.openSongDiskShopCataloguePage();
      }
      
      private function onStopPreviewClicked(param1:WindowMouseEvent) : void
      {
         var_16.stopUserSong();
      }
   }
}

