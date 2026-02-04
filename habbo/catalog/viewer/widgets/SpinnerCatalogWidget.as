package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetSpinnerEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SpinnerCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private static const SPIN_BUTTONDOWN_HOLD_VALUE_STEP_DELAY_MS:int = 75;
      
      private static const const_978:int = 35;
      
      private var _catalog:HabboCatalog;
      
      private var _value:int = 1;
      
      private var name_2:int = 1;
      
      private var name_4:int = 100;
      
      private var var_976:Timer;
      
      private var var_3178:Boolean = false;
      
      private var var_2894:Boolean = false;
      
      private var var_1502:Boolean = false;
      
      private var var_2395:int = 1;
      
      private var var_2476:Array = new Array(0);
      
      private var _promoInfo:class_1741;
      
      public function SpinnerCatalogWidget(param1:class_1812, param2:HabboCatalog)
      {
         super(param1);
         _catalog = param2;
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            if(var_976 != null)
            {
               var_976.stop();
               var_976 = null;
            }
            events.removeEventListener("CWSE_RESET",onRequestResetEvent);
            events.removeEventListener("CWSE_SHOW",onShowEvent);
            events.removeEventListener("CWSE_HIDE",onHideEvent);
            events.removeEventListener("CWSE_SET_MAX",onSetMaxEvent);
            events.removeEventListener("CWSE_SET_MIN",onSetMinEvent);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("spinnerWidget");
         window.visible = false;
         if(!_catalog.multiplePurchaseEnabled)
         {
            return true;
         }
         window.procedure = spinnerWindowProcedure;
         var _loc1_:ITextFieldWindow = window.findChildByName("text_value") as ITextFieldWindow;
         if(_loc1_)
         {
            _loc1_.addEventListener("WKE_KEY_UP",onInputEvent);
         }
         events.addEventListener("CWSE_RESET",onRequestResetEvent);
         events.addEventListener("CWSE_SHOW",onShowEvent);
         events.addEventListener("CWSE_HIDE",onHideEvent);
         events.addEventListener("CWSE_SET_MAX",onSetMaxEvent);
         events.addEventListener("CWSE_SET_MIN",onSetMinEvent);
         var_976 = new Timer(75);
         var_976.addEventListener("timer",onSpinnerTimerEvent);
         _promoInfo = window.findChildByName("promo.info");
         return true;
      }
      
      private function refresh() : void
      {
         _value = Math.max(_value,name_2);
         _value = Math.min(_value,name_4);
         events.dispatchEvent(new CatalogWidgetSpinnerEvent("CWSE_VALUE_CHANGED",_value));
         setValueText(_value.toString());
         if(_promoInfo && _catalog.bundleDiscountEnabled)
         {
            var _loc1_:int = _catalog.utils.getDiscountItemsCount(_value);
            window.findChildByName("discountContainer").visible = 0 > 0;
            _catalog.localization.registerParameter("shop.bonus.items.count","amount",(0).toString());
         }
      }
      
      private function onRequestResetEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         _value = param1.value;
         if(param1.skipSteps != null)
         {
            var_2476 = param1.skipSteps;
         }
         refresh();
      }
      
      private function onShowEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = true;
      }
      
      private function onHideEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         window.visible = false;
      }
      
      private function onSetMaxEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         name_4 = param1.value;
      }
      
      private function onSetMinEvent(param1:CatalogWidgetSpinnerEvent) : void
      {
         name_2 = param1.value;
      }
      
      private function onSpinnerTimerEvent(param1:TimerEvent) : void
      {
         if(disposed)
         {
            return;
         }
         var_1502 = true;
         if(var_3178)
         {
            increaseValue();
            if(_value - var_2395 > 35)
            {
               increaseValue();
            }
         }
         if(var_2894)
         {
            decreaseValue();
            if(var_2395 - _value > 35)
            {
               decreaseValue();
            }
         }
         refresh();
      }
      
      private function increaseValue() : void
      {
         var _loc1_:int = _value + 1;
         while(var_2476.indexOf(_loc1_) != -1)
         {
            _loc1_++;
         }
         _value = _loc1_;
      }
      
      private function decreaseValue() : void
      {
         var _loc1_:int = _value - 1;
         while(var_2476.indexOf(_loc1_) != -1)
         {
            _loc1_--;
         }
         _value = _loc1_;
      }
      
      private function setValueText(param1:String) : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.findChildByName("text_value") is ITextFieldWindow)
         {
            if(_window.findChildByName("text_value").caption.length > 0)
            {
               _window.findChildByName("text_value").caption = param1;
            }
         }
         else
         {
            _window.findChildByName("text_value").caption = param1;
         }
      }
      
      private function spinnerWindowProcedure(param1:class_1758, param2:class_1741 = null) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1.type != "WME_CLICK" && param1.type != "WME_DOWN" && param1.type != "WME_UP" && param1.type != "WME_UP_OUTSIDE")
         {
            return;
         }
         switch(param1.target.name)
         {
            case "button_less":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     var_2894 = true;
                     var_2395 = _value;
                     var_976.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     var_2894 = false;
                     var_976.stop();
                     break;
                  case "WME_CLICK":
                     if(!var_1502)
                     {
                        decreaseValue();
                     }
                     refresh();
                     var_1502 = false;
               }
               break;
            case "button_more":
               switch(param1.type)
               {
                  case "WME_DOWN":
                     var_3178 = true;
                     var_2395 = _value;
                     var_976.start();
                     break;
                  case "WME_UP":
                  case "WME_UP_OUTSIDE":
                     var_3178 = false;
                     var_976.stop();
                     break;
                  case "WME_CLICK":
                     if(!var_1502)
                     {
                        increaseValue();
                     }
                     refresh();
                     var_1502 = false;
               }
         }
      }
      
      private function onInputEvent(param1:WindowKeyboardEvent) : void
      {
         _value = parseInt(param1.target.caption);
         refresh();
      }
   }
}

