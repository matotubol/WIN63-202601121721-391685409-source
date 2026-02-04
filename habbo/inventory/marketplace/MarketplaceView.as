package com.sulake.habbo.inventory.marketplace
{
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   import com.sulake.core.window.utils.class_2001;
   import com.sulake.habbo.inventory.HabboInventory;
   import com.sulake.habbo.inventory.items.FurnitureItem;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class MarketplaceView implements class_1829
   {
      
      private var _windowManager:class_38;
      
      private var var_909:class_40;
      
      private var var_18:class_2250;
      
      private var var_36:MarketplaceModel;
      
      private var _roomEngine:IRoomEngine;
      
      private var _localization:class_27;
      
      private var _disposed:Boolean = false;
      
      private var var_5142:int;
      
      private var var_3449:int;
      
      private var _furniName:String;
      
      private var var_5037:HabboInventory;
      
      public function MarketplaceView(param1:MarketplaceModel, param2:class_38, param3:class_40, param4:IRoomEngine, param5:class_27, param6:HabboInventory)
      {
         super();
         var_36 = param1;
         var_909 = param3;
         _windowManager = param2;
         _roomEngine = param4;
         _localization = param5;
         var_5037 = param6;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_36 = null;
            var_909 = null;
            _windowManager = null;
            _roomEngine = null;
            _localization = null;
            disposeView();
            _disposed = true;
         }
      }
      
      private function disposeView() : void
      {
         if(var_18 != null)
         {
            var_18.dispose();
            var_18 = null;
         }
      }
      
      public function showBuyTokens(param1:int, param2:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","price",param1.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","count",param2.toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.info","free",(param2 - 1).toString());
            _localization.registerParameter("inventory.marketplace.buy_tokens.buy","price",param1.toString());
         }
         var_18 = createWindow("buy_marketplace_tokens_xml") as class_2250;
         if(var_18 == null)
         {
            return;
         }
         var_18.procedure = clickHandler;
         var_18.center();
      }
      
      public function showMakeOffer(param1:FurnitureItem) : void
      {
         if(!param1 || !_localization || !_roomEngine || !var_36)
         {
            return;
         }
         var_18 = createWindow("make_marketplace_offer_xml") as class_2250;
         if(!var_18)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = var_18.findChildByName("price_input") as ITextFieldWindow;
         if(_loc2_ != null)
         {
            _loc2_.restrict = "0-9";
         }
         checkPrice();
         _localization.registerParameter("inventory.marketplace.make_offer.expiration_info","time",var_36.expirationHours.toString());
         _localization.registerParameter("inventory.marketplace.make_offer.min_price","minprice",var_36.offerMinPrice.toString());
         _localization.registerParameter("inventory.marketplace.make_offer.max_price","maxprice",var_36.offerMaxPrice.toString());
         var _loc6_:Number = 4293848814;
         if(!param1.isWallItem)
         {
            var _loc8_:class_2198 = _roomEngine.getFurnitureImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,String(param1.extra));
         }
         else
         {
            _loc8_ = _roomEngine.getWallItemImage(param1.type,new Vector3d(90,0,0),64,this,_loc6_,param1.stuffData.getLegacyString());
         }
      }
      
      private function setFurniImage(param1:BitmapData) : void
      {
         if(param1 == null || var_18 == null)
         {
            return;
         }
         var _loc5_:class_2251 = var_18.findChildByName("furni_image") as class_2251;
         if(_loc5_ == null)
         {
            return;
         }
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:int = (_loc2_.width - param1.width) * 0.5;
         var _loc4_:int = (_loc2_.height - param1.height) * 0.5;
         _loc2_.draw(param1,new Matrix(1,0,0,1,_loc3_,_loc4_));
         _loc5_.bitmap = _loc2_;
      }
      
      private function setText(param1:String, param2:String) : void
      {
         if(var_18 == null)
         {
            return;
         }
         var _loc3_:ITextWindow = var_18.findChildByName(param1) as ITextWindow;
         if(_loc3_ == null)
         {
            return;
         }
         _loc3_.text = param2;
      }
      
      public function showNoCredits(param1:int) : void
      {
         if(_localization)
         {
            _localization.registerParameter("inventory.marketplace.no_credits.info","price",param1.toString());
         }
         var_18 = createWindow("marketplace_no_credits_xml") as class_2250;
         if(var_18 == null)
         {
            return;
         }
         var_18.procedure = clickHandler;
         var_18.center();
      }
      
      private function showConfirmation() : void
      {
         _localization.registerParameter("inventory.marketplace.confirm_offer.info","furniname",_furniName);
         _localization.registerParameter("inventory.marketplace.confirm_offer.info","price",calculateFinalPrice(var_3449).toString());
         _windowManager.confirm("${inventory.marketplace.confirm_offer.title}","${inventory.marketplace.confirm_offer.info}",0,confirmationCallback);
      }
      
      private function confirmationCallback(param1:class_2001, param2:class_1758) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param1.dispose();
         if(var_36 == null)
         {
            return;
         }
         if(param2.type == "WE_OK")
         {
            var_36.makeOffer(var_3449);
         }
         var_36.releaseItem();
      }
      
      private function createWindow(param1:String) : class_1741
      {
         if(var_909 == null || _windowManager == null)
         {
            return null;
         }
         var _loc2_:XmlAsset = var_909.getAssetByName(param1) as XmlAsset;
         if(_loc2_ == null)
         {
            return null;
         }
         return _windowManager.buildFromXML(_loc2_.content as XML);
      }
      
      private function clickHandler(param1:class_1758, param2:class_1741) : void
      {
         var _loc3_:ITextFieldWindow = null;
         if(param1.type == "WME_CLICK")
         {
            switch(param2.name)
            {
               case "buy_tokens_button":
                  var_36.buyMarketplaceTokens();
                  disposeView();
                  break;
               case "cancel_buy_tokens_button":
               case "cancel_make_offer_button":
               case "cancel_no_credits_button":
               case "header_button_close":
                  var_36.releaseItem();
                  disposeView();
                  break;
               case "make_offer_button":
                  _loc3_ = var_18.findChildByName("price_input") as ITextFieldWindow;
                  if(_loc3_ != null)
                  {
                     var_3449 = parseInt(_loc3_.text);
                     showConfirmation();
                  }
                  disposeView();
                  break;
               case "get_credits_button":
                  var_36.releaseItem();
                  openCreditsPage();
                  disposeView();
            }
         }
         if(param1.type == "WE_CHANGE")
         {
            if(param2.name == "price_input")
            {
               checkPrice();
            }
         }
      }
      
      private function openCreditsPage() : void
      {
         HabboWebTools.openWebPageAndMinimizeClient(var_5037.getProperty("web.shop.relativeUrl"));
      }
      
      private function calculateFinalPrice(param1:int) : int
      {
         var _loc2_:int = Math.ceil(Math.round(1000 * (param1 * (var_36.sellingFeePercentage / 100 + 0.5 * param1 / var_36.halfTaxLimit))) / 1000);
         return param1 - _loc2_;
      }
      
      private function checkPrice() : void
      {
         if(var_18 == null)
         {
            return;
         }
         var _loc2_:ITextFieldWindow = var_18.findChildByName("price_input") as ITextFieldWindow;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = parseInt(_loc2_.text);
         if(_loc3_ > var_36.offerMaxPrice)
         {
            _loc2_.text = var_36.offerMaxPrice.toString();
            _loc3_ = var_36.offerMaxPrice;
         }
         var _loc4_:int = calculateFinalPrice(_loc3_);
         var _loc1_:class_1775 = var_18.findChildByName("make_offer_button") as class_1775;
         var _loc5_:ITextWindow = var_18.findChildByName("final_price") as ITextWindow;
         if(_loc1_ == null || _loc5_ == null)
         {
            return;
         }
         if(_loc3_ < var_36.offerMinPrice)
         {
            _localization.registerParameter("shop.marketplace.invalid.price","minPrice",var_36.offerMinPrice.toString());
            _localization.registerParameter("shop.marketplace.invalid.price","maxPrice",var_36.offerMaxPrice.toString());
            _loc5_.text = "${shop.marketplace.invalid.price}";
            _loc1_.disable();
         }
         else
         {
            _loc5_.text = _localization.getLocalization("sell.in.marketplace.revenue.label") + ": " + _loc4_;
            _loc1_.enable();
         }
      }
      
      public function showResult(param1:int) : void
      {
         var _loc2_:String = null;
         if(param1 == 1)
         {
            _loc2_ = "${inventory.marketplace.result.title.success}";
         }
         else
         {
            _loc2_ = "${inventory.marketplace.result.title.failure}";
         }
         var _loc3_:String = "${inventory.marketplace.result." + param1 + "}";
         _windowManager.alert(_loc2_,_loc3_,0,closeAlert);
      }
      
      private function closeAlert(param1:class_1750, param2:class_1758) : void
      {
         if(param1 == null)
         {
            return;
         }
         var_36.releaseItem();
         param1.dispose();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(var_5142 == param1)
         {
            setFurniImage(param2);
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function showAlert(param1:String, param2:String) : void
      {
         _windowManager.alert(param1,param2,0,closeAlert);
      }
      
      public function updateAveragePrice(param1:int, param2:int) : void
      {
         if(!var_18 || !_localization || !var_36)
         {
            return;
         }
         var _loc3_:ITextWindow = var_18.findChildByName("average_price") as ITextWindow;
         if(!_loc3_)
         {
            return;
         }
         var _loc6_:int = Math.floor(param1 / (1 + var_36.commission * 0.01));
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","days",param2.toString());
         var _loc4_:String = param1 == 0 ? " - " : param1.toString();
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","price",_loc4_);
         var _loc5_:String = _loc6_ == 0 ? " - " : _loc6_.toString();
         _localization.registerParameter("inventory.marketplace.make_offer.average_price","price_no_commission",_loc5_);
         _loc3_.visible = true;
      }
   }
}

