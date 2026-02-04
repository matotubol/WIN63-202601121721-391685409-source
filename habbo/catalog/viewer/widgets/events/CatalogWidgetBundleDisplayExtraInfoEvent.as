package com.sulake.habbo.catalog.viewer.widgets.events
{
   import com.sulake.habbo.catalog.viewer.widgets.bundlepurchaseinfodisplay.ExtraInfoItemData;
   import flash.events.Event;
   
   public class CatalogWidgetBundleDisplayExtraInfoEvent extends Event
   {
      
      public static const RESET:String = "CWPPEIE_RESET";
      
      public static const HIDE:String = "CWPPEIE_HIDE";
      
      public static const ITEM_CLICKED:String = "CWPPEIE_ITEM_CLICKED";
      
      private var var_197:int;
      
      private var var_24:ExtraInfoItemData;
      
      public function CatalogWidgetBundleDisplayExtraInfoEvent(param1:String, param2:ExtraInfoItemData = null, param3:int = -1)
      {
         super(param1);
         var_197 = param3;
         var_24 = param2;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get data() : ExtraInfoItemData
      {
         return var_24;
      }
   }
}

