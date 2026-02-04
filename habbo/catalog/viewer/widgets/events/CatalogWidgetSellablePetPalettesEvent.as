package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetSellablePetPalettesEvent extends Event
   {
      
      private var var_2711:String;
      
      private var var_2238:Array;
      
      public function CatalogWidgetSellablePetPalettesEvent(param1:String, param2:Array, param3:Boolean = false, param4:Boolean = false)
      {
         super("SELLABLE_PET_PALETTES",param3,param4);
         var_2711 = param1;
         var_2238 = param2;
      }
      
      public function get productCode() : String
      {
         return var_2711;
      }
      
      public function get sellablePalettes() : Array
      {
         if(var_2238 != null)
         {
            return var_2238.slice();
         }
         return [];
      }
   }
}

