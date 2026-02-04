package com.sulake.habbo.friendbar.landingview.widget
{
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   
   public class CatalogPromoWidgetSmall extends CatalogPromoWidget
   {
      
      public function CatalogPromoWidgetSmall(param1:HabboLandingView)
      {
         super(param1);
      }
      
      override protected function get xmlAssetName() : String
      {
         return "catalog_promo_small";
      }
   }
}

