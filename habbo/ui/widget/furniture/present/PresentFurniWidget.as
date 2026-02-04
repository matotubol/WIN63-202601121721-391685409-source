package com.sulake.habbo.ui.widget.furniture.present
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.communication.connection.IConnection;
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.class_16;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemListWindow;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.avatar.class_1827;
   import com.sulake.habbo.avatar.class_259;
   import com.sulake.habbo.avatar.class_48;
   import com.sulake.habbo.catalog.IHabboCatalog;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.inventory.items.class_1875;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.class_2146;
   import com.sulake.habbo.session.furniture.class_1800;
   import com.sulake.habbo.tracking.HabboTracking;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.handler.FurniturePresentWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetPresentOpenMessage;
   import com.sulake.habbo.window.class_38;
   import com.sulake.room.object.IRoomObject;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import package_9.class_3556;
   
   public class PresentFurniWidget extends RoomWidgetBase implements class_259
   {
      
      private static const const_75:String = "floor";
      
      private static const TYPE_WALLPAPER:String = "wallpaper";
      
      private static const TYPE_LANDSCAPE:String = "landscape";
      
      private var var_3365:class_16;
      
      private var _catalog:IHabboCatalog;
      
      private var _inventory:class_61;
      
      private var _roomEngine:IRoomEngine;
      
      private var _window:class_2250;
      
      private var var_315:int = -1;
      
      private var var_1015:int = 0;
      
      private var var_757:String;
      
      private var _text:String;
      
      private var var_55:Boolean;
      
      private var var_427:Boolean = false;
      
      private var var_2792:String;
      
      private var _senderName:String;
      
      private var var_195:int = -1;
      
      private var var_982:String = "";
      
      private var _placedInRoom:Boolean = false;
      
      private var var_2271:Boolean = false;
      
      public function PresentFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27, param5:class_16, param6:IHabboCatalog, param7:class_61, param8:IRoomEngine)
      {
         super(param1,param2,param3,param4);
         var_3365 = param5;
         _catalog = param6;
         _inventory = param7;
         _roomEngine = param8;
      }
      
      override public function dispose() : void
      {
         hideInterface();
         var_3365 = null;
         _catalog = null;
         _inventory = null;
         _roomEngine = null;
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.addEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWPDUE_PACKAGEINFO",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_IMAGE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_CLUB",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_FLOOR",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_LANDSCAPE",onObjectUpdate);
         param1.removeEventListener("RWPDUE_CONTENTS_WALLPAPER",onObjectUpdate);
         param1.removeEventListener("RWEBDUE_PACKAGEINFO",onEcotronUpdate);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         switch(param1.type)
         {
            case "RWPDUE_PACKAGEINFO":
               hideInterface();
               var_427 = false;
               var_315 = param1.objectId;
               _text = param1.text;
               var_55 = param1.controller;
               _senderName = param1.purchaserName;
               var_2792 = param1.purchaserFigure;
               var_2271 = param1.trustedSender;
               showInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_FLOOR":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               var_1015 = param1.classId;
               var_757 = param1.itemType;
               _text = param1.text;
               var_55 = param1.controller;
               var_195 = param1.placedItemId;
               var_982 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_floor");
               break;
            case "RWPDUE_CONTENTS_LANDSCAPE":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               var_1015 = param1.classId;
               var_757 = param1.itemType;
               _text = param1.text;
               var_55 = param1.controller;
               var_195 = param1.placedItemId;
               var_982 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_landscape");
               break;
            case "RWPDUE_CONTENTS_WALLPAPER":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               var_1015 = param1.classId;
               var_757 = param1.itemType;
               _text = param1.text;
               var_55 = param1.controller;
               var_195 = param1.placedItemId;
               var_982 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_wallpaper");
               break;
            case "RWPDUE_CONTENTS_CLUB":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               var_1015 = param1.classId;
               var_757 = param1.itemType;
               _text = param1.text;
               var_55 = param1.controller;
               showGiftOpenedInterface();
               showCustomIcon("packagecard_icon_hc");
               break;
            case "RWPDUE_CONTENTS":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               var_1015 = param1.classId;
               var_757 = param1.itemType;
               _text = param1.text;
               var_55 = param1.controller;
               var_195 = param1.placedItemId;
               var_982 = param1.placedItemType;
               _placedInRoom = param1.placedInRoom;
               showGiftOpenedInterface();
               showIcon(param1.iconBitmapData);
               break;
            case "RWPDUE_CONTENTS_IMAGE":
               if(!var_427)
               {
                  return;
               }
               showIcon(param1.iconBitmapData);
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == var_315)
         {
            hideInterface();
         }
         if(param1.id == var_195)
         {
            if(_placedInRoom)
            {
               _placedInRoom = false;
               updateRoomAndInventoryButtons();
            }
         }
      }
      
      private function onEcotronUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWEBDUE_PACKAGEINFO" === _loc2_)
         {
            hideInterface();
         }
      }
      
      private function showCustomIcon(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:BitmapDataAsset = assets.getAssetByName(param1) as BitmapDataAsset;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.content as BitmapData;
         }
         showIcon(_loc2_);
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc2_:class_2251 = _window.findChildByName("gift_image") as class_2251;
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.bitmap != null)
         {
            _loc2_.bitmap.dispose();
         }
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         var _loc3_:Point = new Point((_loc2_.width - param1.width) / 2,(_loc2_.height - param1.height) / 2);
         _loc2_.bitmap.copyPixels(param1,param1.rect,_loc3_);
      }
      
      private function showGiftOpenedInterface() : void
      {
         if(var_315 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc9_:XmlAsset = assets.getAssetByName("packagecard_new_opened") as XmlAsset;
         _window = windowManager.buildFromXML(_loc9_.content as XML) as class_2250;
         _window.center();
         if(!isUnknownSender())
         {
            var _loc11_:String = "widget.furni.present.window.title_from";
            var_167.registerParameter(null,"name",_senderName);
            _window.caption = var_167.getLocalization(null,_senderName);
         }
         var _loc6_:class_1741 = _window.findChildByName("header_button_close");
         if(_loc6_ != null)
         {
            _loc6_.addEventListener("WME_CLICK",onClose);
         }
         var _loc7_:class_2251 = _window.findChildByName("image_bg") as class_2251;
         if(_loc7_ != null)
         {
            var _loc3_:BitmapDataAsset = assets.getAssetByName("gift_icon_background") as BitmapDataAsset;
         }
         var _loc5_:ITextWindow = _window.findChildByName("gift_message") as ITextWindow;
         if(_loc5_ != null)
         {
            _loc5_.text = "";
            if(_text != null)
            {
               var _loc2_:String = "widget.furni.present.message_opened";
               var _loc10_:Boolean = isSpacesItem();
               if(_loc10_)
               {
                  _loc2_ = "widget.furni.present.spaces.message_opened";
               }
               var_167.registerParameter(null,"product",_text);
               if(var_757 == "h")
               {
                  _loc5_.text = _text;
               }
               else
               {
                  _loc5_.text = var_167.getLocalization(null,_text);
               }
            }
            else
            {
               _loc5_.visible = false;
            }
         }
         var _loc8_:class_1741 = _window.findChildByName("give_gift_button");
         if(_loc8_ != null)
         {
            if(!isUnknownSender())
            {
               var _loc4_:String = "widget.furni.present.give_gift";
               var_167.registerParameter(null,"name",_senderName);
               _loc8_.caption = var_167.getLocalization(null,_senderName);
               _loc8_.addEventListener("WME_CLICK",onGiveGiftOpened);
            }
            else
            {
               _loc8_.visible = false;
            }
         }
         prepareAvatarImageContainer();
         updateGiftDialogAvatarImage(var_2792);
         updateRoomAndInventoryButtons();
         selectGiftedObject();
      }
      
      private function isSpacesItem() : Boolean
      {
         var _loc2_:class_1800 = null;
         var _loc3_:String = null;
         var _loc1_:Boolean = false;
         if(var_757 == "i")
         {
            _loc2_ = (var_41 as FurniturePresentWidgetHandler).container.sessionDataManager.getWallItemData(var_1015);
            if(_loc2_ != null)
            {
               _loc3_ = _loc2_.className;
               _loc1_ = _loc3_ == "floor" || _loc2_.className == "landscape" || _loc2_.className == "wallpaper";
            }
         }
         return _loc1_;
      }
      
      private function isClubItem() : Boolean
      {
         return var_757 == "h";
      }
      
      private function updateRoomAndInventoryButtons() : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         var _loc4_:Boolean = isSpacesItem();
         var _loc7_:Boolean = isClubItem();
         var _loc10_:class_1741 = _window.findChildByName("keep_in_room_button");
         if(_loc10_ != null)
         {
            _loc10_.addEventListener("WME_CLICK",onKeepInRoom);
            _loc10_.visible = _placedInRoom;
            if(_loc4_ || _loc7_)
            {
               _loc10_.visible = false;
            }
         }
         var _loc1_:class_1741 = _window.findChildByName("place_in_room_button");
         if(_loc1_ != null)
         {
            _loc1_.addEventListener("WME_CLICK",onPlaceInRoom);
            _loc1_.visible = !_placedInRoom;
            if(_loc4_)
            {
               _loc1_.disable();
            }
            if(_loc4_ || _loc7_)
            {
               _loc1_.visible = false;
            }
         }
         var _loc2_:class_1741 = _window.findChildByName("put_in_inventory_button");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPutInInventory);
            _loc2_.enable();
            if(_loc4_ || _loc7_)
            {
               _loc2_.visible = false;
            }
         }
         var _loc8_:class_1741 = _window.findChildByName("separator");
         if(_loc8_ != null)
         {
            _loc8_.visible = isUnknownSender();
         }
         var _loc5_:class_1741 = _window.findChildByName("give_container") as class_1741;
         if(_loc5_ != null)
         {
            _loc5_.visible = !isUnknownSender();
         }
         var _loc6_:IItemListWindow = _window.findChildByName("button_list") as IItemListWindow;
         if(_loc6_ != null)
         {
            _loc6_.arrangeListItems();
         }
         var _loc3_:IItemListWindow = _window.findChildByName("give_element_list") as IItemListWindow;
         if(_loc3_ != null)
         {
            _loc3_.arrangeListItems();
         }
         var _loc9_:IItemListWindow = _window.findChildByName("element_list") as IItemListWindow;
         if(_loc9_ != null)
         {
            _loc9_.arrangeListItems();
         }
         _window.resizeToFitContent();
      }
      
      private function resetAndHideInterface() : void
      {
         var_427 = false;
         var_195 = -1;
         _placedInRoom = false;
         hideInterface();
      }
      
      private function onKeepInRoom(param1:class_1758) : void
      {
         resetAndHideInterface();
      }
      
      private function onPlaceInRoom(param1:class_1758) : void
      {
         var _loc3_:class_1875 = null;
         var _loc2_:class_1741 = param1.target;
         _loc2_.disable();
         if(var_195 > 0 && !_placedInRoom)
         {
            _loc3_ = null;
            switch(var_982)
            {
               case "s":
                  _loc3_ = _inventory.getFloorItemById(-var_195);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(var_195);
                  }
                  break;
               case "i":
                  _loc3_ = _inventory.getWallItemById(var_195);
                  if(requestSelectedFurniPlacement(_loc3_))
                  {
                     _inventory.removeUnseenFurniCounter(var_195);
                  }
                  break;
               case "p":
                  if(_inventory.placePetToRoom(var_195,false))
                  {
                     _inventory.removeUnseenPetCounter(var_195);
                  }
            }
         }
         resetAndHideInterface();
      }
      
      public function requestSelectedFurniPlacement(param1:class_1875) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:Boolean = false;
         if(param1.category == 3 || param1.category == 2 || param1.category == 4)
         {
            _loc2_ = false;
         }
         else
         {
            _loc2_ = _inventory.requestSelectedFurniToMover(param1);
         }
         return _loc2_;
      }
      
      private function onPutInInventory(param1:class_1758) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:IRoomObject = null;
         var _loc2_:class_1741 = param1.target;
         _loc2_.disable();
         if(var_195 > 0 && _placedInRoom)
         {
            if(var_982 == "p")
            {
               (var_41 as FurniturePresentWidgetHandler).container.roomSession.pickUpPet(var_195);
            }
            else
            {
               _loc4_ = (var_41 as FurniturePresentWidgetHandler).container.roomSession.roomId;
               _loc5_ = 10;
               _loc3_ = _roomEngine.getRoomObject(_loc4_,var_195,_loc5_);
               if(_loc3_ != null)
               {
                  _roomEngine.modifyRoomObject(_loc3_.getId(),_loc5_,"OBJECT_PICKUP");
               }
            }
         }
         resetAndHideInterface();
      }
      
      private function showInterface() : void
      {
         if(var_315 < 0)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
         }
         var _loc12_:XmlAsset = assets.getAssetByName("packagecard_new") as XmlAsset;
         _window = windowManager.buildFromXML(_loc12_.content as XML) as class_2250;
         _window.center();
         if(!isUnknownSender())
         {
            var _loc7_:String = "widget.furni.present.window.title_from";
            var_167.registerParameter(null,"name",_senderName);
            _window.caption = var_167.getLocalization(null,_senderName);
         }
         var _loc11_:class_1741 = _window.findChildByName("header_button_close");
         if(_loc11_ != null)
         {
            _loc11_.addEventListener("WME_CLICK",onClose);
         }
         var _loc6_:IStaticBitmapWrapperWindow = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
         if(_loc6_)
         {
            var _loc15_:String = var_3365.getProperty("catalog.gift_wrapping_new.gift_card");
            if(_loc15_ != "")
            {
               _loc6_.assetUri = "${image.library.url}Giftcards/" + null + ".png";
            }
         }
         prepareAvatarImageContainer();
         if(isUnknownSender())
         {
            updateUnknownSenderAvatarImage();
         }
         else
         {
            updateGiftDialogAvatarImage(var_2792);
         }
         if(!var_2271)
         {
            var _loc9_:class_1993 = _window.findChildByName("warning_foreground_border") as class_1993;
            if(_loc9_ != null)
            {
               null.color = 11599948;
            }
            var _loc14_:IStaticBitmapWrapperWindow = _window.findChildByName("warning_icon") as IStaticBitmapWrapperWindow;
            if(_loc14_ != null)
            {
               null.assetUri = "catalogue_icon_alert_s";
               null.width = 26;
               null.height = 26;
               null.x = 22;
               null.y = 12;
            }
            var _loc13_:String = "gift.untrusted.banner.text";
            var_167.registerParameter(null,"name","not trusted gift sender");
            var _loc16_:ITextWindow = _window.findChildByName("warning_text") as ITextWindow;
            if(_loc16_ != null)
            {
               null.text = var_167.getLocalization(null,_senderName);
            }
         }
         else
         {
            var _loc3_:IStaticBitmapWrapperWindow = _window.findChildByName("gift_card") as IStaticBitmapWrapperWindow;
            null.assetUri = "catalogue_giftcard_staff";
         }
         var _loc1_:ITextWindow = _window.findChildByName("message_text") as ITextWindow;
         if(_loc1_ != null)
         {
            _loc1_.text = _text;
         }
         var _loc18_:ITextWindow = _window.findChildByName("message_from") as ITextWindow;
         if(_loc18_ != null)
         {
            _loc18_.text = "";
            if(!isUnknownSender())
            {
               var _loc2_:String = "widget.furni.present.message_from";
               var_167.registerParameter(null,"name",_senderName);
               _loc18_.text = var_167.getLocalization(null,_senderName);
               _loc18_.addEventListener("WME_CLICK",onSenderNameClick);
            }
            else
            {
               _loc18_.visible = false;
            }
         }
         var _loc5_:IItemListWindow = _window.findChildByName("button_list") as IItemListWindow;
         if(_loc5_ != null)
         {
            var _loc4_:class_1741 = _loc5_.getListItemByName("give_gift_button");
            if(_loc4_ != null)
            {
               if(!isUnknownSender())
               {
                  var _loc10_:String = "widget.furni.present.give_gift";
                  var_167.registerParameter(null,"name",_senderName);
                  null.caption = var_167.getLocalization(null,_senderName);
               }
               if(var_55)
               {
                  null.addEventListener("WME_CLICK",onGiveGift);
               }
               if(!var_55 || isUnknownSender())
               {
                  null.visible = false;
               }
            }
            var _loc8_:class_1741 = _window.findChildByName("open_gift_button");
            if(_loc8_ != null)
            {
               if(var_55)
               {
                  null.addEventListener("WME_CLICK",onOpenGift);
               }
               else
               {
                  null.visible = false;
               }
            }
            _loc5_.arrangeListItems();
         }
         var _loc17_:IItemListWindow = _window.findChildByName("element_list") as IItemListWindow;
         _loc17_.x = _loc17_.spacing;
         _window.resizeToFitContent();
         _loc17_.parent.height = _loc17_.x + _loc17_.height;
      }
      
      private function isUnknownSender() : Boolean
      {
         return _senderName == null || _senderName.length == 0;
      }
      
      private function onClose(param1:class_1758) : void
      {
         var_427 = false;
         hideInterface();
      }
      
      private function onGiveGift(param1:class_1758) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_open_giftcard.clicked");
      }
      
      private function onGiveGiftOpened(param1:class_1758) : void
      {
         openGiftShop();
         HabboTracking.getInstance().trackEventLog("Catalog","click","client.return_gift_from_opened_present.clicked");
      }
      
      private function openGiftShop() : void
      {
         if(!isUnknownSender())
         {
            _catalog.giftReceiver = _senderName;
         }
         _catalog.openCatalogPage("gift_shop");
      }
      
      private function send(param1:IMessageComposer) : void
      {
         var _loc2_:IConnection = null;
         if(_catalog != null)
         {
            _loc2_ = _catalog.connection;
            if(_loc2_ != null)
            {
               _loc2_.send(param1);
            }
         }
      }
      
      private function getExtendedProfile() : void
      {
         if(!isUnknownSender())
         {
            send(new class_3556(_senderName));
         }
      }
      
      private function onSenderImageClick(param1:class_1758) : void
      {
         getExtendedProfile();
      }
      
      private function onSenderNameClick(param1:class_1758) : void
      {
         getExtendedProfile();
      }
      
      private function onOpenGift(param1:class_1758) : void
      {
         sendOpen();
      }
      
      public function getAvatarFaceBitmap(param1:String) : BitmapData
      {
         var _loc3_:class_48 = (var_41 as FurniturePresentWidgetHandler).container.avatarRenderManager;
         if(_loc3_ == null || param1 == null || param1.length == 0)
         {
            return null;
         }
         var _loc2_:BitmapData = null;
         var _loc4_:class_1827 = _loc3_.createAvatarImage(param1,"h",null,this);
         if(_loc4_ != null)
         {
            _loc2_ = _loc4_.getCroppedImage("head");
            _loc4_.dispose();
         }
         return _loc2_;
      }
      
      public function avatarImageReady(param1:String) : void
      {
         if(_window == null || Boolean(_window.disposed))
         {
            return;
         }
         if(param1 == var_2792)
         {
            updateGiftDialogAvatarImage(param1);
         }
      }
      
      private function prepareAvatarImageContainer() : void
      {
         var _loc1_:IRegionWindow = _window.findChildByName("avatar_image_region") as IRegionWindow;
         if(_loc1_ != null)
         {
            if(!isUnknownSender())
            {
               _loc1_.addEventListener("WME_CLICK",onSenderImageClick);
            }
            else
            {
               _loc1_.disable();
            }
         }
      }
      
      private function updateGiftDialogAvatarImage(param1:String) : void
      {
         var _loc2_:BitmapData = getAvatarFaceBitmap(param1);
         if(_loc2_ != null)
         {
            updateAvatarImageContainer(_loc2_);
         }
      }
      
      private function updateUnknownSenderAvatarImage() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:BitmapDataAsset = _assets.getAssetByName("gift_incognito") as BitmapDataAsset;
         if(_loc2_ != null)
         {
            _loc1_ = _loc2_.content as BitmapData;
            if(_loc1_ != null)
            {
               updateAvatarImageContainer(_loc1_.clone());
            }
         }
      }
      
      private function updateAvatarImageContainer(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc3_:class_2251 = _window.findChildByName("avatar_image") as class_2251;
         if(_loc3_ == null)
         {
            return;
         }
         var _loc2_:class_1812 = _window.findChildByName("staff_image") as class_1812;
         var _loc4_:class_1812 = _window.findChildByName("avatar_image_container") as class_1812;
         if(var_2271 && isUnknownSender())
         {
            _loc3_.disable();
            if(_loc2_ != null)
            {
               _loc2_.y = _loc4_.height / 2 - _loc3_.height / 2;
            }
         }
         else
         {
            _loc3_.bitmap = param1;
            _loc3_.width = param1.width;
            _loc3_.height = param1.height;
            _loc3_.x = _loc4_.width / 2 - _loc3_.width / 2;
            _loc3_.y = _loc4_.height / (var_2271 ? 1.5 : 2) - _loc3_.height / 2;
         }
         if(!var_2271)
         {
            if(_loc2_ != null)
            {
               (_loc2_.parent as class_1812).removeChild(_loc2_);
            }
         }
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         if(!var_427)
         {
            var_315 = -1;
         }
         _text = "";
         var_55 = false;
      }
      
      private function sendOpen() : void
      {
         if(var_427 || var_315 == -1 || !var_55)
         {
            return;
         }
         var_427 = true;
         hideInterface();
         if(messageListener != null)
         {
            var _loc1_:RoomWidgetPresentOpenMessage = new RoomWidgetPresentOpenMessage("RWPOM_OPEN_PRESENT",var_315);
            messageListener.processWidgetMessage(null);
         }
      }
      
      private function selectGiftedObject() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:IRoomObject = null;
         var _loc1_:class_2146 = null;
         if(var_195 > 0 && _placedInRoom)
         {
            _loc5_ = _roomEngine.activeRoomId;
            if(var_982 == "p")
            {
               _loc3_ = _roomEngine.getRoomObjectCount(_loc5_,100);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc2_ = _roomEngine.getRoomObjectWithIndex(_loc5_,_loc4_,100);
                  _loc1_ = (var_41 as FurniturePresentWidgetHandler).container.roomSession.userDataManager.getUserDataByIndex(_loc2_.getId());
                  if(_loc1_ != null && _loc1_.webID == var_195)
                  {
                     _roomEngine.selectRoomObject(_loc5_,_loc1_.roomObjectId,100);
                     break;
                  }
                  _loc4_++;
               }
            }
            else
            {
               _roomEngine.selectRoomObject(_loc5_,var_195,10);
            }
         }
      }
   }
}

