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
   import com.sulake.habbo.catalog.collectibles.tabs.RewardClaimsTab;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_2870;
   import com.sulake.habbo.communication.messages.parser.collectibles.class_4085;
   import com.sulake.habbo.localization.class_27;
   
   public class RewardCollectibleItemRenderer extends AbstractCollectibleItemRenderer
   {
      
      protected var var_5237:RewardClaimsTab;
      
      protected var var_1720:class_4085;
      
      private var var_3443:BaseItemWrapper;
      
      public function RewardCollectibleItemRenderer(param1:CollectiblesController, param2:class_4085, param3:class_1812, param4:RewardClaimsTab)
      {
         var_5237 = param4;
         var_1720 = param2;
         var_3443 = new BaseItemWrapper(param2.claimItem);
         super(param1,var_3443,param3);
      }
      
      override protected function onClick(param1:WindowMouseEvent) : void
      {
      }
      
      override public function updateVisuals() : void
      {
         nameText.caption = var_55.getProductName(var_3443);
         amountText.caption = "x" + (var_1720.claimLimit - var_1720.claimedAmount);
         collectionText.caption = "<b>" + localization.getLocalization("collectibles.claim.collection") + "</b> " + collectionName;
         walletText.caption = var_1720.wallet;
      }
      
      public function updateExpiresText(param1:String) : void
      {
         expiresText.caption = "<b>" + localization.getLocalization("collectibles.claim.expiration") + "</b> " + param1;
      }
      
      public function get item() : class_2870
      {
         return (renderableItem as BaseItemWrapper).baseItem;
      }
      
      public function get rewardClaim() : class_4085
      {
         return var_1720;
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
         return container.findChildByTag("AMOUNT_TITLE") as ITextWindow;
      }
      
      override protected function get amountTextBorder() : class_1993
      {
         return container.findChildByName("text_border") as class_1993;
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
      
      private function get nameText() : ITextWindow
      {
         return container.findChildByTag("NAME_TITLE") as ITextWindow;
      }
      
      private function get walletText() : ITextWindow
      {
         return container.findChildByName("wallet_text") as ITextWindow;
      }
      
      private function get collectionText() : ITextWindow
      {
         return container.findChildByName("collection_text") as ITextWindow;
      }
      
      private function get expiresText() : ITextWindow
      {
         return container.findChildByName("expires_text") as ITextWindow;
      }
      
      private function get localization() : class_27
      {
         return var_55.localizationManager;
      }
      
      private function get collectionName() : String
      {
         var _loc1_:String = localization.getLocalization("collectibles.set." + var_1720.claimItem.setId);
         return _loc1_;
      }
   }
}

