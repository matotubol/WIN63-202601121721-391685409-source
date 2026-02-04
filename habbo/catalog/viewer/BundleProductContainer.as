package com.sulake.habbo.catalog.viewer
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IItemGridWindow;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.catalog.class_1793;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.IStuffData;
   import flash.display.BitmapData;
   
   public class BundleProductContainer extends ProductContainer implements IItemGrid
   {
      
      private var var_1997:BitmapData;
      
      public function BundleProductContainer(param1:class_1793, param2:Vector.<class_1857>, param3:HabboCatalog)
      {
         super(param1,param2,param3);
         var _loc4_:BitmapDataAsset = param3.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset;
         if(_loc4_ != null)
         {
            var_1997 = _loc4_.content as BitmapData;
         }
         else
         {
            var_1997 = new BitmapData(1,1,true,16777215);
         }
      }
      
      override public function dispose() : void
      {
         if(disposed)
         {
            return;
         }
         var_1997 = null;
         super.dispose();
      }
      
      override public function initProductIcon(param1:IRoomEngine, param2:IStuffData = null) : void
      {
         setIconImage(var_1997.clone(),true);
      }
      
      public function populateItemGrid(param1:IItemGridWindow, param2:XML) : void
      {
         var _loc7_:class_1812 = null;
         var _loc3_:class_1741 = null;
         var _loc6_:BitmapData = null;
         var _loc4_:class_1812 = catalog.windowManager.buildFromXML(param2) as class_1812;
         for each(var _loc5_ in offer.productContainer.products)
         {
            if(_loc5_.productType != "b")
            {
               _loc7_ = _loc4_.clone() as class_1812;
               _loc3_ = _loc7_.findChildByName("clubLevelIcon");
               if(_loc3_ != null)
               {
                  _loc3_.visible = false;
               }
               param1.addGridItem(_loc7_);
               _loc5_.view = _loc7_;
               _loc6_ = _loc5_.initIcon(this);
               if(_loc6_ != null)
               {
                  _loc6_.dispose();
               }
               _loc5_.grid = this;
            }
         }
      }
      
      public function setBundleCounter(param1:int) : void
      {
         var _loc2_:class_1741 = var_18.findChildByName("bundleCounter") as ITextWindow;
         if(_loc2_ != null)
         {
            _loc2_.caption = param1.toString();
         }
      }
      
      public function select(param1:class_2253, param2:Boolean) : void
      {
         class_21.log("Product Bundle, select item: " + param1);
      }
      
      public function startDragAndDrop(param1:class_2253) : Boolean
      {
         return false;
      }
      
      override public function set view(param1:class_1812) : void
      {
         super.view = param1;
         setBundleCounter(999);
      }
   }
}

