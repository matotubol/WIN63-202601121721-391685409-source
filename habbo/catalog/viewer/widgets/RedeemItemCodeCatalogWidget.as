package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.ITextFieldWindow;
   import com.sulake.core.window.components.class_1775;
   import com.sulake.core.window.events.WindowKeyboardEvent;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.events.class_1758;
   import com.sulake.core.window.utils.class_1750;
   
   public class RedeemItemCodeCatalogWidget extends CatalogWidget implements class_2612
   {
      
      private var var_1506:class_1775;
      
      private var var_1644:ITextFieldWindow;
      
      public function RedeemItemCodeCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(var_1506 != null)
         {
            var_1506.removeEventListener("WME_CLICK",onRedeem);
            var_1506 = null;
         }
         if(var_1644 != null)
         {
            var_1644.removeEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
            var_1644 = null;
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         var_1506 = _window.findChildByName("redeem") as class_1775;
         if(var_1506 != null)
         {
            var_1506.addEventListener("WME_CLICK",onRedeem);
         }
         var_1644 = _window.findChildByName("voucher_code") as ITextFieldWindow;
         if(var_1644 != null)
         {
            var_1644.addEventListener("WKE_KEY_DOWN",windowKeyEventProcessor);
         }
         return true;
      }
      
      private function onRedeem(param1:WindowMouseEvent) : void
      {
         redeem();
      }
      
      private function windowKeyEventProcessor(param1:class_1758 = null, param2:class_1741 = null) : void
      {
         var _loc3_:WindowKeyboardEvent = param1 as WindowKeyboardEvent;
         if(_loc3_.charCode == 13)
         {
            redeem();
         }
      }
      
      private function redeem() : void
      {
         var voucher:String;
         var input:class_1741 = _window.findChildByName("voucher_code");
         if(input != null)
         {
            voucher = input.caption;
            if(voucher.length > 0)
            {
               page.viewer.catalog.redeemVoucher(voucher);
               input.caption = "";
            }
            else
            {
               page.viewer.catalog.windowManager.alert("${catalog.voucher.empty.title}","${catalog.voucher.empty.desc}",0,function(param1:class_1750, param2:class_1758):void
               {
                  param1.dispose();
               });
            }
         }
      }
   }
}

