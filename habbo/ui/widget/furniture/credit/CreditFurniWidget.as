package com.sulake.habbo.ui.widget.furniture.credit
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.localization.class_27;
   import com.sulake.habbo.ui.IRoomWidgetHandler;
   import com.sulake.habbo.ui.widget.RoomWidgetBase;
   import com.sulake.habbo.ui.widget.events.RoomWidgetCreditFurniUpdateEvent;
   import com.sulake.habbo.ui.widget.messages.RoomWidgetCreditFurniRedeemMessage;
   import com.sulake.habbo.utils.HabboWebTools;
   import com.sulake.habbo.window.class_38;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   
   public class CreditFurniWidget extends RoomWidgetBase
   {
      
      private static const const_428:Number = 100;
      
      private static const const_356:Number = 100;
      
      private var _window:class_1812;
      
      private var var_1955:int = -1;
      
      private var var_3216:Number;
      
      private var var_2846:Boolean;
      
      public function CreditFurniWidget(param1:IRoomWidgetHandler, param2:class_38, param3:class_40, param4:class_27)
      {
         super(param1,param2,param3,param4);
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
         param1.addEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
         super.registerUpdateEvents(param1);
      }
      
      override public function unregisterUpdateEvents(param1:IEventDispatcher) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener("RWCFUE_CREDIT_FURNI_UPDATE",onObjectUpdate);
      }
      
      private function onObjectUpdate(param1:RoomWidgetCreditFurniUpdateEvent) : void
      {
         hideInterface();
         var_1955 = param1.objectId;
         var_3216 = param1.creditValue;
         var_2846 = param1.isNftCredit;
         showInterface();
      }
      
      private function showInterface() : void
      {
         if(var_1955 == -1)
         {
            return;
         }
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var _loc4_:String = var_2846 ? "nft.creditfurni.redeem.description" : "widgets.furniture.credit.redeem.value";
         var _loc5_:String = localizations.getLocalizationWithParams(_loc4_,"","value",String(var_3216));
         var _loc3_:String = localizations.getLocalization("nft.creditfurni.redeem.prompt");
         var _loc6_:IAsset = assets.getAssetByName("credit_redeem");
         var _loc1_:XmlAsset = XmlAsset(_loc6_);
         if(_loc1_ == null)
         {
            return;
         }
         _window = windowManager.createWindow("creditfurniui_container","",4,0,0x020000 | 1,new Rectangle(100,100,2,2),null,0) as class_1812;
         _window.buildFromXML(XML(_loc1_.content));
         _window.background = true;
         _window.color = 33554431;
         var _loc2_:class_1741 = _window.findChildByName("exchange_text");
         _loc2_ = _window.findChildByName("cancel");
         _loc2_ = _window.findChildByName("exchange");
         _loc2_ = _window.findChildByName("link");
         _loc2_ = _window.findChildByTag("close");
         _window.addEventListener("WME_CLICK",onMouseEvent);
      }
      
      private function hideInterface() : void
      {
         if(_window != null)
         {
            _window.dispose();
            _window = null;
         }
         var_1955 = -1;
         var_3216 = 0;
      }
      
      private function sendRedeemMessage() : void
      {
         var _loc1_:RoomWidgetCreditFurniRedeemMessage = null;
         if(var_1955 == -1)
         {
            return;
         }
         if(messageListener != null)
         {
            _loc1_ = new RoomWidgetCreditFurniRedeemMessage("RWFCRM_REDEEM",var_1955);
            messageListener.processWidgetMessage(_loc1_);
            hideInterface();
         }
      }
      
      private function onMouseEvent(param1:WindowMouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc2_:class_1741 = param1.target as class_1741;
         var _loc3_:String = _loc2_.name;
         switch(_loc3_)
         {
            case "link":
               _loc4_ = localizations.getLocalization("widget.furni.info.url");
               if(_loc4_.indexOf("http") == 0)
               {
                  HabboWebTools.navigateToURL(_loc4_,"habboMain");
               }
               break;
            case "exchange":
               sendRedeemMessage();
               break;
            case "cancel":
            case "close":
               hideInterface();
         }
      }
      
      private function onWindowClose(param1:class_1758, param2:class_1741) : void
      {
         if(param1.type != "WME_CLICK")
         {
            return;
         }
         hideInterface();
      }
   }
}

