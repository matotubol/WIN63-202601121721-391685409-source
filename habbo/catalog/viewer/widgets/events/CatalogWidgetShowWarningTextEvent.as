package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetShowWarningTextEvent extends Event
   {
      
      private var _text:String;
      
      public function CatalogWidgetShowWarningTextEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super("CWE_SHOW_WARNING_TEXT",param2,param3);
         _text = param1;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}

