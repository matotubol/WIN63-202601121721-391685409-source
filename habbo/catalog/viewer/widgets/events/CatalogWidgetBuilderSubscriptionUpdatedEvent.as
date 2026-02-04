package com.sulake.habbo.catalog.viewer.widgets.events
{
   import flash.events.Event;
   
   public class CatalogWidgetBuilderSubscriptionUpdatedEvent extends Event
   {
      
      public function CatalogWidgetBuilderSubscriptionUpdatedEvent(param1:Boolean = false, param2:Boolean = false)
      {
         super("CWE_BUILDER_SUBSCRIPTION_UPDATED",param1,param2);
      }
   }
}

