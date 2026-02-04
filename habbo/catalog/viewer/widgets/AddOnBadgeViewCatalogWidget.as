package com.sulake.habbo.catalog.viewer.widgets
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.catalog.viewer.widgets.events.SelectProductEvent;
   import com.sulake.habbo.window.widgets.class_3087;
   
   public class AddOnBadgeViewCatalogWidget extends CatalogWidget implements class_2612
   {
      
      public function AddOnBadgeViewCatalogWidget(param1:class_1812)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         if(!disposed)
         {
            events.removeEventListener("SELECT_PRODUCT",onSelectProduct);
            super.dispose();
         }
      }
      
      override public function init() : Boolean
      {
         if(!super.init())
         {
            return false;
         }
         attachWidgetView("addOnBadgeViewWidget");
         events.addEventListener("SELECT_PRODUCT",onSelectProduct);
         return true;
      }
      
      private function onSelectProduct(param1:SelectProductEvent) : void
      {
         var _loc2_:class_3087 = null;
         if(!disposed && param1.offer.badgeCode)
         {
            _loc2_ = class_2010(_window.findChildByName("badge")).widget as class_3087;
            if(_loc2_ != null)
            {
               _loc2_.badgeId = param1.offer.badgeCode;
            }
         }
      }
   }
}

