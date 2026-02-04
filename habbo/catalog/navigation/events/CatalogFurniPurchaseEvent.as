package com.sulake.habbo.catalog.navigation.events
{
   import flash.events.Event;
   
   public class CatalogFurniPurchaseEvent extends Event
   {
      
      public static const CATALOG_FURNI_PURCHASE:String = "CATALOG_FURNI_PURCHASE";
      
      private var var_1275:String;
      
      public function CatalogFurniPurchaseEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("CATALOG_FURNI_PURCHASE",param2,param3);
         var_1275 = param1;
      }
      
      public function get localizationId() : String
      {
         return var_1275;
      }
   }
}

