package com.sulake.habbo.catalog.recycler
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.XmlAsset;
   import com.sulake.core.window.components.ITextWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.habbo.catalog.HabboCatalog;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.session.furniture.class_1800;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import package_48.PrizeMessageSubProduct;
   
   public class DealPrizeContainer extends PrizeContainer
   {
      
      private var var_3535:Array;
      
      private var var_3479:Array = [];
      
      private var _catalog:HabboCatalog;
      
      private var _gridItemLayout:XML;
      
      private var var_1997:BitmapData;
      
      public function DealPrizeContainer(param1:Array, param2:int, param3:HabboCatalog)
      {
         _catalog = param3;
         var_3535 = param1;
         while(0 < param1.length)
         {
            var _loc4_:PrizeMessageSubProduct = param1[0];
            var _loc7_:class_1800 = param3.getFurnitureData(null.productItemTypeId,null.productItemType);
            var_3479.push(null);
            _loc6_++;
         }
         var _loc8_:XmlAsset = param3.assets.getAssetByName("gridItem") as XmlAsset;
         _gridItemLayout = _loc8_.content as XML;
         var _loc5_:BitmapDataAsset = param3.assets.getAssetByName("ctlg_pic_deal_icon_narrow") as BitmapDataAsset;
         var_1997 = BitmapData(_loc5_.content);
         super("deal",-1,null,param2,param3);
      }
      
      override public function setIcon(param1:IRoomEngine) : void
      {
         var _loc2_:class_2251 = class_2251(view.findChildByName("image"));
         _loc2_.bitmap = new BitmapData(_loc2_.width,_loc2_.height,true,0);
         _loc2_.bitmap.copyPixels(var_1997,var_1997.rect,new Point((_loc2_.width - var_1997.width) / 2,(_loc2_.height - var_1997.height) / 2));
         ITextWindow(view.findChildByName("bundleCounter")).text = var_3535.length.toString();
      }
      
      override public function get title() : String
      {
         return "";
      }
      
      public function get subProducts() : Array
      {
         return var_3535;
      }
      
      public function get furnitureDatas() : Array
      {
         return var_3479;
      }
   }
}

