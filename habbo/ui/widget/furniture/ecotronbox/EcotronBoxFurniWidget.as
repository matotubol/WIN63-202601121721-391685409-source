package com.sulake.habbo.ui.widget.furniture.ecotronbox
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetEcotronBoxDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetPresentDataUpdateEvent;
   import com.sulake.habbo.ui.widget.events.RoomWidgetRoomObjectUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetEcotronBoxOpenMessage;
   import com.sulake.habbo.window.class_38;
   import flash.display.BitmapData;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class EcotronBoxFurniWidget extends RoomWidgetBase
   {
      
      private static const const_428:Number = 100;
      
      private static const const_356:Number = 100;
      
      private var _window:class_1812;
      
      private var var_315:int = -1;
      
      private var _text:String;
      
      private var var_55:Boolean;
      
      private var var_427:Boolean = false;
      
      private var _furniTypeName:String = "ecotron_box";
      
      private var _interfaceMapByFurniTypeName:class_55 = new class_55();
      
      public function EcotronBoxFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40 = null)
      {
         super(param1,param2,param3);
         _interfaceMapByFurniTypeName.add("","ecotronbox_card");
         _interfaceMapByFurniTypeName.add("ecotron_box","ecotronbox_card");
         _interfaceMapByFurniTypeName.add("matic_box","ecotronbox_card_furnimatic");
      }
      
      override public function dispose() : void
      {
         hideInterface();
         super.dispose();
      }
      
      override public function registerUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.addEventListener("RWEBDUE_PACKAGEINFO",onObjectUpdate);
         param1.addEventListener("RWEBDUE_CONTENTS",onObjectUpdate);
         param1.addEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
         param1.addEventListener("RWPDUE_PACKAGEINFO",onPresentUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWEBDUE_PACKAGEINFO",onObjectUpdate);
         param1.removeEventListener("RWEBDUE_CONTENTS",onObjectUpdate);
         param1.removeEventListener("RWPDUE_PACKAGEINFO",onPresentUpdate);
         param1.removeEventListener("RWROUE_FURNI_REMOVED",onRoomObjectRemoved);
      }
      
      private function onObjectUpdate(param1:RoomWidgetEcotronBoxDataUpdateEvent) : void
      {
         hideInterface();
         switch(param1.type)
         {
            case "RWEBDUE_PACKAGEINFO":
               var_427 = false;
               var_315 = param1.objectId;
               _text = param1.text;
               var_55 = param1.controller;
               _furniTypeName = param1.furniTypeName;
               showInterface();
               break;
            case "RWEBDUE_CONTENTS":
               if(!var_427)
               {
                  return;
               }
               var_315 = param1.objectId;
               showInterface();
               showIcon(param1.iconBitmapData);
               showDescription(param1.text);
               setOpenButton(false);
         }
      }
      
      private function onRoomObjectRemoved(param1:RoomWidgetRoomObjectUpdateEvent) : void
      {
         if(param1.id == var_315)
         {
            hideInterface();
         }
      }
      
      private function onPresentUpdate(param1:RoomWidgetPresentDataUpdateEvent) : void
      {
         var _loc2_:* = param1.type;
         if("RWPDUE_PACKAGEINFO" === _loc2_)
         {
            hideInterface();
         }
      }
      
      private function showIcon(param1:BitmapData) : void
      {
         if(param1 == null)
         {
            param1 = new BitmapData(1,1);
         }
         if(_window == null)
         {
            return;
         }
         var _loc4_:class_2251 = _window.findChildByName("ecotronbox_card_preview") as class_2251;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:int = (_loc4_.width - param1.width) / 2;
         var _loc3_:int = (_loc4_.height - param1.height) / 2;
         if(_loc4_.bitmap == null)
         {
            _loc4_.bitmap = new BitmapData(_loc4_.width,_loc4_.height,true,16777215);
         }
         _loc4_.bitmap.fillRect(_loc4_.bitmap.rect,16777215);
         _loc4_.bitmap.copyPixels(param1,param1.rect,new Point(_loc2_,_loc3_),null,null,false);
      }
      
      private function showDescription(param1:String) : void
      {
         var _loc2_:ITextWindow = null;
         _loc2_ = _window.findChildByName("ecotronbox_card_msg") as ITextWindow;
         if(_loc2_ != null && param1 != null)
         {
            _loc2_.caption = param1;
         }
      }
      
      private function showInterface() : void
      {
         if(var_315 < 0)
         {
            return;
         }
         var _loc4_:IAsset = assets.getAssetByName(_interfaceMapByFurniTypeName.getValue(_furniTypeName));
         var _loc1_:XmlAsset = XmlAsset(_loc4_);
         if(_loc1_ == null)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         _window = windowManager.createWindow("ecotronboxcardui_container","",4,0,0x020000 | 1,new Rectangle(100,100,2,2),null,0) as class_1812;
         _window.buildFromXML(XML(_loc1_.content));
         var _loc3_:ITextWindow = _window.findChildByName("ecotronbox_card_date") as ITextWindow;
         var _loc2_:class_1741 = _window.findChildByName("ecotronbox_card_btn_close");
         setOpenButton(true);
      }
      
      private function setOpenButton(param1:Boolean) : void
      {
         var _loc2_:class_1741 = null;
         if(_window == null)
         {
            return;
         }
         _loc2_ = _window.findChildByName("ecotronbox_card_btn_open");
         if(_loc2_ != null)
         {
            if(var_55 && param1)
            {
               _loc2_.visible = true;
               _loc2_.addEventListener("WME_CLICK",onMouseEvent);
            }
            else
            {
               _loc2_.visible = false;
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
         if(messageListener != null)
         {
            var _loc1_:RoomWidgetEcotronBoxOpenMessage = new RoomWidgetEcotronBoxOpenMessage("RWEBOM_OPEN_ECOTRONBOX",var_315);
            messageListener.processWidgetMessage(null);
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "ecotronbox_card_btn_open":
               sendOpen();
               break;
            case "ecotronbox_card_btn_close":
            default:
               var_427 = false;
               hideInterface();
         }
      }
   }
}

