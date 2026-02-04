package com.sulake.habbo.ui.widget.infostand
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.ui.widget.events.RoomWidgetSongUpdateEvent;
   import flash.display.BitmapData;
   
   public class InfoStandJukeboxView extends InfoStandFurniView
   {
      
      private var var_2766:int = -1;
      
      private var _songName:String = "";
      
      private var var_4431:String = "";
      
      public function InfoStandJukeboxView(param1:InfoStandWidget, param2:String, param3:IHabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function createWindow(param1:String) : void
      {
         var _loc4_:XmlAsset = var_16.assets.getAssetByName("jukebox_view") as XmlAsset;
         _window = var_16.windowManager.buildFromXML(_loc4_.content as XML) as IItemListWindow;
         if(_window == null)
         {
            throw new Error("Failed to construct window from XML!");
         }
         var_31 = _window.getListItemByName("info_border") as class_1993;
         var_34 = _window.getListItemByName("button_list") as IItemListWindow;
         if(var_31 != null)
         {
            var_108 = var_31.findChildByName("infostand_element_list") as IItemListWindow;
         }
         _window.name = param1;
         var_16.mainContainer.addChild(_window);
         var _loc3_:class_1741 = var_31.findChildByTag("close");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onClose);
         }
         if(var_34 != null)
         {
            var _loc7_:int = 0;
            while(0 < var_34.numListItems)
            {
               var _loc2_:class_1741 = var_34.getListItemAt(0);
               null.addEventListener("WME_CLICK",onButtonClicked);
               _loc7_++;
            }
         }
         var_350 = var_31.findChildByTag("catalog");
         if(var_350 != null)
         {
            var_350.addEventListener("WME_CLICK",onCatalogButtonClicked);
         }
         var_356 = var_31.findChildByName("rent_button");
         if(var_356 != null)
         {
            var_356.addEventListener("WME_CLICK",onRentButtonClicked);
         }
         var_348 = var_31.findChildByName("extend_button");
         if(var_348 != null)
         {
            var_348.addEventListener("WME_CLICK",onExtendButtonClicked);
         }
         var_344 = var_31.findChildByName("buyout_button");
         if(var_344 != null)
         {
            var_344.addEventListener("WME_CLICK",onBuyoutButtonClicked);
         }
         var _loc6_:class_2251 = var_31.findChildByName("icon_disc") as class_2251;
         if(_loc6_ != null)
         {
            var _loc10_:BitmapDataAsset = var_16.assets.getAssetByName("jb_icon_disc") as BitmapDataAsset;
            var _loc5_:BitmapData = _loc10_.content as BitmapData;
            _loc6_.bitmap = null.clone();
         }
         var _loc9_:class_2251 = var_31.findChildByName("icon_composer") as class_2251;
         if(_loc9_ != null)
         {
            _loc10_ = var_16.assets.getAssetByName("jb_icon_composer") as BitmapDataAsset;
            _loc5_ = _loc10_.content as BitmapData;
            _loc9_.bitmap = null.clone();
         }
         var _loc8_:IRegionWindow = var_108.getListItemByName("owner_region") as IRegionWindow;
         if(_loc8_ != null)
         {
            _loc8_.addEventListener("WME_CLICK",onOwnerRegion);
            _loc8_.addEventListener("WME_OVER",onOwnerRegion);
            _loc8_.addEventListener("WME_OUT",onOwnerRegion);
         }
      }
      
      private function set nowPlayingTrackName(param1:String) : void
      {
         var _loc2_:class_1812 = var_108.getListItemByName("trackname_container") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_name_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
      }
      
      private function set nowPlayingAuthorName(param1:String) : void
      {
         var _loc2_:class_1812 = var_108.getListItemByName("creatorname_container") as class_1812;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ITextWindow = _loc2_.getChildByName("track_creator_text") as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param1;
         _loc3_.visible = true;
         _loc3_.height = _loc3_.textHeight + 5;
      }
      
      public function updateSongInfo(param1:RoomWidgetSongUpdateEvent) : void
      {
         if(param1.type == "RWSUE_PLAYING_CHANGED")
         {
            var_2766 = param1.songId;
         }
         if(param1.songId == var_2766)
         {
            _songName = param1.songName;
            var_4431 = param1.songAuthor;
            updateNowPlaying(var_2766 >= 0);
         }
      }
      
      private function updateNowPlaying(param1:Boolean) : void
      {
         var _loc2_:String = null;
         var _loc3_:ITextWindow = var_108.getListItemByName("now_playing_text") as ITextWindow;
         if(_loc3_ != null)
         {
            if(param1)
            {
               _loc2_ = var_16.localizations.getLocalization("infostand.jukebox.text.now.playing");
            }
            else
            {
               _loc2_ = var_16.localizations.getLocalization("infostand.jukebox.text.not.playing");
            }
            _loc3_.text = _loc2_;
         }
         if(param1)
         {
            nowPlayingTrackName = _songName;
            nowPlayingAuthorName = var_4431;
         }
         else
         {
            nowPlayingTrackName = "";
            nowPlayingAuthorName = "";
         }
         updateWindow();
      }
   }
}

