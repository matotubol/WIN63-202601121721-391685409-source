package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.habbo.avatar.pets.PetCustomPart;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetApproveNameResultEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetColourIndexEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetMultiColoursEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetPurchaseOverrideEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSellablePetPalettesEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.PetColorResult;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import package_6.class_2908;
   
   public class NewPetsCatalogWidget extends CatalogWidget implements class_2612, class_1829
   {
      
      private static const MAX_PALETTES:int = 20;
      
      private static const NORMAL_SIZE_PETS:Array = [15];
      
      private var _offers:class_55;
      
      private var var_33:class_1741;
      
      private var var_420:int = -1;
      
      private var var_623:int = -1;
      
      private var var_4112:String;
      
      private var var_1087:Boolean = false;
      
      private var var_1134:Boolean = false;
      
      private var var_290:Array = null;
      
      private var _catalog:HabboCatalog;
      
      private var var_758:class_1741;
      
      private var var_4272:int = -1;
      
      public function NewPetsCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(var_1134)
         {
            return;
         }
         var_1087 = false;
         if(_offers != null)
         {
            _offers.dispose();
            _offers = null;
         }
         var_290 = null;
         _catalog = null;
         var_758 = null;
         super.dispose();
         var_1134 = true;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_1087 = false;
         var_33 = window.findChildByName("name_input_text");
         if(var_33 == null)
         {
            return false;
         }
         var_33.caption = "";
         _offers = new class_55();
         if(page.offers.length == 0)
         {
            return false;
         }
         var _loc1_:class_1793 = page.offers[0];
         var_420 = getPetTypeIndexFromProduct(_loc1_.localizationId);
         if(var_420 < 8)
         {
            return false;
         }
         var_4112 = _loc1_.localizationId;
         updateAvailablePalettes(_loc1_.localizationId);
         if(var_290 != null && var_290.length > 0)
         {
            var_623 = 0;
         }
         else
         {
            var_623 = -1;
         }
         _offers.add(var_420,_loc1_);
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         events.addEventListener("COLOUR_INDEX",onColourIndex);
         events.addEventListener("CWE_APPROVE_RESULT",onApproveNameResult);
         events.addEventListener("WIDGETS_INITIALIZED",onWidgetsInitialized);
         events.addEventListener("SELLABLE_PET_PALETTES",onSellablePetPalettes);
         return true;
      }
      
      private function onWidgetsInitialized(param1:CatalogWidgetEvent = null) : void
      {
         if(var_1134)
         {
            return;
         }
         events.dispatchEvent(new CatalogWidgetPurchaseOverrideEvent(onPurchase));
         var _loc2_:class_1793 = _offers.getWithIndex(0);
         if(_loc2_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc2_));
         }
         initializePaletteSelection();
      }
      
      private function initializePaletteSelection() : void
      {
         var _loc4_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:class_2908 = null;
         var _loc3_:PetColorResult = null;
         if(var_290 != null)
         {
            _loc4_ = [];
            _loc2_ = 0;
            while(_loc2_ < 20 && _loc2_ < var_290.length)
            {
               _loc1_ = var_290[_loc2_];
               _loc3_ = _catalog.roomEngine.getPetColor(var_420,_loc1_.paletteId);
               if(_loc3_ != null)
               {
                  if(_loc3_.primaryColor == _loc3_.secondaryColor)
                  {
                     _loc4_.push([_loc3_.primaryColor]);
                  }
                  else
                  {
                     _loc4_.push([_loc3_.primaryColor,_loc3_.secondaryColor]);
                  }
               }
               _loc2_++;
            }
            events.dispatchEvent(new CatalogWidgetMultiColoursEvent(_loc4_,"ctlg_clr_27x22_1","ctlg_clr_27x22_2","ctlg_clr_27x22_3"));
         }
      }
      
      private function onColourIndex(param1:CatalogWidgetColourIndexEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = param1.index;
         selectedPalette(_loc2_);
      }
      
      private function selectedPalette(param1:int) : void
      {
         if(var_290 != null && var_290.length > 0)
         {
            if(param1 < 0 || param1 > var_290.length)
            {
               param1 = 0;
            }
            var_623 = param1;
            updateImage();
         }
      }
      
      private function getPetLocalization() : String
      {
         var _loc1_:class_2908 = null;
         if(var_623 < 0)
         {
            return "";
         }
         if(page != null && page.viewer != null)
         {
            if(_catalog != null && _catalog.localization != null)
            {
               _loc1_ = var_290[var_623] as class_2908;
               return _catalog.localization.getLocalization(getRaceLocalizationKey(var_420,_loc1_.breedId),getRaceLocalizationKey(var_420,_loc1_.breedId));
            }
         }
         _loc1_ = var_290[var_623];
         return getRaceLocalizationKey(var_420,_loc1_.breedId);
      }
      
      private function onPurchase(param1:class_1758) : void
      {
         if(var_1087)
         {
            class_21.log("* Cannot buy a pet, pending previous name approval.");
         }
         if(getPurchaseParameters() == "")
         {
            return;
         }
         var _loc2_:String = var_33.caption;
         var_1087 = true;
         _catalog.approveName(_loc2_,1);
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         updateImage();
      }
      
      private function onApproveNameResult(param1:CatalogWidgetApproveNameResultEvent) : void
      {
         var nameValidationInfo:String;
         var extraParameter:String;
         var event:CatalogWidgetApproveNameResultEvent = param1;
         if(event == null || !var_1087)
         {
            return;
         }
         var_1087 = false;
         nameValidationInfo = event.nameValidationInfo;
         if(event.result != 0)
         {
            _catalog.purchaseWillBeGift(false);
         }
         switch(event.result - 1)
         {
            case 0:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("long",nameValidationInfo),0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               return;
            case 1:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("short",nameValidationInfo),0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               return;
            case 2:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("chars",nameValidationInfo),0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               return;
            case 3:
               _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}",constructErrorMessage("bobba",nameValidationInfo),0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
               return;
            default:
               extraParameter = getPurchaseParameters();
               if(extraParameter == "")
               {
                  class_21.log("* Not enough information to buy a pet!");
                  return;
               }
               class_21.log("* Will buy pet as " + extraParameter);
               _catalog.showPurchaseConfirmation(_offers.getWithIndex(0),page.pageId,extraParameter,1,null,null,true,getPetImage());
               return;
         }
      }
      
      private function constructErrorMessage(param1:String, param2:String) : String
      {
         var _loc4_:class_27 = _catalog.localization;
         var _loc3_:String = "catalog.alert.petname." + param1;
         var _loc6_:String = _loc3_ + ".additionalInfo";
         _loc4_.registerParameter(_loc6_,"additional_info",param2);
         var _loc7_:String = _loc4_.getLocalization(_loc3_);
         var _loc5_:String = _loc4_.getLocalization(_loc6_);
         if(param2 != null && param2.length > 0 && _loc5_ != null && _loc5_.length > 0)
         {
            _loc7_ = _loc5_;
         }
         return _loc7_;
      }
      
      private function onSellablePetPalettes(param1:CatalogWidgetSellablePetPalettesEvent) : void
      {
         if(param1.productCode == var_4112)
         {
            var_290 = parseSellablePalettes(param1.sellablePalettes);
            initializePaletteSelection();
            selectedPalette(0);
            updateImage();
         }
      }
      
      private function parseSellablePalettes(param1:Array) : Array
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:Array = [];
         for each(var _loc3_ in param1)
         {
            if(_loc3_.type == var_420 && _loc3_.sellable)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function getPetImage() : BitmapData
      {
         var _loc10_:class_1793 = _offers.getWithIndex(0);
         if(_loc10_ == null || var_623 < 0)
         {
            return null;
         }
         var _loc6_:int = var_420;
         var _loc3_:class_2908 = var_290[var_623];
         var _loc7_:int = _loc3_.paletteId;
         var _loc16_:IRoomEngine = _catalog.roomEngine;
         var _loc8_:* = NORMAL_SIZE_PETS.indexOf(_loc6_) == -1;
         var _loc18_:Vector3d = _loc8_ ? new Vector3d(135) : new Vector3d(90);
         var _loc17_:Array = [];
         switch(_loc6_ - 15)
         {
            case 0:
               var _loc4_:int = _loc16_.getPetLayerIdForTag(_loc6_,"hair");
               var _loc2_:int = _loc16_.getPetLayerIdForTag(_loc6_,"tail");
               var _loc13_:PetColorResult = _loc16_.getPetDefaultPalette(_loc6_,"hair");
               var _loc12_:PetColorResult = _loc16_.getPetDefaultPalette(_loc6_,"tail");
               var _loc1_:int = -1;
               var _loc14_:int = -1;
               var _loc11_:PetCustomPart = new PetCustomPart(0,-1,0);
               var _loc5_:PetCustomPart = new PetCustomPart(0,-1,0);
               _loc17_ = [null,null];
         }
         var _loc15_:class_2198 = _loc16_.getPetImage(_loc6_,_loc7_,16777215,_loc18_,64,this,true,0,_loc17_);
         if(_loc15_ != null)
         {
            var_4272 = _loc15_.id;
            return _loc15_.data;
         }
         return null;
      }
      
      private function updateImage() : void
      {
         var _loc1_:class_1793 = _offers.getWithIndex(0);
         if(_loc1_ == null || var_623 < 0)
         {
            return;
         }
         var _loc2_:BitmapData = getPetImage();
         if(_loc2_ != null)
         {
            setPreviewImage(_loc2_,true);
         }
         var _loc4_:class_1741 = window.findChildByName("ctlg_teaserimg_1");
         var_758 = _catalog.utils.showPriceOnProduct(_loc1_,_window,var_758,_loc4_,-6,false,6);
         var _loc3_:class_1741 = _window.findChildByName("pet_breed_text");
         if(_loc3_)
         {
            _loc3_.caption = getPetLocalization();
         }
      }
      
      private function getPurchaseParameters() : String
      {
         var color:uint;
         var data:class_2908;
         var p:String;
         var name:String = var_33.caption;
         if(name == null || name.length == 0)
         {
            _catalog.windowManager.alert("${catalog.alert.purchaseerror.title}","${catalog.alert.petname.empty}",0,function(param1:class_1750, param2:class_1758):void
            {
               param1.dispose();
            });
            return "";
         }
         if(var_623 < 0)
         {
            return "";
         }
         color = 16777215;
         data = var_290[var_623];
         p = name + String.fromCharCode(10) + data.paletteId + String.fromCharCode(10) + addZeroPadding(color.toString(16).toUpperCase(),6);
         return p;
      }
      
      private function setPreviewImage(param1:BitmapData, param2:Boolean) : void
      {
         var _loc6_:class_2251 = null;
         var _loc5_:int = 0;
         var _loc3_:BitmapData = null;
         var _loc4_:Point = null;
         if(!window.disposed)
         {
            if(param1 == null)
            {
               param1 = new BitmapData(1,1);
               param2 = true;
            }
            _loc6_ = window.findChildByName("ctlg_teaserimg_1") as class_2251;
            if(_loc6_ != null)
            {
               if(_loc6_.bitmap == null)
               {
                  _loc6_.bitmap = new BitmapData(_loc6_.width,_loc6_.height,true,16777215);
               }
               _loc6_.bitmap.fillRect(_loc6_.bitmap.rect,16777215);
               _loc5_ = 1;
               if(NORMAL_SIZE_PETS.indexOf(var_420) == -1)
               {
                  _loc5_ = 2;
               }
               _loc3_ = new BitmapData(param1.width * _loc5_,param1.height * _loc5_,true,16777215);
               _loc3_.draw(param1,new Matrix(_loc5_,0,0,_loc5_));
               _loc4_ = new Point((_loc6_.width - _loc3_.width) / 2,(_loc6_.height - _loc3_.height) / 2);
               _loc6_.bitmap.copyPixels(_loc3_,_loc3_.rect,_loc4_,null,null,true);
               _loc6_.invalidate();
               _loc3_.dispose();
            }
         }
         if(param2)
         {
            param1.dispose();
         }
      }
      
      private function getPetTypeIndexFromProduct(param1:String) : int
      {
         if(param1.length == 0)
         {
            return 0;
         }
         var _loc2_:int = 0;
         _loc2_ = param1.length - 1;
         while(_loc2_ >= 0)
         {
            if(isNaN(parseInt(param1.charAt(_loc2_))))
            {
               break;
            }
            _loc2_--;
         }
         if(_loc2_ > 0)
         {
            return int(param1.substring(_loc2_ + 1));
         }
         return -1;
      }
      
      private function getRaceLocalizationKey(param1:int, param2:int) : String
      {
         return "pet.breed." + param1 + "." + param2;
      }
      
      private function addZeroPadding(param1:String, param2:int) : String
      {
         while(param1.length < param2)
         {
            param1 = "0" + param1;
         }
         return param1;
      }
      
      private function updateAvailablePalettes(param1:String) : void
      {
         if(var_290 == null)
         {
            var _loc2_:Array = _catalog.getSellablePetPalettes(param1);
            var_290 = parseSellablePalettes(null);
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(disposed)
         {
            return;
         }
         if(param1 == var_4272)
         {
            setPreviewImage(param2,true);
            onWidgetsInitialized();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

