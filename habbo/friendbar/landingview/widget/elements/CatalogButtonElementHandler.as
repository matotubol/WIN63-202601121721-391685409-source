package com.sulake.habbo.friendbar.landingview.widget.elements
{
   import com.sulake.core.window.class_1741;
   import com.sulake.habbo.friendbar.landingview.HabboLandingView;
   import com.sulake.habbo.friendbar.landingview.widget.GenericWidget;
   
   public class CatalogButtonElementHandler extends class_4135
   {
      
      private var _pageName:String;
      
      public function CatalogButtonElementHandler()
      {
         super();
      }
      
      override public function initialize(param1:HabboLandingView, param2:class_1741, param3:Array, param4:GenericWidget) : void
      {
         super.initialize(param1,param2,param3,param4);
         _pageName = param3[2];
      }
      
      override protected function onClick() : void
      {
         if(_pageName)
         {
            landingView.catalog.openCatalogPage(_pageName);
         }
         else
         {
            landingView.catalog.openCatalog();
         }
         landingView.tracking.trackGoogle("landingView","click_genericcatalog");
      }
   }
}

