package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.habbo.catalog.viewer.widgets.events.CatalogWidgetShowWarningTextEvent;
   
   public class WarningCatalogWidget extends CatalogWidget implements class_2612
   {
      
      public function WarningCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         _window.findChildByName("warning_text").caption = "";
         events.addEventListener("CWE_SHOW_WARNING_TEXT",onWarningText);
         return true;
      }
      
      private function onWarningText(param1:CatalogWidgetShowWarningTextEvent) : void
      {
         _window.findChildByName("warning_text").caption = param1.text;
      }
   }
}

