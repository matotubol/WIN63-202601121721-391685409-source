package com.sulake.habbo.catalog.event
{
   import flash.events.Event;
   
   public class CatalogEvent extends Event
   {
      
      public static const CATALOG_INITIALIZED:String = "CATALOG_INITIALIZED";
      
      public static const CATALOG_NOT_READY:String = "CATALOG_NOT_READY";
      
      public static const CATALOG_NEW_ITEMS_SHOW:String = "CATALOG_NEW_ITEMS_SHOW";
      
      public static const CATALOG_NEW_ITEMS_HIDE:String = "CATALOG_NEW_ITEMS_HIDE";
      
      public static const CATALOG_USER_SELECTED:String = "CATALOG_USER_SELECTED";
      
      public static const CATALOG_BUILDER_MEMBERSHIP_EXPIRED:String = "CATALOG_BUILDER_MEMBERSHIP_EXPIRED";
      
      public static const CATALOG_BUILDER_MEMBERSHIP_IN_GRACE:String = "CATALOG_BUILDER_MEMBERSHIP_IN_GRACE";
      
      public static const CATALOG_INVISIBLE_PAGE_VISITED:String = "CATALOG_INVISIBLE_PAGE_VISITED";
      
      public static const COLLECTIBLES_CLAIM_WAIT:String = "COLLECTIBLE_CLAIM_WAIT";
      
      public static const COLLECTIBLES_CLAIM_SUCCESS:String = "COLLECTIBLE_CLAIM_SUCCESS";
      
      public static const COLLECTIBLES_CLAIM_FAIL:String = "COLLECTIBLES_CLAIM_FAIL";
      
      public static const COLLECTIBLES_MINT_SUCCESS:String = "COLLECTIBLES_MINT_SUCCESS";
      
      public static const COLLECTIBLES_MINT_FAIL:String = "COLLECTIBLES_MINT_FAIL";
      
      public function CatalogEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

