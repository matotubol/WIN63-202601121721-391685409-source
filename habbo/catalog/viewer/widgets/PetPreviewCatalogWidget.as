package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.class_1857;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.PetColorResult;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class PetPreviewCatalogWidget extends CatalogWidget implements class_2612, class_1829
   {
      
      private var PET_TYPE_ID:int = 15;
      
      private var BREED:int = 1;
      
      private var COLOR:int = 16777215;
      
      private var PALETTE_ID:int = 2;
      
      private var PART_ID:int = -1;
      
      private var _productName:class_1741;
      
      private var var_1593:class_1741;
      
      private var var_181:class_2251;
      
      private var _previewOffset:Point;
      
      private var var_2911:int;
      
      protected var _gridItemLayout:XML;
      
      private var _catalog:HabboCatalog;
      
      private var var_758:class_1741;
      
      public function PetPreviewCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
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
         _productName = _window.findChildByName("ctlg_product_name");
         _productName.caption = "";
         var_1593 = _window.findChildByName("ctlg_description");
         var_1593.caption = "";
         var_181 = _window.findChildByName("ctlg_teaserimg_1") as class_2251;
         _previewOffset = new Point(var_181.x,var_181.y);
         var _loc1_:XmlAsset = page.viewer.catalog.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc1_.content as XML;
         var _loc2_:class_2198 = (page.viewer.catalog as HabboCatalog).roomEngine.getPetImage(PET_TYPE_ID,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0);
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_.data,true,new Point(0,0));
            var_2911 = _loc2_.id;
         }
         events.addEventListener("SELECT_PRODUCT",onPreviewProduct);
         return true;
      }
      
      private function onPreviewProduct(param1:SelectProductEvent) : void
      {
         var _loc30_:String = null;
         var _loc24_:String = null;
         if(param1 == null)
         {
            return;
         }
         var _loc7_:class_1793 = param1.offer;
         var _loc25_:class_1949 = page.viewer.catalog.getProductData(_loc7_.localizationId);
         if(_loc25_ != null)
         {
            _loc30_ = "${" + _loc25_.name + "}";
            _loc24_ = "${" + _loc25_.description + "}";
         }
         else
         {
            _loc30_ = "${" + _loc7_.localizationId + "}";
            _loc24_ = "${" + _loc7_.localizationId + "}";
         }
         _productName.caption = _loc30_;
         var_1593.caption = _loc24_;
         var_1593.y = _productName.y + _productName.height + 5;
         var_758 = _catalog.utils.showPriceOnProduct(param1.offer,_window,var_758,var_181,-6,true,6);
         var _loc20_:Point = new Point(0,0);
         var _loc28_:IRoomEngine = (page.viewer.catalog as HabboCatalog).roomEngine;
         switch(_loc7_.pricingModel)
         {
            case "pricing_model_single":
            case "pricing_model_multi":
               var _loc18_:class_1857 = _loc7_.product;
               var _loc11_:class_1800 = _loc18_.furnitureData;
               if(_loc11_ == null || null.customParams == null)
               {
                  class_21.log("[Pet Preview Catalog Widget] Unsupported product: " + null.productType);
                  break;
               }
               var _loc21_:String = null.customParams;
               var _loc2_:Array = _loc21_.split(" ");
               if(null.length < 1)
               {
                  class_21.log("[Pet Preview Catalog Widget] Invalid custom params: " + null.productType);
                  break;
               }
               var _loc29_:int = int(null[0]);
               var _loc15_:Array = [];
               switch(int(null.category) - 13)
               {
                  case 0:
                     if(null.length < 2)
                     {
                        class_21.log("[Pet Preview Catalog Widget] Invalid custom params: " + null.productType);
                        break;
                     }
                     var _loc13_:String = null[1];
                     var _loc6_:Array = _loc28_.getPetColorsByTag(0,null);
                     for each(var _loc3_ in null)
                     {
                        if(_loc3_.breed == BREED)
                        {
                           var _loc19_:int = int(_loc3_.id);
                           break;
                        }
                     }
                     switch(0 - 15)
                     {
                        case 0:
                           var _loc5_:int = 2;
                           var _loc17_:int = 3;
                           var _loc10_:PetColorResult = _loc28_.getPetDefaultPalette(0,"hair");
                           var _loc9_:PetColorResult = _loc28_.getPetDefaultPalette(0,"tail");
                           var _loc16_:int = -1;
                           var _loc27_:int = -1;
                           var _loc8_:PetCustomPart = new PetCustomPart(0,-1,0);
                           var _loc22_:PetCustomPart = new PetCustomPart(0,-1,0);
                           _loc15_ = [null,null];
                     }
                     var _loc4_:class_2198 = _loc28_.getPetImage(0,0,COLOR,new Vector3d(90),64,this,true,0,null);
                     break;
                  case 1:
                     if(null.length < 4)
                     {
                        class_21.log("[Pet Preview Catalog Widget] Invalid custom params: " + null.productType);
                        break;
                     }
                     var _loc14_:Array = (null[1] as String).split(",");
                     var _loc26_:Array = (null[2] as String).split(",");
                     var _loc12_:Array = (null[3] as String).split(",");
                     var _loc23_:int = 0;
                     while(0 < null.length)
                     {
                        null.push(new PetCustomPart(int(null[0]),int(null[0]),int(null[0])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(0,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,null);
                     break;
                  case 2:
                     if(null.length < 3)
                     {
                        class_21.log("[Pet Preview Catalog Widget] Invalid custom params: " + null.productType);
                        break;
                     }
                     _loc14_ = (null[1] as String).split(",");
                     _loc12_ = (null[2] as String).split(",");
                     _loc23_ = 0;
                     while(0 < null.length)
                     {
                        null.push(new PetCustomPart(int(null[0]),PART_ID,int(null[0])));
                        _loc23_++;
                     }
                     _loc4_ = _loc28_.getPetImage(0,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,null);
                     break;
                  case 3:
                     if(null.length < 4)
                     {
                        class_21.log("[Pet Preview Catalog Widget] Invalid custom params: " + null.productType);
                     }
                     null.push(new PetCustomPart(int(null[1]),int(null[2]),int(null[3])));
                     _loc4_ = _loc28_.getPetImage(0,PALETTE_ID,COLOR,new Vector3d(90),64,this,true,0,null);
                     break;
                  default:
                     class_21.log("[Pet Preview Catalog Widget] Unsupported Product Type: " + null.productType);
               }
               break;
            default:
               class_21.log("[Pet Preview Catalog Widget] Unknown pricing model" + _loc7_.pricingModel);
         }
         setPreviewImage(null,true,_loc20_);
         _window.invalidate();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed || page == null || page.offers == null)
         {
            return;
         }
         if(var_2911 == param1)
         {
            setPreviewImage(param2,true);
            var_2911 = 0;
         }
         else
         {
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
   }
}

