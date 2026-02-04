package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1970;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.animation.ISpriteDataContainer;
   import com.sulake.habbo.avatar.animation.class_2314;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.BundleProductContainer;
   import com.sulake.habbo.catalog.viewer.ProductDisplayWrapper;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.class_2050;
   import com.sulake.habbo.catalog.viewer.class_3172;
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetBundleDisplayExtraInfoEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SetRoomPreviewerStuffDataEvent;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.room.preview.RoomPreviewer;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.window.class_38;
   import com.sulake.habbo.window.widgets.class_1902;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.net.URLRequest;
   
   public class ProductViewCatalogWidget extends CatalogWidget implements class_2612, class_1829, class_2050
   {
      
      private static const WALL_PAPER:int = 2;
      
      private static const const_250:int = 3;
      
      private static const LANDSCAPE:int = 4;
      
      private var var_3146:BitmapData;
      
      private var _productName:class_1741;
      
      private var var_1593:class_1741;
      
      private var var_181:class_2251;
      
      private var var_304:class_1812;
      
      private var var_1030:class_2010;
      
      private var var_3250:class_1902;
      
      private var var_624:class_1970;
      
      private var _previewOffset:Point;
      
      private var _bundleGrid:IItemGridWindow;
      
      protected var _gridItemLayout:XML;
      
      private var var_5135:Array;
      
      private var _overrideStuffData:IStuffData;
      
      private var var_2477:SelectProductEvent = null;
      
      private var _catalog:HabboCatalog;
      
      private var var_758:class_1741;
      
      private var var_3342:Boolean = true;
      
      private var var_4839:Boolean = false;
      
      private var var_3782:Boolean = true;
      
      private var _offer:class_1793;
      
      private var var_2003:Boolean;
      
      public function ProductViewCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      private static function ninjaEffectBundled(param1:SelectProductEvent) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:class_1857 = null;
         var _loc4_:Boolean = false;
         if(param1.offer.productContainer.products.length == 2)
         {
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_ = param1.offer.productContainer.products[_loc3_];
               if(_loc2_.productType == "e" && _loc2_.productClassId == 108)
               {
                  _loc4_ = true;
               }
               _loc3_++;
            }
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onPreviewProduct);
            events.removeEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
            events.removeEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
            events.removeEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
            _catalog = null;
            var_758 = null;
            super.dispose();
            var_3146 = null;
            var_304 = null;
            var_1030 = null;
            var_3250 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("productViewWidget");
         if(!_isEmbedded)
         {
            _window.getChildAt(0).width = _window.width;
            _window.getChildAt(0).height = _window.height;
         }
         if(_window.tags.indexOf("2X") > -1)
         {
         }
         var_3782 = _window.tags.indexOf("NO_ROOM_CANVAS") == -1;
         var_758 = null;
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         var_1593 = _window.findChildByName("ctlg_description");
         var_1593.caption = "";
         (_productName as ITextWindow).textColor = 0;
         (var_1593 as ITextWindow).textColor = 0;
         var_181 = _window.findChildByName("ctlg_teaserimg_1") as class_2251;
         var_304 = _window.findChildByName("room_canvas_container") as class_1812;
         if(var_304 != null)
         {
            var_304.visible = false;
            var_624 = var_304.findChildByName("room_canvas") as class_1970;
            var _loc4_:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            if(var_624 != null && null != null)
            {
               var_304.procedure = roomCanvasContainerProcedure;
               null.disableUpdate = false;
               null.reset(false);
               var _loc3_:DisplayObject = null.getRoomCanvas(var_624.width,var_624.height);
            }
            else
            {
               var_304 = null;
               var_624 = null;
            }
         }
         var_1030 = _window.findChildByName("product_image_widget") as class_2010;
         if(var_1030 != null)
         {
            var_3250 = var_1030.widget as class_1902;
            var_1030.visible = false;
         }
         _previewOffset = new Point(var_181.x,var_181.y);
         _bundleGrid = _window.findChildByName("bundleGrid") as IItemGridWindow;
         if(_bundleGrid == null)
         {
            class_21.log("[Product View Catalog Widget] Bundle Grid not initialized!");
         }
         var _loc2_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc2_.content as XML;
         var _loc1_:BitmapDataAsset = page.viewer.catalog.assets.getAssetByName("ctlg_dyndeal_background") as BitmapDataAsset;
         var_3146 = _loc1_.content as BitmapData;
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         events.addEventListener("CWE_SET_PREVIEWER_STUFFDATA",onStuffDataSet);
         events.addEventListener("CWSE_VALUE_CHANGED",onSpinnerEvent);
         events.addEventListener("TOTAL_PRICE_WIDGET_INITIALIZED",onTotalPriceWidgetInitialized);
         return true;
      }
      
      private function roomCanvasContainerProcedure(param1:class_1758, param2:class_1741) : void
      {
         switch(param1.type)
         {
            case "WME_CLICK":
               if(_catalog.roomPreviewer != null)
               {
                  _catalog.roomPreviewer.changeRoomObjectState();
               }
               break;
            case "WME_UP":
            case "WME_OVER":
               var_2003 = false;
               break;
            case "WME_DOWN":
               var_2003 = true;
               break;
            case "WME_OUT":
               if(var_2003)
               {
                  if(_catalog.isDraggable(_offer))
                  {
                     _catalog.requestSelectedItemToMover(this,_offer);
                  }
               }
               var_2003 = false;
         }
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_2477 = param1;
         removeEffectSprites();
         var _loc14_:class_1793;
         _offer = _loc14_ = param1.offer;
         if(_bundleGrid != null)
         {
            _bundleGrid.visible = false;
            _bundleGrid.destroyGridItems();
         }
         _productName.caption = _loc14_.localizationName;
         var_1593.caption = _loc14_.localizationDescription;
         var_1593.y = _productName.y + _productName.height;
         if(_catalog.multiplePurchaseEnabled && _loc14_.bundlePurchaseAllowed && var_4839)
         {
            setSpinnerToBundleRuleset();
            setBundleInfoWidgetToOffer(_loc14_);
            var_3342 = false;
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_HIDE"));
            events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_HIDE"));
            var_3342 = true;
         }
         if(var_3342)
         {
            var_758 = _catalog.utils.showPriceOnProduct(_loc14_,_window,var_758,var_181,-6,false,6,page.acceptSeasonCurrencyAsCredits,page.acceptSeasonCurrencyAsCredits);
         }
         else if(var_758 != null)
         {
            _window.removeChild(var_758);
            var_758.dispose();
            var_758 = null;
         }
         if(_loc14_.badgeCode != null && _loc14_.badgeCode != "")
         {
            _catalog.utils.showExtraOnProduct(4,_loc14_.badgeCode,_window,6,38,true,false);
         }
         else if(_loc14_.extraChatStyleCode && _loc14_.extraChatStyleCode != "")
         {
            _catalog.utils.showExtraOnProduct(9,_loc14_.extraChatStyleCode,_window,6,38,true,false);
         }
         else if(ninjaEffectBundled(param1))
         {
            _catalog.utils.showAssetImageAsBadgeOnProduct("catalogue_effects_ninja",_window,6,38,true,false);
         }
         else
         {
            _catalog.utils.hideExtraFromProduct(_window);
         }
         if(var_1030 != null)
         {
            var_1030.visible = false;
         }
         if(class_3172.hasProductImage(_loc14_.localizationId))
         {
            setPreviewFromAsset(class_3172.PRODUCT_IMAGES[_loc14_.localizationId]);
            if(var_304 != null)
            {
               var_304.visible = false;
            }
         }
         else
         {
            var _loc27_:Point = new Point(0,0);
            var _loc4_:RoomPreviewer = _catalog.roomPreviewer;
            switch(_loc14_.pricingModel)
            {
               case "pricing_model_bundle":
                  var _loc33_:BitmapData = var_3146.clone();
                  if(_bundleGrid != null)
                  {
                     _bundleGrid.visible = true;
                     var _loc2_:BundleProductContainer = _loc14_.productContainer as BundleProductContainer;
                     null.populateItemGrid(_bundleGrid,_gridItemLayout);
                     _bundleGrid.scrollV = 0;
                  }
                  if(var_304 != null)
                  {
                     var_304.visible = false;
                  }
                  break;
               case "pricing_model_single":
               case "pricing_model_multi":
               case "pricing_model_furniture":
                  var _loc24_:class_1857 = _loc14_.product;
                  if(var_304 != null && var_3782)
                  {
                     if(null.productType == "s" || null.productType == "i" || null.productType == "e")
                     {
                        var_304.visible = true;
                     }
                     else
                     {
                        var_304.visible = false;
                     }
                  }
                  switch(null.productType)
                  {
                     case "s":
                        var _loc8_:class_2198 = page.viewer.roomEngine.getFurnitureImage(null.productClassId,new Vector3d(90,0,0),64,this,0,null.extraParam,-1,-1,_overrideStuffData);
                        _loc14_.previewCallbackId = null.id;
                        break;
                     case "i":
                        if(null.furnitureData.category == 2 || null.furnitureData.category == 3 || null.furnitureData.category == 4)
                        {
                           var _loc29_:String = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_wall_type");
                           var _loc22_:String = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_floor_type");
                           var _loc10_:String = _catalog.roomEngine.getRoomStringValue(_catalog.roomEngine.activeRoomId,"room_landscape_type");
                           _loc29_ = "101";
                           _loc22_ = "101";
                           _loc10_ = "1.1";
                           null.updateRoomWallsAndFloorVisibility(true,true);
                           var _loc21_:String = null.furnitureData.category == 3 ? null.extraParam : null;
                           var _loc3_:String = null.furnitureData.category == 2 ? null.extraParam : null;
                           var _loc34_:String = null.furnitureData.category == 4 ? null.extraParam : null;
                           null.updateObjectRoom(null,null,null);
                           if(null.furnitureData.category == 4)
                           {
                              var _loc12_:class_1800 = _catalog.getFurnitureDataByName("ads_twi_windw","i");
                              null.addWallItemIntoRoom(null.id,new Vector3d(90,0,0),null.customParams);
                           }
                           break;
                        }
                        _loc8_ = page.viewer.roomEngine.getWallItemImage(null.productClassId,new Vector3d(90,0,0),64,this,0,null.extraParam);
                        _loc14_.previewCallbackId = null.id;
                        break;
                     case "r":
                        var _loc32_:class_1827 = _catalog.avatarRenderManager.createAvatarImage(null.extraParam,"h",null);
                        _loc32_.appendAction("gest","sml");
                        null.setDirection("full",4);
                        null.setDirection("head",3);
                        _loc33_ = null.getCroppedImage("full");
                        break;
                     case "e":
                        var _loc13_:class_38 = page.viewer.catalog.windowManager;
                        var _loc5_:class_1812 = _window.findChildByName("pixelsBackground") as class_1812;
                        var _loc18_:Number = 4291611852;
                        _loc33_ = new BitmapData(var_181.width,var_181.height,false,0);
                        var _loc16_:BitmapData = null;
                        var _loc9_:HabboCatalog = page.viewer.catalog as HabboCatalog;
                        if(_loc9_.avatarRenderManager != null)
                        {
                           var _loc28_:String = null.sessionDataManager.figure;
                           var _loc30_:class_1827 = null.avatarRenderManager.createAvatarImage(null,"h");
                           if(_loc30_ != null)
                           {
                              null.setDirection("head",3);
                              null.initActionAppends();
                              null.appendAction("gest","sml");
                              null.appendAction("fx",null.productClassId);
                              null.endActionAppends();
                              null.updateAnimationByFrames(1);
                              null.updateAnimationByFrames(1);
                              _loc16_ = null.getImage("full",true);
                              var _loc6_:Point = new Point(0,0);
                              var _loc31_:int = 64;
                              var _loc11_:Point = new Point((null.width - 0) / 2,null.height - 0 / 4);
                              addEffectSprites(null,null,null,null.add(null),false);
                              null.copyPixels(null,null.rect,null,null,null,true);
                              addEffectSprites(null,null,null,null.add(null));
                           }
                        }
                        break;
                     default:
                        if(ProductDisplayWrapper.isSupported(null.productType) && var_1030 != null)
                        {
                           var_1030.visible = true;
                           var_3250.productInfo = new ProductDisplayWrapper(null);
                           break;
                        }
                        class_21.log("[Product View Catalog Widget] Unknown Product Type: " + null.productType);
                        break;
                     case "h":
                  }
                  break;
               default:
                  class_21.log("[Product View Catalog Widget] Unknown pricing model" + _loc14_.pricingModel);
            }
            setPreviewImage(null,true,null);
         }
         (_productName as ITextWindow).textColor = 4278190080;
         (var_1593 as ITextWindow).textColor = 4278190080;
         _window.invalidate();
      }
      
      private function setBundleInfoWidgetToOffer(param1:class_1793) : void
      {
         var _loc2_:ExtraInfoItemData = new ExtraInfoItemData(5);
         _loc2_.activityPointType = param1.activityPointType;
         _loc2_.priceActivityPoints = param1.priceInActivityPoints;
         _loc2_.priceCredits = param1.priceInCredits;
         _loc2_.priceSilver = param1.priceInSilver;
         _loc2_.badgeCode = param1.badgeCode;
         events.dispatchEvent(new CatalogWidgetBundleDisplayExtraInfoEvent("CWPPEIE_RESET",_loc2_));
      }
      
      private function setSpinnerToBundleRuleset() : void
      {
         if(_catalog.bundleDiscountEnabled)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1,_catalog.utils.bundleDiscountFlatPriceSteps));
         }
         else
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_RESET",1));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SHOW"));
         if(_catalog.bundleDiscountRuleset != null)
         {
            events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MAX",_catalog.bundleDiscountRuleset.maxPurchaseSize));
         }
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_SET_MIN",1));
      }
      
      private function addEffectSprites(param1:BitmapData, param2:class_1827, param3:Point, param4:Point, param5:Boolean = true) : void
      {
         var _loc9_:* = null;
         var _loc17_:int = 0;
         var _loc10_:class_2314 = null;
         var _loc19_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc20_:int = 0;
         var _loc18_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         for each(_loc9_ in param2.getSprites())
         {
            _loc17_ = int(_window.getChildIndex(var_181));
            _loc10_ = param2.getLayerData(_loc9_);
            _loc19_ = 0;
            _loc14_ = _loc9_.getDirectionOffsetX(param2.getDirection());
            _loc15_ = _loc9_.getDirectionOffsetY(param2.getDirection());
            _loc16_ = _loc9_.getDirectionOffsetZ(param2.getDirection());
            _loc20_ = 0;
            if(!param5)
            {
               if(_loc16_ >= 0)
               {
                  continue;
               }
            }
            else if(_loc16_ < 0)
            {
               continue;
            }
            if(_loc9_.hasDirections)
            {
               _loc20_ = param2.getDirection();
            }
            if(_loc10_ != null)
            {
               _loc19_ = _loc10_.animationFrame;
               _loc14_ += _loc10_.dx;
               _loc15_ += _loc10_.dy;
               _loc20_ += _loc10_.directionOffset;
            }
            if(_loc20_ < 0)
            {
               _loc20_ += 8;
            }
            if(_loc20_ > 7)
            {
               _loc20_ -= 8;
            }
            var _loc7_:String = param2.getScale() + "_" + _loc9_.member + "_" + _loc20_ + "_" + _loc19_;
            var _loc6_:BitmapDataAsset = param2.getAsset(null);
            if(_loc6_ != null)
            {
               var _loc8_:BitmapData = (null.content as BitmapData).clone();
               _loc18_ = 1;
               _loc12_ = param4.x - 1 * null.offset.x + _loc14_;
               _loc13_ = param4.y - 1 * null.offset.y + _loc15_;
               if(_loc9_.ink == 33)
               {
                  var _loc11_:Matrix = new Matrix(1,0,0,1,_loc12_ - param3.x,_loc13_ - param3.y);
                  param1.draw(null,null,null,"add",null,false);
               }
               else
               {
                  param1.copyPixels(null,null.rect,new Point(_loc12_ - param3.x,_loc13_ - param3.y));
               }
            }
         }
      }
      
      private function removeEffectSprites() : void
      {
         for each(var _loc1_ in var_5135)
         {
            _window.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         var_5135 = [];
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
               setPreviewImage(param2,true);
               _loc3_.previewCallbackId = 0;
               break;
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean, param3:Point = null) : void
      {
         var _loc4_:Point = null;
         if(var_181 != null && !window.disposed)
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
            _loc4_ = new Point((var_181.width - param1.width) / 2,(var_181.height - param1.height) / 2);
            var_181.bitmap.copyPixels(param1,param1.rect,_loc4_,null,null,true);
            var_181.invalidate();
            var_181.x = _previewOffset.x;
            var_181.y = _previewOffset.y;
            if(param3 != null)
            {
               var_181.x += param3.x;
               var_181.y += param3.y;
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function setPreviewFromAsset(param1:String) : void
      {
         if(!param1 || !page || !page.viewer || !page.viewer.catalog || !page.viewer.catalog.assets)
         {
            return;
         }
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
         if(!param1 || !page || !page.viewer || !page.viewer.catalog)
         {
            return;
         }
         var _loc4_:String = page.viewer.catalog.imageGalleryHost + param1 + ".gif";
         class_21.log("[Product View Catalog Widget] Retrieve Product Preview Asset: " + _loc4_);
         var _loc2_:URLRequest = new URLRequest(_loc4_);
         if(!page.viewer.catalog.assets)
         {
            return;
         }
         var _loc3_:AssetLoaderStruct = page.viewer.catalog.assets.loadAssetFromFile(param1,_loc2_,"image/gif");
         if(!_loc3_)
         {
            return;
         }
         _loc3_.addEventListener("AssetLoaderEventComplete",onPreviewImageReady);
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = param1.target as AssetLoaderStruct;
         if(_loc2_ != null)
         {
            setPreviewFromAsset(_loc2_.assetName);
            _loc2_.removeEventListener("AssetLoaderEventComplete",onPreviewImageReady);
         }
      }
      
      private function onStuffDataSet(param1:SetRoomPreviewerStuffDataEvent) : void
      {
         _overrideStuffData = param1.stuffData;
         if(var_2477 != null)
         {
            var _loc2_:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
            onPreviewProduct(var_2477);
         }
      }
      
      private function onSpinnerEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         var _loc2_:class_1812 = null;
         if(param1.type == "CWSE_VALUE_CHANGED")
         {
            _loc2_ = window.findChildByName("price_box_new") as class_1812;
            if(_loc2_ != null && var_2477 != null)
            {
               _catalog.utils.showPriceInContainer(_loc2_,var_2477.offer);
            }
         }
      }
      
      private function onTotalPriceWidgetInitialized(param1:Event) : void
      {
         var_4839 = true;
      }
      
      override public function closed() : void
      {
         var _loc1_:RoomPreviewer = (page.viewer.catalog as HabboCatalog).roomPreviewer;
         if(_loc1_)
         {
            _loc1_.disableUpdate = true;
         }
      }
      
      public function onDragAndDropDone(param1:Boolean, param2:String) : void
      {
      }
   }
}

