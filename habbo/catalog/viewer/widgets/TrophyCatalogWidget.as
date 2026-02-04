package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2143;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_3172;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetExtraPurchaseParameterEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.TextInputEvent;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class TrophyCatalogWidget extends CatalogWidget implements class_2612, class_1829
   {
      
      private static const gold:int = 16763904;
      
      private static const silver:int = 13421772;
      
      private static const bronze:int = 13395456;
      
      private var var_181:class_2251;
      
      private var _trophyOffers:class_55;
      
      private var var_434:int = 0;
      
      private var var_1219:String = "g";
      
      private var _catalog:HabboCatalog;
      
      private var var_758:class_1741;
      
      public function TrophyCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(_trophyOffers != null)
         {
            _trophyOffers.dispose();
         }
         _trophyOffers = null;
         _catalog = null;
         var_758 = null;
         super.dispose();
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_181 = window.findChildByName("ctlg_teaserimg_1") as class_2251;
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         events.addEventListener("TEXT_INPUT",onTextInput);
         var _loc5_:class_2143 = window.findChildByName("ctlg_nextmodel_button") as class_2143;
         var _loc4_:class_2143 = window.findChildByName("ctlg_prevmodel_button") as class_2143;
         if(_loc5_ != null)
         {
            _loc5_.addEventListener("WME_CLICK",onClickNext);
         }
         if(_loc4_ != null)
         {
            _loc4_.addEventListener("WME_CLICK",onClickPrev);
         }
         _trophyOffers = new class_55();
         var _loc1_:Offer = null;
         for each(_loc1_ in page.offers)
         {
            var _loc7_:String = getBaseNameFromProduct(_loc1_.localizationId);
            var _loc6_:String = getTrophyTypeFromProduct(_loc1_.localizationId);
            if(_trophyOffers.getValue(null) == null)
            {
               _trophyOffers.add(null,new class_55());
            }
            var _loc2_:class_55 = _trophyOffers.getValue(null) as class_55;
            null.add(null,_loc1_);
         }
         if(page.offers.length == 1)
         {
            _loc5_.visible = _loc4_.visible = false;
            if(page.offers[0].product.isColorable == false)
            {
               if(class_1812(window.parent))
               {
                  var _loc3_:class_1812 = class_1812(window.parent).findChildByName("colourGridWidget") as class_1812;
               }
            }
         }
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent) : void
      {
         var _loc3_:Offer = null;
         var _loc4_:Array = [];
         _loc4_.push(16763904);
         _loc4_.push(13421772);
         _loc4_.push(13395456);
         var _loc2_:class_55 = _trophyOffers.getWithIndex(var_434);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_1219);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
         events.dispatchEvent(new CatalogWidgetColoursEvent(_loc4_,"ctlg_clr_40x32_1","ctlg_clr_40x32_2","ctlg_clr_40x32_3"));
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc5_:BitmapData = null;
         var _loc3_:class_1857 = null;
         var _loc4_:class_2198 = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:class_1793 = param1.offer;
         var _loc6_:class_1949 = page.viewer.catalog.getProductData(_loc2_.localizationId);
         if(class_3172.hasProductImage(_loc2_.localizationId))
         {
            setPreviewFromAsset(class_3172.PRODUCT_IMAGES[_loc2_.localizationId]);
         }
         else
         {
            _loc3_ = _loc2_.product;
            _loc4_ = page.viewer.roomEngine.getFurnitureImage(_loc3_.productClassId,new Vector3d(2,0,0),64,this,0,_loc3_.extraParam);
            _loc2_.previewCallbackId = _loc4_.id;
            if(_loc4_ != null)
            {
               _loc5_ = _loc4_.data;
            }
            setPreviewImage(_loc5_,true);
         }
         var_758 = _catalog.utils.showPriceOnProduct(_loc2_,_window,var_758,var_181,0,false,0);
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         var _loc3_:Offer = null;
         if(param1.index == 0)
         {
            var_1219 = "g";
         }
         if(param1.index == 1)
         {
            var_1219 = "s";
         }
         if(param1.index == 2)
         {
            var_1219 = "b";
         }
         var _loc2_:class_55 = _trophyOffers.getWithIndex(var_434);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.getValue(var_1219);
            if(_loc3_ == null)
            {
               _loc3_ = _loc2_.getWithIndex(0);
            }
            if(_loc3_ != null)
            {
               events.dispatchEvent(new SelectProductEvent(_loc3_));
            }
         }
         var_758 = _catalog.utils.showPriceOnProduct(_loc3_,_window,var_758,var_181,0,false,0);
      }
      
      public function onTextInput(param1:TextInputEvent) : void
      {
         events.dispatchEvent(new SetExtraPurchaseParameterEvent(param1.text));
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         for each(var _loc3_ in page.offers)
         {
            if(_loc3_.previewCallbackId == param1)
            {
               _loc3_.previewCallbackId = 0;
               setPreviewImage(param2,true);
               break;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function getBaseNameFromProduct(param1:String) : String
      {
         var _loc2_:String = getTrophyTypeFromProduct(param1);
         if(_loc2_.length > 0)
         {
            return param1.slice(0,param1.length - 1 - _loc2_.length);
         }
         return param1;
      }
      
      private function getTrophyTypeFromProduct(param1:String) : String
      {
         var _loc3_:int = int(param1.indexOf("prizetrophy_2011_"));
         if(_loc3_ != -1)
         {
            return "";
         }
         var _loc2_:int = param1.lastIndexOf("_") + 1;
         if(_loc2_ <= 0)
         {
            return "";
         }
         var _loc4_:String = param1.substr(_loc2_);
         if(_loc4_.length > 1 || _loc4_ != "g" && _loc4_ != "s" && _loc4_ != "b")
         {
            return "";
         }
         return _loc4_;
      }
      
      private function onClickNext(param1:WindowMouseEvent) : void
      {
         var_434 = var_434 + 1;
         if(var_434 >= _trophyOffers.length)
         {
            var_434 = 0;
         }
         var _loc2_:class_55 = _trophyOffers.getWithIndex(var_434);
         if(_loc2_ != null)
         {
            var _loc3_:Offer = _loc2_.getValue(var_1219);
            _loc3_ = _loc2_.getWithIndex(0);
         }
      }
      
      private function onClickPrev(param1:WindowMouseEvent) : void
      {
         var_434 = var_434 - 1;
         if(var_434 < 0)
         {
            var_434 = _trophyOffers.length - 1;
         }
         var _loc2_:class_55 = _trophyOffers.getWithIndex(var_434);
         if(_loc2_ != null)
         {
            var _loc3_:Offer = _loc2_.getValue(var_1219);
            _loc3_ = _loc2_.getWithIndex(0);
         }
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc3_:Point = null;
         if(!window.disposed && var_181 != null)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            if(var_181.bitmap == null)
            {
               var_181.bitmap = new BitmapData(var_181.width,var_181.height,true,16777215);
            }
            var_181.bitmap.fillRect(var_181.bitmap.rect,16777215);
            _loc3_ = new Point((var_181.width - param1.width) / 2,(var_181.height - param1.height) / 2);
            var_181.bitmap.copyPixels(param1,param1.rect,_loc3_,null,null,true);
            var_181.invalidate();
         }
         if(param2 && param1 != null)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         var _loc2_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc2_ == null)
         {
            retrievePreviewAsset(param1);
            return;
         }
         setPreviewImage(_loc2_.content as BitmapData,false);
      }
      
      private function retrievePreviewAsset(param1:String) : void
      {
         var _loc4_:String = page.viewer.catalog.imageGalleryHost + param1 + ".gif";
         class_21.log("[TrophyCatalogWidget] Retrieve Product Preview Asset: " + _loc4_);
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         var _loc3_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
         }
      }
   }
}

