package com.sulake.habbo.catalog.purchase
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import com.sulake.habbo.communication.messages.incoming.room.furniture.FurniRentOrBuyoutOfferMessageEvent;
   import com.sulake.habbo.communication.messages.parser.room.furniture.FurniRentOrBuyoutOfferMessageEventParser;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.GetRentOrBuyoutOfferMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutStripItemMessageComposer;
   import com.sulake.habbo.communication.messages.outgoing.room.furniture.ExtendRentOrBuyoutFurniMessageComposer;
   
   public class RentConfirmationWindow implements class_13, class_1829
   {
      
      private static const MODE_INFOSTAND:int = 1;
      
      private static const MODE_INVENTORY:int = 2;
      
      private static const MODE_CATALOGUE:int = 3;
      
      private var _disposed:Boolean;
      
      private var _offerMessageEvent:FurniRentOrBuyoutOfferMessageEvent;
      
      private var _window:class_1812;
      
      private var _isBuyout:Boolean;
      
      private var var_197:int = -1;
      
      private var _catalog:HabboCatalog;
      
      private var var_85:class_1800;
      
      private var var_261:int;
      
      private var var_3539:int = -1;
      
      private var var_4899:int;
      
      public function RentConfirmationWindow(param1:HabboCatalog)
      {
         super();
         _catalog = param1;
         _offerMessageEvent = new FurniRentOrBuyoutOfferMessageEvent(onFurniRentOrBuyoutOffer);
         _catalog.connection.addMessageEvent(_offerMessageEvent);
      }
      
      private function onFurniRentOrBuyoutOffer(param1:FurniRentOrBuyoutOfferMessageEvent) : void
      {
         if(var_85 == null)
         {
            return;
         }
         var _loc2_:FurniRentOrBuyoutOfferMessageEventParser = param1.getParser();
         if(var_85.fullName != _loc2_.furniTypeName)
         {
            return;
         }
         _isBuyout = _loc2_.buyout;
         if(_catalog.getPurse().credits < _loc2_.priceInCredits)
         {
            _catalog.showNotEnoughCreditsAlert();
            return;
         }
         if(_catalog.getPurse().getActivityPointsForType(_loc2_.activityPointType) < _loc2_.priceInActivityPoints)
         {
            _catalog.showNotEnoughActivityPointsAlert(_loc2_.activityPointType);
            return;
         }
         _window = _catalog.windowManager.buildFromXML(_catalog.assets.getAssetByName("rent_confirmation").content as XML) as class_1812;
         if(_loc2_.priceInCredits > 0)
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInCredits.toString();
            IStaticBitmapWrapperWindow(_window.findChildByName("price_type")).assetUri = "toolbar_credit_icon_0";
         }
         else
         {
            _window.findChildByName("price_amount").caption = _loc2_.priceInActivityPoints.toString();
         }
         if(_isBuyout)
         {
            _window.caption = "${rent.confirmation.title.buyout}";
            _window.findChildByName("rental_description").visible = false;
            _window.findChildByName("ok_button").caption = "${catalog.purchase_confirmation.buy}";
         }
         _window.findChildByName("furni_name").caption = var_85.localizedName;
         IItemListWindow(_window.findChildByName("content_list")).arrangeListItems();
         _window.center();
         _window.procedure = windowProcedure;
         switch(var_85.type)
         {
            case "s":
               var _loc3_:class_2198 = roomEngine.getFurnitureImage(var_85.id,new Vector3d(90,0,0),64,this);
               break;
            case "i":
               _loc3_ = roomEngine.getWallItemImage(var_85.id,new Vector3d(90,0,0),64,this);
         }
         class_2251(_window.findChildByName("image")).bitmap = null.data;
         var_197 = null.id;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         close();
         if(_offerMessageEvent != null)
         {
            _catalog.connection.removeMessageEvent(_offerMessageEvent);
            _offerMessageEvent = null;
         }
         _disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function show(param1:class_1800, param2:Boolean, param3:int = -1, param4:int = -1, param5:Boolean = false) : void
      {
         close();
         var_85 = param1;
         var_3539 = param3;
         var_4899 = param4;
         if(param5)
         {
            var_261 = 3;
         }
         else if(var_3539 > -1)
         {
            var_261 = 1;
         }
         else
         {
            var_261 = 2;
         }
         var _loc6_:* = param1.type == "i";
         _catalog.connection.send(new GetRentOrBuyoutOfferMessageComposer(_loc6_,param1.fullName,param2));
      }
      
      private function get roomEngine() : IRoomEngine
      {
         return _catalog.roomEngine;
      }
      
      private function windowProcedure(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK" || _window == null)
         {
            return;
         }
         switch(param2.name)
         {
            case "cancel_button":
            case "header_button_close":
               close();
               break;
            case "ok_button":
               switch(var_261 - 1)
               {
                  case 0:
                     _catalog.connection.send(new ExtendRentOrBuyoutFurniMessageComposer(var_85.type == "i",var_3539,_isBuyout));
                     break;
                  case 1:
                     _catalog.connection.send(new ExtendRentOrBuyoutStripItemMessageComposer(var_4899,_isBuyout));
                     break;
                  case 2:
                     _catalog.purchaseOffer(var_85.rentOfferId);
               }
               close();
         }
      }
      
      private function close() : void
      {
         if(_window == null)
         {
            return;
         }
         _window.dispose();
         _window = null;
         var_197 = -1;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         if(_window != null && param1 == var_197)
         {
            class_2251(_window.findChildByName("image")).bitmap = param2;
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
   }
}

