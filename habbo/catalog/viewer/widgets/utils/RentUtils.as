package com.sulake.habbo.catalog.viewer.widgets.utils
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.catalog.class_1793;
   
   public class RentUtils
   {
      
      public function RentUtils()
      {
         super();
      }
      
      public static function updateBuyCaption(param1:class_1793, param2:class_1741) : void
      {
         if(param1 == null || param2 == null)
         {
            return;
         }
         param2.caption = param1.isRentOffer ? "${catalog.purchase_confirmation.rent}" : "${catalog.purchase_confirmation.buy}";
      }
   }
}

