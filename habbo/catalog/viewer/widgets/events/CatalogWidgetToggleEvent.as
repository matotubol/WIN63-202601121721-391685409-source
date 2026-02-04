package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetToggleEvent extends Event
   {
      
      private var var_3900:String;
      
      private var var_1191:Boolean;
      
      public function CatalogWidgetToggleEvent(param1:String, param2:Boolean, param3:Boolean = false, param4:Boolean = false)
      {
         super("CWE_TOGGLE",param3,param4);
         var_3900 = param1;
         var_1191 = param2;
      }
      
      public function get widgetId() : String
      {
         return var_3900;
      }
      
      public function get enabled() : Boolean
      {
         return var_1191;
      }
   }
}

