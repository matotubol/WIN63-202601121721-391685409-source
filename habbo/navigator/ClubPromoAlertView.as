package com.sulake.habbo.navigator
{
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2250;
   import com.sulake.core.window.events.WindowMouseEvent;
   
   public class ClubPromoAlertView extends AlertView
   {
      
      private var _text:String;
      
      private var var_3830:String;
      
      public function ClubPromoAlertView(param1:class_42, param2:String, param3:String, param4:String)
      {
         super(param1,"nav_promo_alert",param2);
         _text = param3;
         var_3830 = param4;
      }
      
      override internal function setupAlertWindow(param1:class_2250) : void
      {
         var _loc4_:class_1812 = param1.content;
         _loc4_.findChildByName("body_text").caption = _text;
         _loc4_.findChildByName("promo_text").caption = var_3830;
         var _loc3_:class_1741 = _loc4_.findChildByName("ok");
         if(_loc3_ != null)
         {
            _loc3_.addEventListener("WME_CLICK",onOk);
         }
         var _loc2_:class_1741 = _loc4_.findChildByName("promo_container");
         if(_loc2_ != null)
         {
            _loc2_.addEventListener("WME_CLICK",onPromo);
         }
      }
      
      private function onOk(param1:WindowMouseEvent) : void
      {
         dispose();
      }
      
      private function onPromo(param1:WindowMouseEvent) : void
      {
         navigator.openCatalogClubPage("ClubPromoAlertView");
         dispose();
      }
   }
}

