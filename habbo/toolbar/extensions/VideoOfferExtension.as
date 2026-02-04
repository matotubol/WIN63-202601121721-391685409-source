package com.sulake.habbo.toolbar.extensions
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IIconWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.IVideoOfferLauncher;
   import com.sulake.habbo.catalog.enum.VideoOfferTypeEnum;
   import com.sulake.habbo.inventory.events.HabboInventoryHabboClubEvent;
   import com.sulake.habbo.toolbar.HabboToolbar;
   import package_71.class_2196;
   
   public class VideoOfferExtension implements IVideoOfferLauncher
   {
      
      private static const const_569:String = "video_offer";
      
      private static const LINK_COLOR_NORMAL:uint = 16777215;
      
      private static const LINK_COLOR_HIGHLIGHT:uint = 12247545;
      
      private static const CLOSE_COLOR_NORMAL:uint = 6710886;
      
      private static const CLOSE_COLOR_OVER:uint = 13421772;
      
      private var _toolbar:HabboToolbar;
      
      private var var_18:class_1812;
      
      private var var_819:IRegionWindow;
      
      private var var_421:IIconWindow;
      
      private var var_3707:Boolean = false;
      
      public function VideoOfferExtension(param1:HabboToolbar)
      {
         super();
         _toolbar = param1;
      }
      
      public function get window() : class_1741
      {
         return var_18;
      }
      
      public function onClubChanged(param1:HabboInventoryHabboClubEvent) : void
      {
         if(_toolbar.inventory.clubIsExpiring && !var_18 && isClubExtensionEnabled())
         {
            _toolbar.extensionView.detachExtension("video_offer");
            destroyWindow();
            return;
         }
         if(!var_3707 && !var_18)
         {
            _toolbar.catalog.videoOffers.load(this);
         }
      }
      
      private function isClubExtensionEnabled() : Boolean
      {
         return _toolbar.inventory.clubLevel == 2 && _toolbar.getBoolean("club.membership.extend.vip.promotion.enabled");
      }
      
      public function offersAvailable(param1:int) : void
      {
         if(_toolbar == null)
         {
            return;
         }
         if(param1 <= 0 || var_3707 || _toolbar.inventory.clubIsExpiring && isClubExtensionEnabled())
         {
            if(var_18)
            {
               destroyWindow();
            }
            return;
         }
         if(!var_18)
         {
            var_18 = createWindow();
         }
      }
      
      private function createWindow() : class_1812
      {
         var _loc3_:XmlAsset = _toolbar.assets.getAssetByName("video_offer_promotion_xml") as XmlAsset;
         if(_loc3_)
         {
            var _loc1_:class_1812 = _toolbar.windowManager.buildFromXML(_loc3_.content as XML,1) as class_1812;
         }
         return null;
      }
      
      private function destroyWindow() : void
      {
         if(var_18)
         {
            if(var_819)
            {
               var_819.removeEventListener("WME_CLICK",onTextRegionClicked);
               var_819.removeEventListener("WME_OVER",onTextRegionMouseOver);
               var_819.removeEventListener("WME_OUT",onTextRegionMouseOut);
               var_819 = null;
            }
            if(var_421)
            {
               var_421.removeEventListener("WME_CLICK",onCloseClicked);
               var_421.removeEventListener("WME_OVER",onCloseMouseOver);
               var_421.removeEventListener("WME_OUT",onCloseMouseOut);
               var_421 = null;
            }
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function dispose() : void
      {
         if(_toolbar == null)
         {
            return;
         }
         _toolbar.extensionView.detachExtension("video_offer");
         destroyWindow();
         _toolbar = null;
      }
      
      private function onCloseClicked(param1:WindowMouseEvent) : void
      {
         var_3707 = true;
         destroyWindow();
         _toolbar.connection.send(new class_2196("SuperSaverAds","client_action","supersaverads.video.promo.close_clicked"));
      }
      
      private function onCloseMouseOver(param1:WindowMouseEvent) : void
      {
         if(var_421)
         {
            var_421.color = 13421772;
         }
      }
      
      private function onCloseMouseOut(param1:WindowMouseEvent) : void
      {
         if(var_421)
         {
            var_421.color = 6710886;
         }
      }
      
      private function onTextRegionClicked(param1:WindowMouseEvent) : void
      {
         if(!_toolbar.catalog.videoOffers.launch(VideoOfferTypeEnum.CREDIT))
         {
            destroyWindow();
         }
      }
      
      private function onTextRegionMouseOver(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 12247545;
         }
      }
      
      private function onTextRegionMouseOut(param1:WindowMouseEvent) : void
      {
         var _loc2_:ITextWindow = null;
         if(var_18)
         {
            _loc2_ = var_18.findChildByName("promo_text") as ITextWindow;
            _loc2_.textColor = 16777215;
         }
      }
   }
}

