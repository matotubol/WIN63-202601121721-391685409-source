package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowLinkEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.navigation.class_1917;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.utils.HabboWebTools;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   
   public class LocalizationCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var var_1552:Dictionary;
      
      private var _catalog:HabboCatalog;
      
      public function LocalizationCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         var_1552 = new Dictionary();
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _catalog = null;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         initLocalizables();
         initStaticImages();
         initLinks();
         events.addEventListener("SELECT_PRODUCT",onProductSelected);
         return true;
      }
      
      private function onProductSelected(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
      }
      
      private function initLinks() : void
      {
         var _loc2_:class_1741 = null;
         if(page.hasLinks)
         {
            for each(var _loc1_ in page.links)
            {
               _loc2_ = _window.findChildByName(_loc1_);
               if(_loc2_ != null)
               {
                  _loc2_.setParamFlag(1);
                  _loc2_.mouseThreshold = 0;
                  _loc2_.addEventListener("WME_CLICK",onClickLink);
               }
            }
         }
      }
      
      private function onClickLink(param1:WindowMouseEvent) : void
      {
         var _loc4_:class_27 = (page.viewer.catalog as HabboCatalog).localization;
         var _loc2_:class_16 = page.viewer.catalog as HabboCatalog;
         var _loc6_:String = class_1741(param1.target).name;
         var _loc5_:String = "";
         switch(page.layoutCode)
         {
            case "frontpage3":
               switch(_loc6_)
               {
                  case "ctlg_txt3":
                     if(class_1741(param1.target).caption != "")
                     {
                        _loc5_ = page.localization.getTextElementContent(6);
                        page.viewer.catalog.openCatalogPage(_loc5_);
                     }
                     break;
                  case "ctlg_txt7":
                     if(class_1741(param1.target).caption != "")
                     {
                        _loc5_ = page.localization.getTextElementContent(10);
                        if(_loc5_.indexOf("http") >= 0)
                        {
                           openExternalLink(_loc5_);
                           break;
                        }
                        if(_loc5_ == "credits")
                        {
                           HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                           break;
                        }
                        page.viewer.catalog.openCatalogPage(_loc5_);
                     }
               }
               break;
            case "info_pixels":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     _catalog.questEngine.showAchievements();
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "info_credits":
               switch(_loc6_)
               {
                  case "ctlg_text_5":
                     HabboWebTools.openWebPageAndMinimizeClient(_catalog.getProperty("web.shop.relativeUrl"));
                     break;
                  case "ctlg_text_7":
                     _loc5_ = page.localization.getTextElementContent(7);
                     page.viewer.catalog.openCatalogPage(_loc5_);
               }
               break;
            case "collectibles":
               var _loc7_:String = _loc6_;
               if("ctlg_collectibles_link" !== _loc7_)
               {
                  break;
               }
               _loc5_ = _loc2_.getProperty("link.format.collectibles");
               openExternalLink(_loc5_);
               break;
            case "club1":
               _loc7_ = _loc6_;
               if("ctlg_text_5" !== _loc7_)
               {
                  break;
               }
               page.viewer.catalog.openCatalogPage("hc_membership");
               break;
            case "club_buy":
               _loc7_ = _loc6_;
               if("club_link" !== _loc7_)
               {
                  break;
               }
               _loc5_ = _loc2_.getProperty("link.format.club");
               openExternalLink(_loc5_);
               break;
            case "mad_money":
               _loc7_ = _loc6_;
               if("ctlg_madmoney_button" !== _loc7_)
               {
                  break;
               }
               _loc5_ = _loc2_.getProperty("link.format.madmoney");
               openExternalLink(_loc5_);
               break;
            case "monkey":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = _loc4_.getLocalization("link.format.monkey","http://store.apple.com/");
                     openExternalLink(_loc5_);
               }
               break;
            case "niko":
               switch(_loc6_)
               {
                  case "ctlg_teaserimg_1_region":
                  case "ctlg_special_img_region":
                     _loc5_ = _loc4_.getLocalization("link.format.niko","http://itunes.apple.com/us/app/niko/id481670205?mt=8");
                     openExternalLink(_loc5_);
               }
               break;
            default:
               class_21.log("[Localization Catalog Widget] Unhandled link clicked" + [page.layoutCode,_loc6_]);
         }
      }
      
      private function openExternalLink(param1:String) : void
      {
         if(param1 != "")
         {
            page.viewer.catalog.windowManager.alert("${catalog.alert.external.link.title}","${catalog.alert.external.link.desc}",0,onExternalLink);
            HabboWebTools.navigateToURL(param1,"habboMain");
         }
      }
      
      private function onExternalLink(param1:class_1750, param2:class_1758) : void
      {
         param1.dispose();
      }
      
      private function initStaticImages() : void
      {
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc1_:Array = [];
         _window.groupChildrenWithTag("STATIC_IMAGE",_loc1_,10);
         for each(var _loc3_ in _loc1_)
         {
            if(_loc3_ is class_2251)
            {
               _loc4_ = _loc3_.name;
               _loc2_ = _loc3_.name;
               var_1552[_loc2_] = _loc4_;
               if(page.viewer.catalog.assets.hasAsset(_loc2_))
               {
                  setElementImage(_loc4_,_loc2_);
               }
               else
               {
                  retrieveCatalogImage(_loc2_);
               }
            }
         }
      }
      
      protected function initLocalizables() : void
      {
         var_1552 = new Dictionary();
         _catalog.mainContainer.findChildByName("catalog.header.description").caption = "";
         var _loc4_:int = 0;
         while(0 < page.localization.textCount)
         {
            var _loc9_:String = page.localization.getTextElementName(0,page.layoutCode);
            var _loc6_:String = page.localization.getTextElementContent(0);
            if(_window != null)
            {
               var _loc8_:class_1741 = _window.findChildByName(null);
            }
            class_21.log("[Localization Catalog Widget] Could not place text in layout:  element: " + null + ", content: " + null);
            _loc4_++;
         }
         _loc4_ = 0;
         while(0 < page.localization.imageCount)
         {
            _loc9_ = page.localization.getImageElementName(0,page.layoutCode);
            _loc6_ = page.localization.getImageElementContent(0);
            var _loc5_:* = null;
            var_1552[null] = null;
            if(page.viewer.catalog.assets.hasAsset(null))
            {
               setElementImage(null,null);
            }
            else
            {
               retrieveCatalogImage(null);
            }
            _loc4_++;
         }
         var _loc1_:class_1917 = _catalog.currentCatalogNavigator.getNodeById(page.pageId);
         var _loc7_:class_1741 = _catalog.mainContainer.findChildByName("catalog.header.title");
         var _loc3_:IStaticBitmapWrapperWindow = _catalog.mainContainer.findChildByName("catalog.header.icon") as IStaticBitmapWrapperWindow;
         if(_loc7_ != null)
         {
            _loc7_.caption = _loc1_ != null ? _loc1_.localization : (page.mode == 1 ? "${catalog.search.header}" : "${catalog.header}");
         }
         if(_loc3_ != null && _loc1_ != null)
         {
            _loc3_.assetUri = page.mode == 1 ? "common_small_pen" : (_catalog.catalogType == "BUILDERS_CLUB" ? _catalog.imageGalleryHost + "icon_193.png" : _catalog.imageGalleryHost + _loc1_.iconName + ".png");
         }
      }
      
      private function onClickHtmlLink(param1:class_1758) : void
      {
         var _loc2_:WindowLinkEvent = param1 as WindowLinkEvent;
         if(_loc2_ != null)
         {
            class_21.log("=============== HTML LINK: " + _loc2_.link);
         }
         else
         {
            class_21.log("=============== BAD HTML LINK: " + param1.target);
         }
      }
      
      private function setElementImage(param1:String, param2:String) : void
      {
         var _loc9_:class_1741 = null;
         var _loc8_:String = null;
         class_21.log("[Localization Catalog Widget] Set Element Image: " + [param1,param2]);
         if(_window == null)
         {
            class_21.log("[Localization Catalog Widget] Window is null! " + [param1,param2]);
            return;
         }
         if(_window.disposed)
         {
            class_21.log("[Localization Catalog Widget] Window is disposed! " + [param1,param2,_window.name]);
            return;
         }
         if(param1 == "catalog.header.image")
         {
            _loc9_ = _catalog.mainContainer.findChildByName(param1);
         }
         else
         {
            _loc9_ = _window.findChildByName(param1);
         }
         if(_loc9_ is class_2251)
         {
            var _loc7_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param2) as BitmapDataAsset;
            if(_loc7_ == null)
            {
               class_21.log("[Localization Catalog Widget] Asset does not exist (Bitmap window): " + [param1,param2]);
               return;
            }
            var _loc4_:BitmapData = null.content as BitmapData;
            if((_loc9_ as class_2251).bitmap == null)
            {
               (_loc9_ as class_2251).bitmap = new BitmapData(_loc9_.width,_loc9_.height,true,16777215);
            }
            (_loc9_ as class_2251).bitmap.fillRect((_loc9_ as class_2251).bitmap.rect,16777215);
            var _loc3_:int = (_loc9_.width - null.width) / 2;
            var _loc5_:int = (_loc9_.height - null.height) / 2;
            (_loc9_ as class_2251).bitmap.copyPixels(null,null.rect,new Point(0,0),null,null,true);
         }
         else if(_loc9_ is IStaticBitmapWrapperWindow)
         {
            _loc8_ = _catalog.getProperty("image.library.catalogue.url");
            var _loc6_:String = _loc8_ + param2 + ".gif";
            class_21.log("[Localization Catalog Widget] Static Image: " + null);
            (_loc9_ as IStaticBitmapWrapperWindow).assetUri = null;
         }
         else
         {
            class_21.log("[Localization Catalog Widget] Could not find element: " + param1);
         }
      }
      
      private function retrieveCatalogImage(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc9_:class_1741 = null;
         var _loc6_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.catalogue.url");
         var _loc2_:String = (page.viewer.catalog as HabboCatalog).getProperty("image.library.url") + "Top_Story_Images/";
         var _loc8_:String = var_1552[param1];
         if(_loc8_ == "catalog.header.image")
         {
            _loc9_ = _catalog.mainContainer.findChildByName(_loc8_);
         }
         else
         {
            _loc9_ = _window.findChildByName(_loc8_);
         }
         if(_loc9_ && _loc9_.tags.indexOf("TOP_STORY") > -1)
         {
            _loc5_ = _loc2_;
         }
         else
         {
            _loc5_ = _loc6_;
         }
         var _loc7_:String = _loc5_ + param1 + ".gif";
         class_21.log("[Localization Catalog Widget]  : " + _loc7_);
         var _loc3_:URLRequest = new URLRequest(_loc7_);
         var _loc4_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc3_,"image/gif");
         _loc4_.addEventListener("AssetLoaderEventComplete",onCatalogImageReady);
      }
      
      private function onCatalogImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc3_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.assetName;
            _loc4_ = var_1552[_loc2_];
            setElementImage(_loc4_,_loc2_);
         }
      }
      
      private function setLinkStyle(param1:ITextWindow) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc6_:StyleSheet = new StyleSheet();
         var _loc2_:Object = {};
         _loc2_.color = "#336a95";
         var _loc3_:Object = {};
         _loc3_.textDecoration = "underline";
         _loc3_.color = "#333333";
         var _loc5_:Object = {};
         _loc5_.color = "#41b7d9";
         var _loc4_:Object = {};
         _loc4_.textDecoration = "underline";
         _loc6_.setStyle("a:link",_loc3_);
         _loc6_.setStyle("a:hover",_loc2_);
         _loc6_.setStyle("a:active",_loc5_);
         _loc6_.setStyle(".visited",_loc4_);
         param1.styleSheet = _loc6_;
      }
   }
}

