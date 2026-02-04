package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.AssetLoaderStruct;
   import com.sulake.core.assets.loaders.AssetLoaderEvent;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.window.widgets.ILimitedItemGridOverlayWidget;
   import flash.display.BitmapData;
   
   public class SingleProductContainer extends ProductContainer
   {
      
      public function SingleProductContainer(param1:class_1793, param2:Vector.<class_1857>, param3:HabboCatalog)
      {
         super(param1,param2,param3);
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         var _loc3_:class_1857 = firstProduct;
         var _loc4_:BitmapData = _loc3_.initIcon(this,this,this,offer as class_1793,targetIcon,param2,onPreviewImageReady);
         this.setIconImage(_loc4_,true);
      }
      
      public function enableLimitedItemLayout() : void
      {
         var_18.findChildByName("unique_item_background_bitmap").visible = true;
         var _loc1_:class_2010 = class_2010(var_18.findChildByName("unique_item_overlay_container"));
         var _loc2_:ILimitedItemGridOverlayWidget = ILimitedItemGridOverlayWidget(_loc1_.widget);
         _loc1_.visible = true;
         _loc2_.serialNumber = firstProduct.uniqueLimitedItemSeriesSize;
         _loc2_.animated = true;
         if(firstProduct.uniqueLimitedItemsLeft == 0)
         {
            var_18.findChildByName("unique_item_sold_out_bitmap").visible = true;
         }
         else
         {
            var_18.findChildByName("unique_item_sold_out_bitmap").visible = false;
         }
      }
      
      private function onPreviewImageReady(param1:AssetLoaderEvent) : void
      {
         var _loc2_:AssetLoaderStruct = null;
         if(!disposed && offer.page.viewer.catalog != null)
         {
            _loc2_ = param1.target as AssetLoaderStruct;
            if(_loc2_ != null)
            {
               catalog.setImageFromAsset(targetIcon,_loc2_.assetName,null);
            }
         }
      }
      
      override public function set view(param1:class_1812) : void
      {
         super.view = param1;
         if(offer.product.isUniqueLimitedItem)
         {
            (offer.productContainer as SingleProductContainer).enableLimitedItemLayout();
         }
      }
      
      override protected function get useWideView() : Boolean
      {
         return offer.isSingleChatStyle;
      }
   }
}

