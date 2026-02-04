package com.sulake.habbo.catalog.offers
{
   import com.sulake.core.runtime.class_13;
   
   public interface IOfferProvider extends class_13
   {
      
      function get enabled() : Boolean;
      
      function load() : void;
      
      function showVideo() : void;
      
      function get videoAvailable() : Boolean;
      
      function get showingPopup() : Boolean;
   }
}

