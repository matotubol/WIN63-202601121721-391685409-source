package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_4151 extends class_4135
   {
      
      public function class_4151()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openClubCenter();
         landingView.tracking.trackGoogle("landingView","click_buyVip");
      }
   }
}

