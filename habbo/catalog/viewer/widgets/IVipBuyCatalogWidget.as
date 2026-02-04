package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.habbo.catalog.club.ClubBuyOfferData;
   
   public interface IVipBuyCatalogWidget
   {
      
      function dispose() : void;
      
      function init() : Boolean;
      
      function reset() : void;
      
      function initClubType(param1:int) : void;
      
      function showOffer(param1:ClubBuyOfferData) : void;
      
      function get isGift() : Boolean;
   }
}

