package com.sulake.habbo.friendbar.landingview.widget.elements
{
   public class class_4136 extends class_4135
   {
      
      public function class_4136()
      {
         super();
      }
      
      override protected function onClick() : void
      {
         landingView.catalog.openCreditsHabblet();
         landingView.tracking.trackGoogle("landingView","click_credithabblet");
      }
   }
}

