package com.sulake.habbo.window.widgets
{
   import flash.utils.Dictionary;
   
   public class class_2086
   {
      
      private static var key:String;
      
      public static var var_141:Dictionary = new Dictionary();
      
      public static var WIDGET_TYPES:Array = [];
      
      var_141["avatar_image"] = AvatarImageWidget;
      var_141["badge_image"] = BadgeImageWidget;
      var_141["balloon"] = BalloonWidget;
      var_141["countdown"] = CountdownWidget;
      var_141["hover_bitmap"] = HoverBitmapWidget;
      var_141["illumina_border"] = IlluminaBorderWidget;
      var_141["illumina_chat_bubble"] = IlluminaChatBubbleWidget;
      var_141["illumina_input"] = IlluminaInputWidget;
      var_141["progress_indicator"] = ProgressIndicatorWidget;
      var_141["limited_item_overlay_grid"] = LimitedItemGridOverlayWidget;
      var_141["limited_item_overlay_preview"] = LimitedItemPreviewOverlayWidget;
      var_141["limited_item_overlay_supply"] = LimitedItemSupplyLeftOverlayWidget;
      var_141["product_icon"] = ProductIconWidget;
      var_141["product_image"] = ProductImageWidget;
      var_141["rarity_item_overlay_grid"] = RarityItemGridOverlayWidget;
      var_141["rarity_item_overlay_preview"] = RarityItemPreviewOverlayWidget;
      var_141["separator"] = SeparatorWidget;
      var_141["updating_timestamp"] = UpdatingTimeStampWidget;
      var_141["running_number"] = RunningNumberWidget;
      var_141["pet_image"] = PetImageWidget;
      var_141["furniture_image"] = FurnitureImageWidget;
      var_141["room_previewer"] = RoomPreviewerWidget;
      var_141["pixel_limit"] = PixelLimitWidget;
      var_141["room_thumbnail"] = RoomThumbnailWidget;
      var_141["room_user_count"] = RoomUserCountWidget;
      for(key in var_141)
      {
         WIDGET_TYPES.push(key);
      }
      WIDGET_TYPES.sort();
      
      public function class_2086()
      {
         super();
      }
   }
}

