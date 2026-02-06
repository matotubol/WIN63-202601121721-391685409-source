package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_2261;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.catalog.purchase.RoomAdPurchaseData;
   import com.sulake.habbo.catalog.viewer.Offer;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetEvent;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.room.events.RoomEngineEvent;
   import com.sulake.room.utils.RoomId;
   import com.sulake.habbo.communication.messages.incoming.catalog.RoomAdPurchaseInfoEvent;
   import com.sulake.habbo.communication.messages.incoming.users.class_2794;
   import com.sulake.habbo.communication.messages.incoming.navigator.class_2482;
   import com.sulake.habbo.communication.messages.parser.catalog.RoomAdPurchaseInfoEventParser;
   
   public class RoomAdsCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var _catalog:HabboCatalog;
      
      private var var_1683:IMessageEvent = null;
      
      private var _name:String;
      
      private var var_735:String;
      
      private var _rooms:Array;
      
      private var var_3598:Boolean;
      
      private var var_1065:class_2261;
      
      public function RoomAdsCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         if(_catalog == null)
         {
            return false;
         }
         var _loc4_:IConnection = _catalog.connection;
         if(var_1683 == null)
         {
            var_1683 = new RoomAdPurchaseInfoEvent(onPurchaseInfoEvent);
            _loc4_.addMessageEvent(var_1683);
         }
         _catalog.getRoomAdsPurchaseInfo();
         window.findChildByName("name_input_text").addEventListener("WE_CHANGE",onNameWindowEvent);
         window.findChildByName("desc_input_text").addEventListener("WE_CHANGE",onDescWindowEvent);
         events.addEventListener("PURCHASE",onPurchaseConfirmationEvent);
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         var _loc3_:int = _catalog.getInteger("room_ad.duration.minutes",120);
         var _loc1_:int = getExtensionMinutes(_loc2_,_loc3_);
         _catalog.localization.registerParameter("roomad.catalog_text","duration",String(_loc1_));
         _catalog.roomEngine.events.addEventListener("REE_INITIALIZED",onRoomInitialized);
         populateEventCategories();
         return true;
      }
      
      private function getExtensionMinutes(param1:RoomAdPurchaseData, param2:int) : int
      {
         var _loc6_:Boolean = _catalog.getBoolean("roomad.limited_extension");
         if(!_loc6_ || param1 == null || param1.expirationTime == null)
         {
            return param2;
         }
         var _loc8_:Date = new Date();
         var _loc3_:Number = Number(_loc8_.getTime());
         var _loc7_:Number = Number(param1.expirationTime.getTime());
         var _loc5_:Number = _loc3_ - _loc7_;
         var _loc4_:Number = _loc5_ / 60000;
         return _loc4_ + param2;
      }
      
      private function populateEventCategories() : void
      {
         if(window == null)
         {
            return;
         }
         var_1065 = window.findChildByName("categories_list") as class_2261;
         var _loc2_:Array = [];
         for each(var _loc1_ in _catalog.navigator.visibleEventCategories)
         {
            _loc2_.push("${navigator.searchcode.title.eventcategory__" + _loc1_.categoryId + "}");
         }
         var_1065.populate(_loc2_);
         var_1065.selection = 0;
         var_1065.addEventListener("WE_SELECTED",onEventCategoryMenuEvent);
      }
      
      private function onRoomInitialized(param1:RoomEngineEvent) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(!RoomId.isRoomPreviewerId(param1.roomId))
         {
            setDefaultRoom(param1.roomId,false);
         }
      }
      
      private function setDefaultRoom(param1:int, param2:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc3_:class_2794 = null;
         var _loc9_:String = null;
         if(window == null)
         {
            return;
         }
         var _loc8_:class_2261 = window.findChildByName("room_drop_menu") as class_2261;
         if(_rooms == null)
         {
            if(_loc8_.numMenuItems > 0)
            {
               _loc8_.selection = 0;
            }
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _rooms.length)
         {
            _loc3_ = _rooms[_loc6_] as class_2794;
            if(param2)
            {
               if(_loc3_.roomName.length > 25)
               {
                  _loc9_ = _loc3_.roomName.substr(0,25) + "...";
                  _loc4_.push(_loc9_);
               }
               else
               {
                  _loc4_.push(_loc3_.roomName);
               }
            }
            if(_loc3_.roomId == param1)
            {
               _loc5_ = _loc6_;
            }
            _loc6_++;
         }
         if(param2)
         {
            if(_loc4_.length == 0)
            {
               _loc4_.push(_catalog.localization.getLocalization("roomad.no.available.room","roomad.no.available.room"));
            }
            _loc8_.populate(_loc4_);
         }
         var _loc10_:class_2794 = _rooms[_loc5_] as class_2794;
         if(_loc10_ != null)
         {
            _loc8_.selection = _loc5_;
            var _loc7_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if(_loc7_ == null)
            {
               _loc7_ = new RoomAdPurchaseData();
               _catalog.roomAdPurchaseData = null;
            }
            null.flatId = _loc10_.roomId;
         }
         else
         {
            _loc8_.selection = 0;
         }
      }
      
      private function setExtendData() : void
      {
         var _loc1_:class_2794 = null;
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null && _loc2_.extended)
         {
            window.findChildByName("name_input_text").caption = _loc2_.name;
            window.findChildByName("desc_input_text").caption = _loc2_.description;
            _loc1_ = new class_2794(_loc2_.flatId,_loc2_.roomName,false);
            if(_rooms != null)
            {
               _rooms.push(_loc1_);
            }
            if(var_1065 == null)
            {
               var_1065 = window.findChildByName("categories_list") as class_2261;
            }
            var_1065.selection = _loc2_.categoryId - 1;
         }
      }
      
      public function onPurchaseInfoEvent(param1:IMessageEvent) : void
      {
         if(!window || Boolean(window.disposed))
         {
            return;
         }
         var _loc7_:RoomAdPurchaseInfoEvent = param1 as RoomAdPurchaseInfoEvent;
         var _loc3_:RoomAdPurchaseInfoEventParser = _loc7_.getParser();
         var _loc6_:class_2261 = window.findChildByName("room_drop_menu") as class_2261;
         _rooms = _loc3_.rooms;
         var_3598 = _loc3_.isVip;
         var _loc8_:int = _catalog.roomEngine.activeRoomId;
         setExtendData();
         populateEventCategories();
         setDefaultRoom(_loc8_,true);
         var _loc2_:class_1793 = selectedOffer();
         if(_loc2_ != null)
         {
            events.dispatchEvent(new SelectProductEvent(_loc2_));
            var _loc5_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
            if(_loc5_ == null)
            {
               _loc5_ = new RoomAdPurchaseData();
               _catalog.roomAdPurchaseData = null;
            }
            null.offerId = _loc2_.offerId;
            _catalog.roomAdPurchaseData = null;
            var _loc4_:class_1812 = window.findChildByName("price_container") as class_1812;
            _catalog.utils.showPriceInContainer(null,_loc2_);
         }
      }
      
      private function onPurchaseConfirmationEvent(param1:CatalogWidgetEvent) : void
      {
         _catalog.getRoomAdsPurchaseInfo();
         window.findChildByName("name_input_text").caption = "";
         window.findChildByName("desc_input_text").caption = "";
         if(_catalog.roomAdPurchaseData)
         {
            _catalog.roomAdPurchaseData.clear();
         }
      }
      
      private function onNameWindowEvent(param1:class_1758) : void
      {
         var _loc3_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null)
         {
            _loc2_.name = _loc3_.text;
         }
      }
      
      private function onDescWindowEvent(param1:class_1758) : void
      {
         var _loc3_:ITextFieldWindow = param1.target as ITextFieldWindow;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc2_ != null)
         {
            _loc2_.description = _loc3_.text;
         }
      }
      
      private function onRoomDropMenuEvent(param1:class_1758, param2:class_1741) : void
      {
         var _loc5_:int = 0;
         var _loc4_:class_2794 = null;
         var _loc6_:RoomAdPurchaseData = null;
         var _loc3_:int = 0;
         var _loc7_:class_1741 = null;
         var _loc8_:String = null;
         if(param1.type == "WE_SELECTED" && _rooms.length > 0)
         {
            _loc5_ = int(class_2261(param2).selection);
            _loc4_ = _rooms[_loc5_] as class_2794;
            _loc6_ = _catalog.roomAdPurchaseData;
            if(_loc6_)
            {
               _loc6_.flatId = _loc4_.roomId;
               _loc3_ = _catalog.getInteger("room_ad.duration.minutes",120);
               if(_loc4_.roomId == _loc6_.extendedFlatId)
               {
                  _loc3_ = getExtensionMinutes(_loc6_,_loc3_);
               }
               _loc7_ = window.findChildByName("ctlg_text_1");
               _loc7_.caption = "${roomad.catalog_text}";
               _catalog.localization.registerParameter("roomad.catalog_text","duration",String(_loc3_));
               _loc8_ = _catalog.localization.getLocalization("roomad.catalog_text");
               _loc7_.caption = _loc8_;
            }
         }
      }
      
      private function onEventCategoryMenuEvent(param1:class_1758) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = var_1065.selection;
         for each(var _loc2_ in _catalog.navigator.visibleEventCategories)
         {
            if(_loc2_.visible)
            {
               if(_loc6_ == _loc3_)
               {
                  var _loc5_:int = _loc2_.categoryId;
                  break;
               }
               _loc3_++;
            }
         }
         var _loc4_:RoomAdPurchaseData = _catalog.roomAdPurchaseData;
         if(_loc4_)
         {
            _loc4_.categoryId = -1;
         }
      }
      
      private function selectedOffer() : class_1793
      {
         var _loc3_:int = 0;
         var _loc2_:Offer = null;
         var _loc1_:Vector.<class_1793> = page.offers;
         if(_loc1_ != null && _loc1_)
         {
            if(_loc1_.length == 1)
            {
               return _loc1_[0];
            }
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               _loc2_ = _loc1_[_loc3_] as Offer;
               if(_loc2_.clubLevel == 2 && var_3598 || _loc2_.clubLevel != 2 && !var_3598)
               {
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:IConnection = null;
         super.dispose();
         if(_catalog != null)
         {
            _loc1_ = _catalog.connection;
            if(var_1683 != null)
            {
               _loc1_.removeMessageEvent(var_1683);
               var_1683 = null;
            }
            _catalog.roomEngine.events.removeEventListener("REE_INITIALIZED",onRoomInitialized);
            _catalog = null;
         }
      }
   }
}

