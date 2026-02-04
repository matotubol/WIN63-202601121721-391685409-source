package com.sulake.habbo.notifications.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.runtime.class_17;
   import com.sulake.habbo.inventory.class_61;
   import com.sulake.habbo.room.IRoomEngine;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import flash.display.BitmapData;
   
   public class ProductImageUtility implements class_1829
   {
      
      private var _roomEngine:IRoomEngine;
      
      private var _inventory:class_61;
      
      public function ProductImageUtility(param1:IRoomEngine, param2:class_61)
      {
         super();
         _roomEngine = param1;
         _inventory = param2;
      }
      
      public function dispose() : void
      {
         _roomEngine = null;
         _inventory = null;
      }
      
      public function getProductImage(param1:String, param2:int, param3:String) : BitmapData
      {
         var _loc4_:class_2198 = null;
         var _loc6_:BitmapData = null;
         switch(param1)
         {
            case "s":
               _loc4_ = _roomEngine.getFurnitureIcon(param2,this);
               break;
            case "i":
               var _loc5_:int = tempCategoryMapping("I",param2);
               if(_loc5_ == 1)
               {
                  _loc4_ = _roomEngine.getWallItemIcon(param2,this,param3);
                  break;
               }
               switch(0 - 2)
               {
                  case 0:
                     var _loc7_:BitmapDataAsset = (_inventory as class_17).assets.getAssetByName("icon_wallpaper_png") as BitmapDataAsset;
                     if(_loc7_ != null)
                     {
                        _loc6_ = (null.content as BitmapData).clone();
                     }
                     break;
                  case 1:
                     _loc7_ = (_inventory as class_17).assets.getAssetByName("icon_floor_png") as BitmapDataAsset;
                     if(_loc7_ != null)
                     {
                        _loc6_ = (null.content as BitmapData).clone();
                     }
                     break;
                  case 2:
                     _loc7_ = (_inventory as class_17).assets.getAssetByName("icon_landscape_png") as BitmapDataAsset;
                     if(_loc7_ != null)
                     {
                        _loc6_ = (null.content as BitmapData).clone();
                     }
               }
               _loc4_ = null;
               break;
            case "e":
               _loc7_ = (_inventory as class_17).assets.getAssetByName("fx_icon_" + param2 + "_png") as BitmapDataAsset;
               if(_loc7_ != null)
               {
                  _loc6_ = (null.content as BitmapData).clone();
               }
               break;
            default:
               class_21.log("[HabboNotifications] Can not yet handle this type of product: ");
         }
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_.data;
         }
         return _loc6_;
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function tempCategoryMapping(param1:String, param2:int) : int
      {
         if(param1 == "S")
         {
            return 1;
         }
         if(param1 == "I")
         {
            if(param2 == 3001)
            {
               return 2;
            }
            if(param2 == 3002)
            {
               return 3;
            }
            if(param2 == 4057)
            {
               return 4;
            }
            return 1;
         }
         return 1;
      }
   }
}

