package com.sulake.habbo.inventory.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.class_40;
   import com.sulake.habbo.inventory.IThumbListDrawableItem;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ThumbListManager
   {
      
      private var var_2319:IThumbListDataProvider;
      
      private var var_520:int;
      
      private var var_1082:int = 1;
      
      private var var_47:BitmapData;
      
      private var var_5386:int;
      
      private var _listItemWidth:int;
      
      private var _viewWidth:int;
      
      private var var_1880:int;
      
      private var _thumbWidth:int;
      
      private var var_209:int;
      
      private var var_1355:BitmapData;
      
      private var var_4597:BitmapData;
      
      public function ThumbListManager(param1:class_40, param2:IThumbListDataProvider, param3:String, param4:String, param5:int, param6:int)
      {
         super();
         var_2319 = param2;
         var _loc7_:BitmapDataAsset = BitmapDataAsset(param1.getAssetByName(param3));
         if(_loc7_ != null)
         {
            var_1355 = BitmapData(_loc7_.content);
         }
         var _loc8_:BitmapDataAsset = BitmapDataAsset(param1.getAssetByName(param4));
         if(_loc8_ != null)
         {
            var_4597 = BitmapData(_loc8_.content);
         }
         _thumbWidth = var_1355.width;
         var_209 = var_1355.height;
         _viewWidth = param5;
         var_1880 = param6;
         var_520 = Math.floor(_viewWidth / _thumbWidth);
         var_47 = new BitmapData(_viewWidth,var_1880);
      }
      
      public function dispose() : void
      {
         var_2319 = null;
         var_47 = null;
      }
      
      public function updateImageFromList() : void
      {
         var_1082 = resolveRowCountFromList();
         if(var_1082 == 0)
         {
            var_47 = new BitmapData(_viewWidth,var_1880);
            return;
         }
         var_47 = new BitmapData(Math.max(var_520 * _thumbWidth,_viewWidth),Math.max(var_1082 * var_209,var_1880),true,16777215);
         var_47.fillRect(var_47.rect,4294967295);
         var _loc6_:int = 0;
         var _loc4_:Array = getList();
         var _loc5_:int = 0;
         while(0 < var_1082)
         {
            var _loc3_:int = 0;
            while(0 < var_520)
            {
               if(_loc6_ < _loc4_.length)
               {
                  var _loc1_:IThumbListDrawableItem = _loc4_[_loc6_];
                  _loc6_++;
               }
               _loc3_++;
            }
            _loc5_++;
         }
      }
      
      public function addItemAsFirst(param1:IThumbListDrawableItem) : void
      {
         var _loc2_:BitmapData = null;
         var _loc4_:Rectangle = null;
         if(param1 == null)
         {
            return;
         }
         var _loc5_:Point = resolveLastItemGridLoc();
         if(_loc5_.x == var_520 && var_47.height < _loc5_.y * var_209)
         {
            _loc2_ = new BitmapData(var_47.width,var_47.height + var_209);
         }
         else
         {
            _loc2_ = new BitmapData(var_47.width,var_47.height);
         }
         var _loc3_:BitmapData = createThumbImage(param1.iconImage,param1.isSelected);
         _loc2_.copyPixels(_loc3_,_loc3_.rect,new Point(0,0),null,null,true);
         _loc4_ = new Rectangle(0,0,_thumbWidth * (var_520 - 1),var_209);
         _loc2_.copyPixels(var_47,_loc4_,new Point(_thumbWidth,0),null,null,true);
         _loc4_ = new Rectangle(_thumbWidth * (var_520 - 1),0,_thumbWidth,var_47.height);
         _loc2_.copyPixels(var_47,_loc4_,new Point(0,var_209),null,null,true);
         _loc4_ = new Rectangle(0,var_209,_thumbWidth * (var_520 - 1),var_47.height - var_209);
         _loc2_.copyPixels(var_47,_loc4_,new Point(_thumbWidth,var_209),null,null,true);
         var_47 = _loc2_;
      }
      
      public function replaceItemImage(param1:int, param2:IThumbListDrawableItem) : void
      {
         if(param2 == null)
         {
            return;
         }
         var _loc4_:Point = resolveGridLocationFromIndex(param1);
         var _loc5_:Point = new Point(_loc4_.x * _thumbWidth,_loc4_.y * var_209);
         var _loc3_:BitmapData = createThumbImage(param2.iconImage,param2.isSelected);
         var_47.copyPixels(_loc3_,_loc3_.rect,_loc5_,null,null,true);
      }
      
      public function getListImage() : BitmapData
      {
         return var_47;
      }
      
      public function removeItemInIndex(param1:int) : void
      {
         var _loc2_:Point = resolveGridLocationFromIndex(param1);
         removeItemInImage(_loc2_);
      }
      
      public function removeItemInLocation(param1:Point) : void
      {
         var _loc2_:Point = resolveGridLocationFromImage(param1);
         removeItemInImage(_loc2_);
      }
      
      public function updateListItem(param1:int) : void
      {
         var _loc2_:IThumbListDrawableItem = getDrawableItem(param1);
         replaceItemImage(param1,_loc2_);
      }
      
      private function getList() : Array
      {
         var _loc1_:Array = null;
         if(var_2319 != null)
         {
            _loc1_ = var_2319.getDrawableList();
         }
         return _loc1_ ? _loc1_ : [];
      }
      
      private function getDrawableItem(param1:int) : IThumbListDrawableItem
      {
         var _loc2_:Array = getList();
         if(param1 >= 0 && param1 < _loc2_.length)
         {
            return _loc2_[param1] as IThumbListDrawableItem;
         }
         return null;
      }
      
      private function resolveRowCountFromList() : int
      {
         var _loc1_:Array = getList();
         return int(Math.ceil(_loc1_.length / var_520));
      }
      
      private function resolveLastItemGridLoc() : Point
      {
         var _loc2_:Array = getList();
         return resolveGridLocationFromIndex(_loc2_.length - 1);
      }
      
      public function resolveIndexFromImageLocation(param1:Point) : int
      {
         var _loc3_:Point = resolveGridLocationFromImage(param1);
         return int(_loc3_.y * var_520 + _loc3_.x);
      }
      
      private function resolveGridLocationFromImage(param1:Point) : Point
      {
         var _loc2_:int = Math.floor(param1.y / var_209);
         var _loc3_:int = Math.floor(param1.x / _thumbWidth);
         return new Point(_loc3_,_loc2_);
      }
      
      private function resolveGridLocationFromIndex(param1:int) : Point
      {
         var _loc2_:int = Math.floor(param1 / var_520);
         var _loc3_:int = param1 % var_520;
         return new Point(_loc3_,_loc2_);
      }
      
      private function removeItemInImage(param1:Point) : void
      {
         var _loc7_:Rectangle = null;
         var _loc3_:Point = null;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:BitmapData = null;
         var _loc9_:BitmapData = null;
         var _loc5_:BitmapData = null;
         var _loc12_:BitmapData = null;
         if(param1.x >= var_520)
         {
            return;
         }
         if(param1.y >= var_1082)
         {
            return;
         }
         var _loc11_:int = var_520 - param1.x - 1;
         _loc7_ = new Rectangle((param1.x + 1) * _thumbWidth,param1.y * var_209,_loc11_ * _thumbWidth,var_209);
         _loc3_ = new Point(param1.x * _thumbWidth,param1.y * var_209);
         var _loc4_:BitmapData = new BitmapData(_loc7_.width + _thumbWidth,_loc7_.height);
         _loc4_.fillRect(_loc4_.rect,4294967295);
         _loc4_.copyPixels(var_47,_loc7_,new Point(0,0),null,null,true);
         var_47.copyPixels(_loc4_,_loc4_.rect,_loc3_,null,null,true);
         if(param1.y < var_1082 - 1)
         {
            _loc6_ = var_47.width - _thumbWidth;
            _loc8_ = var_47.height - (param1.y + 1) * var_209;
            _loc2_ = new BitmapData(_loc6_,_loc8_);
            _loc7_ = new Rectangle(_thumbWidth,(param1.y + 1) * var_209,_loc2_.width,_loc2_.height);
            _loc2_.copyPixels(var_47,_loc7_,new Point(0,0),null,null,true);
            _loc9_ = new BitmapData(_thumbWidth,_loc7_.height);
            _loc7_.x = 0;
            _loc7_.width = _thumbWidth;
            _loc9_.copyPixels(var_47,_loc7_,new Point(0,0),null,null,true);
            var_47.fillRect(new Rectangle(0,var_47.height - var_209,var_47.width,var_209),4294967295);
            _loc3_ = new Point(var_47.width - _thumbWidth,_loc7_.y - var_209);
            var_47.copyPixels(_loc9_,_loc9_.rect,_loc3_,null,null,true);
            _loc3_ = new Point(0,_loc7_.y);
            var_47.copyPixels(_loc2_,_loc2_.rect,_loc3_,null,null,true);
         }
         var _loc10_:int = getList().length - 1;
         if(_loc10_ > 0)
         {
            param1 = resolveGridLocationFromIndex(_loc10_);
            if(param1.x == var_520 - 1)
            {
               _loc5_ = new BitmapData(var_47.width,var_47.height - var_209);
               _loc7_ = new Rectangle(0,0,var_47.width,var_47.height - var_209);
               _loc5_.copyPixels(var_47,_loc7_,new Point(0,0),null,null,true);
               var_47 = _loc5_;
               var_1082 = var_1082 - 1;
            }
         }
         if(var_47.height < var_1880)
         {
            _loc12_ = new BitmapData(var_47.width,var_1880);
            _loc12_.fillRect(_loc12_.rect,4294967295);
            _loc12_.copyPixels(var_47,var_47.rect,new Point(0,0),null,null,true);
            var_47 = _loc12_;
         }
      }
      
      private function createThumbImage(param1:BitmapData = null, param2:Boolean = false) : BitmapData
      {
         var _loc3_:Point = null;
         var _loc4_:BitmapData = new BitmapData(var_1355.width,var_1355.height);
         if(param2)
         {
            _loc4_.copyPixels(var_4597,var_1355.rect,new Point(0,0),null,null,false);
         }
         else
         {
            _loc4_.copyPixels(var_1355,var_1355.rect,new Point(0,0),null,null,false);
         }
         if(param1 != null)
         {
            _loc3_ = new Point((_loc4_.width - param1.width) / 2,(_loc4_.height - param1.height) / 2);
            _loc4_.copyPixels(param1,param1.rect,_loc3_,null,null,true);
         }
         return _loc4_;
      }
   }
}

