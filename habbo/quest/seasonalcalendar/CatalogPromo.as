package com.sulake.habbo.quest.seasonalcalendar
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.quest.HabboQuestEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.roomevents.Util;
   import com.sulake.habbo.session.product.class_1949;
   import com.sulake.habbo.session.product.class_59;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import package_10.class_2101;
   import package_10.class_2104;
   import package_10.class_3114;
   import package_13.class_2526;
   
   public class CatalogPromo implements class_13, class_1829, class_59
   {
      
      private var _questEngine:HabboQuestEngine;
      
      private var _window:class_1812;
      
      private var var_37:IConnection;
      
      private var var_30:MainWindow;
      
      private var var_1500:class_2104 = null;
      
      private var _offerId:int = -1;
      
      private var var_2228:int = -1;
      
      private var var_3631:class_3114 = null;
      
      private var var_1874:IMessageEvent = null;
      
      private var var_2028:IMessageEvent = null;
      
      public function CatalogPromo(param1:HabboQuestEngine, param2:MainWindow)
      {
         super();
         _questEngine = param1;
         var_30 = param2;
      }
      
      public function dispose() : void
      {
         if(var_37)
         {
            if(var_1874)
            {
               var_37.removeMessageEvent(var_1874);
               var_1874 = null;
            }
            if(var_2028)
            {
               var_37.removeMessageEvent(var_2028);
               var_2028 = null;
            }
            var_37 = null;
         }
         _questEngine = null;
      }
      
      public function get disposed() : Boolean
      {
         return _questEngine == null;
      }
      
      public function onActivityPoints(param1:int, param2:int) : void
      {
         if(param1 == getActivityPointType())
         {
            _questEngine.localization.registerParameter("quests.seasonalcalendar.promo.balance","amount","" + param2);
            if(_window != null)
            {
               refresh();
            }
         }
      }
      
      private function getActivityPointType() : int
      {
         var _loc1_:String = _questEngine.configuration.getProperty("seasonalQuestCalendar.currency");
         return isNaN(Number(_loc1_)) ? 0 : int(_loc1_);
      }
      
      public function prepare(param1:class_2250) : void
      {
         _window = class_1812(param1.findChildByName("catalog_promo_cont"));
         _window.findChildByName("buy_button").disable();
         _window.findChildByName("buy_button").procedure = onBuyButton;
         var_37 = _questEngine.communication.connection;
         if(var_37 != null)
         {
            var_1874 = new class_3114(onDailyOfferMessage);
            var_2028 = new class_2101(onCatalogPublished);
            var_37.addMessageEvent(var_1874);
            var_37.addMessageEvent(var_2028);
            var_37.send(new class_2526());
         }
      }
      
      public function refresh() : void
      {
         var _loc5_:String = null;
         var _loc2_:class_2198 = null;
         var _loc4_:ITextWindow = ITextWindow(_window.findChildByName("your_balance_txt"));
         var _loc1_:class_1812 = class_1812(_window.findChildByName("currency_icon_cont"));
         _loc1_.x = _loc4_.x + _loc4_.width;
         Util.hideChildren(_loc1_);
         var _loc3_:class_1741 = _loc1_.findChildByName("currency_icon_" + getActivityPointType());
         if(_loc3_ != null)
         {
            _loc3_.visible = true;
         }
         if(var_1500 != null)
         {
            _loc5_ = null;
            _loc2_ = null;
            if(var_1500.productType == "i")
            {
               _loc2_ = _questEngine.roomEngine.getWallItemImage(var_1500.furniClassId,new Vector3d(90,0,0),64,this,0,var_1500.extraParam);
            }
            else if(var_1500.productType == "s")
            {
               _loc2_ = _questEngine.roomEngine.getFurnitureImage(var_1500.furniClassId,new Vector3d(90,0,0),64,this);
            }
            if(_loc2_ != null && _loc2_.data != null)
            {
               setPromoFurniImage(_loc2_.data);
            }
         }
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         setPromoFurniImage(param2);
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function onBuyButton(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type == "WME_CLICK")
         {
            class_21.log("Buy button clicked");
            if(_offerId != -1)
            {
               _questEngine.catalog.openCatalogPageById(var_2228,_offerId,"NORMAL");
            }
         }
      }
      
      private function onDailyOfferMessage(param1:class_3114) : void
      {
         _window.findChildByName("buy_button").enable();
         var _loc2_:class_1949 = _questEngine.sessionDataManager.getProductData(param1.offer.localizationId);
         if(_loc2_ != null)
         {
            ITextWindow(_window.findChildByName("promo_info")).text = _loc2_.name;
            var_2228 = param1.pageId;
            _offerId = param1.offer.offerId;
            if(param1.offer.products.length > 0)
            {
               var_1500 = class_2104(param1.offer.products[0]);
               refresh();
            }
         }
         else if(var_3631 == null)
         {
            var_3631 = param1;
            _questEngine.sessionDataManager.addProductsReadyEventListener(this);
         }
      }
      
      public function productDataReady() : void
      {
         onDailyOfferMessage(var_3631);
      }
      
      private function setPromoFurniImage(param1:BitmapData) : void
      {
         var _loc5_:class_2251 = class_2251(_window.findChildByName("furni_preview"));
         var _loc2_:BitmapData = new BitmapData(_loc5_.width,_loc5_.height,true,0);
         var _loc3_:Rectangle = param1.rect;
         if(_loc3_.width > _loc2_.rect.width)
         {
            _loc3_.x = (_loc3_.width - _loc2_.rect.width) / 2;
            _loc3_.width = _loc2_.rect.width;
         }
         if(_loc3_.height > _loc2_.rect.height)
         {
            _loc3_.y = (_loc3_.height - _loc2_.rect.height) / 2;
            _loc3_.height = _loc2_.rect.height;
         }
         var _loc4_:Point = new Point(0,0);
         if(_loc2_.rect.width > _loc3_.width)
         {
            _loc4_.x = (_loc2_.rect.width - _loc3_.width) / 2;
         }
         if(_loc2_.rect.height > _loc3_.height)
         {
            _loc4_.y = (_loc2_.rect.height - _loc3_.height) / 2;
         }
         _loc2_.copyPixels(param1,_loc3_,_loc4_);
         _loc5_.bitmap = _loc2_;
      }
      
      private function onCatalogPublished(param1:IMessageEvent) : void
      {
         if(var_37 != null)
         {
            var_37.send(new class_2526());
         }
      }
   }
}

