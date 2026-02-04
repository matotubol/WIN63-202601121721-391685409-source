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
   import com.sulake.habbo.catalog.collectibles.renderer.model.MintableItemWrapper;
   import com.sulake.habbo.catalog.collectibles.tabs.MintInventoryListTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4079;
   
   public class MintInventoryItemRenderer extends AbstractCollectibleItemRenderer
   {
      
      protected var var_750:MintInventoryListTab;
      
      public function MintInventoryItemRenderer(param1:CollectiblesController, param2:class_4079, param3:class_1812, param4:MintInventoryListTab, param5:int)
      {
         super(param1,new MintableItemWrapper(param2,param5),param3);
         var_750 = param4;
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
         var_750.selectItem(this);
      }
      
      override public function updateVisuals() : void
      {
         amountText.caption = isComplete ? "x" + renderableItem.amount : "-";
         amountTextBorder.color = isComplete ? 3374080 : 7441834;
      }
      
      public function get item() : class_4079
      {
         return (renderableItem as MintableItemWrapper).productItem;
      }
      
      override protected function completeColoring() : Object
      {
         return incompleteColoring();
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

