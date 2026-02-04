package com.sulake.habbo.catalog.collectibles.renderer
{
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_1993;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.catalog.collectibles.CollectiblesController;
   import com.sulake.habbo.catalog.collectibles.renderer.model.BaseItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.ShopTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_3631;
   
   public class ShopCollectibleItemRenderer extends AbstractCollectibleItemRenderer
   {
      
      protected var var_4953:ShopTab;
      
      protected var _offer:class_3631;
      
      public function ShopCollectibleItemRenderer(param1:CollectiblesController, param2:class_3631, param3:class_1812, param4:ShopTab)
      {
         var_4953 = param4;
         _offer = param2;
         super(param1,new BaseItemWrapper(param2.productInfo),param3);
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         var_4953.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = _offer.emeraldPrice.toString();
      }
      
      public function get item() : class_2870
      {
         return (renderableItem as BaseItemWrapper).baseItem;
      }
      
      public function get offer() : class_3631
      {
         return _offer;
      }
      
      override protected function get borderOutline() : class_1993
      {
         return container.findChildByName("border_outline") as class_1993;
      }
      
      override protected function get borderBackground() : class_1993
      {
         return container.findChildByName("border_background") as class_1993;
      }
      
      override protected function get amountText() : ITextWindow
      {
         return container.findChildByName("number") as ITextWindow;
      }
      
      override protected function get amountTextBorder() : class_1993
      {
         return container.findChildByName("text_border") as class_1993;
      }
      
      private function get checkmarkIcon() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("checkmark_icon") as IStaticBitmapWrapperWindow;
      }
      
      override protected function get bitmapWindow() : class_2251
      {
         return container.findChildByTag("BITMAP") as class_2251;
      }
      
      override protected function get unknownImageWindow() : IStaticBitmapWrapperWindow
      {
         return container.findChildByName("unknown_image") as IStaticBitmapWrapperWindow;
      }
      
      override protected function get badgeImageWindow() : class_2010
      {
         return container.findChildByName("badge_image_widget") as class_2010;
      }
      
      override protected function get petImageWindow() : class_2010
      {
         return container.findChildByName("pet_image_widget") as class_2010;
      }
   }
}

