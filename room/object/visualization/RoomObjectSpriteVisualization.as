package com.sulake.room.object.visualization
{
   import com.sulake.room.object.IRoomObject;
   import com.sulake.room.object.visualization.utils.class_1805;
   import com.sulake.room.utils.ColorConverter;
   import com.sulake.room.utils.IRoomGeometry;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class RoomObjectSpriteVisualization implements IRoomObjectSpriteVisualization
   {
      
      protected static const const_1129:String = "_";
      
      protected static const ICON_LAYER_ID:String = "_icon_";
      
      private static var var_4721:int = 0;
      
      private var var_170:Array;
      
      private var var_612:IRoomObject;
      
      private var var_1373:class_1805;
      
      protected var var_1559:int = -1;
      
      protected var var_262:int = -1;
      
      protected var var_199:int = -1;
      
      private var var_3637:int = 0;
      
      private var var_50:int = 0;
      
      public function RoomObjectSpriteVisualization()
      {
         super();
         var_3637 = var_4721++;
         var_170 = [];
         var_612 = null;
         var_1373 = null;
      }
      
      public function dispose() : void
      {
         if(var_170 != null)
         {
            for each(var _loc1_ in var_170)
            {
               _loc1_.dispose();
            }
            var_170 = null;
         }
         var_612 = null;
         assetCollection = null;
      }
      
      public function set assetCollection(param1:class_1805) : void
      {
         if(var_1373 != null)
         {
            var_1373.removeReference();
         }
         var_1373 = param1;
         if(var_1373 != null)
         {
            var_1373.addReference();
         }
      }
      
      public function setExternalBaseUrls(param1:String, param2:String, param3:Boolean) : void
      {
      }
      
      public function get assetCollection() : class_1805
      {
         return var_1373;
      }
      
      public function getUpdateID() : int
      {
         return var_50;
      }
      
      public function getInstanceId() : int
      {
         return var_3637;
      }
      
      protected function createSprites(param1:int) : void
      {
         var _loc2_:RoomObjectSprite = null;
         while(var_170.length > param1)
         {
            _loc2_ = var_170[var_170.length - 1] as RoomObjectSprite;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
            var_170.pop();
         }
         while(var_170.length < param1)
         {
            _loc2_ = new RoomObjectSprite();
            var_170.push(_loc2_);
         }
      }
      
      protected function clearSprites() : void
      {
         if(var_170.length > 0)
         {
            for each(var _loc1_ in var_170)
            {
               _loc1_.dispose();
            }
            var_170 = [];
         }
      }
      
      public function addSprite() : IRoomObjectSprite
      {
         return addSpriteAt(var_170.length);
      }
      
      public function addSpriteAt(param1:int) : IRoomObjectSprite
      {
         var _loc2_:IRoomObjectSprite = new RoomObjectSprite();
         if(param1 >= var_170.length)
         {
            var_170.push(_loc2_);
         }
         else
         {
            var_170.splice(param1,0,_loc2_);
         }
         return _loc2_;
      }
      
      public function removeSprite(param1:IRoomObjectSprite) : void
      {
         var _loc2_:int = int(var_170.indexOf(param1));
         if(_loc2_ == -1)
         {
            throw new Error("Trying to remove non-existing sprite!");
         }
         var_170.splice(_loc2_,1);
         RoomObjectSprite(param1).dispose();
      }
      
      public function get spriteCount() : int
      {
         return var_170.length;
      }
      
      public function getSprite(param1:int) : IRoomObjectSprite
      {
         if(param1 >= 0 && param1 < var_170.length)
         {
            return var_170[param1];
         }
         return null;
      }
      
      public function get object() : IRoomObject
      {
         return var_612;
      }
      
      public function set object(param1:IRoomObject) : void
      {
         var_612 = param1;
      }
      
      public function update(param1:IRoomGeometry, param2:int, param3:Boolean, param4:Boolean) : void
      {
      }
      
      protected function increaseUpdateId() : void
      {
         var_50 = var_50 + 1;
      }
      
      protected function reset() : void
      {
         var_1559 = 4294967295;
         var_262 = 4294967295;
         var_199 = -1;
      }
      
      public function getSpriteList() : Array
      {
         return null;
      }
      
      public function initialize(param1:IRoomObjectVisualizationData) : Boolean
      {
         return false;
      }
      
      public function get image() : BitmapData
      {
         return getImage(0,-1);
      }
      
      private function normalizeColourComponent(param1:int) : Number
      {
         return Math.max(0,Math.min(255,param1)) / 255;
      }
      
      public function getImage(param1:int, param2:int) : BitmapData
      {
         var _loc16_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc8_:Rectangle = boundingRectangle;
         if(_loc8_.width * _loc8_.height == 0)
         {
            return null;
         }
         var _loc10_:int = spriteCount;
         var _loc3_:IRoomObjectSprite = null;
         var _loc12_:Array = [];
         var _loc11_:int = 0;
         var _loc5_:BitmapData = null;
         _loc11_ = 0;
         while(_loc11_ < _loc10_)
         {
            _loc3_ = getSprite(_loc11_);
            if(_loc3_ != null && _loc3_.visible)
            {
               _loc5_ = _loc3_.asset;
               if(_loc5_ != null)
               {
                  _loc12_.push(_loc3_);
               }
            }
            _loc11_++;
         }
         if(_loc12_.length > 1)
         {
            _loc12_.sortOn("relativeDepth",16);
            _loc12_.reverse();
         }
         try
         {
            var _loc18_:BitmapData = new BitmapData(_loc8_.width,_loc8_.height,true,param1);
         }
         catch(e:ArgumentError)
         {
            class_21.log("Unable to create BitmapData object! " + e);
         }
         return new BitmapData(1,1,true);
      }
      
      public function get boundingRectangle() : Rectangle
      {
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = spriteCount;
         var _loc1_:IRoomObjectSprite = null;
         var _loc5_:Rectangle = new Rectangle();
         var _loc2_:BitmapData = null;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc1_ = getSprite(_loc7_);
            if(_loc1_ != null && _loc1_.visible)
            {
               _loc2_ = _loc1_.asset;
               if(_loc2_ != null)
               {
                  _loc4_ = _loc1_.offsetX;
                  _loc3_ = _loc1_.offsetY;
                  if(_loc7_ == 0)
                  {
                     _loc5_.left = _loc4_;
                     _loc5_.top = _loc3_;
                     _loc5_.right = _loc4_ + _loc1_.width;
                     _loc5_.bottom = _loc3_ + _loc1_.height;
                  }
                  else
                  {
                     if(_loc4_ < _loc5_.left)
                     {
                        _loc5_.left = _loc4_;
                     }
                     if(_loc3_ < _loc5_.top)
                     {
                        _loc5_.top = _loc3_;
                     }
                     if(_loc4_ + _loc1_.width > _loc5_.right)
                     {
                        _loc5_.right = _loc4_ + _loc1_.width;
                     }
                     if(_loc3_ + _loc1_.height > _loc5_.bottom)
                     {
                        _loc5_.bottom = _loc3_ + _loc1_.height;
                     }
                  }
               }
            }
            _loc7_++;
         }
         return _loc5_;
      }
      
      private function extractDarknessToAlpha(param1:BitmapData) : BitmapData
      {
         var _loc8_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc11_:* = 0;
         var _loc6_:* = 0;
         var _loc5_:* = 0;
         var _loc9_:* = 0;
         var _loc2_:int = 0;
         var _loc10_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:BitmapData = new BitmapData(param1.width,param1.height,true);
         var _loc12_:Vector.<uint> = param1.getVector(param1.rect);
         _loc8_ = 0;
         while(_loc8_ < _loc12_.length)
         {
            _loc3_ = _loc12_[_loc8_];
            _loc4_ = uint(_loc3_ >> 24 & 0xFF);
            _loc11_ = uint(_loc3_ >> 16 & 0xFF);
            _loc6_ = uint(_loc3_ >> 8 & 0xFF);
            _loc5_ = uint(_loc3_ & 0xFF);
            _loc9_ = _loc11_ << 16 | _loc6_ << 8 | _loc5_;
            _loc2_ = ColorConverter.rgbToHSL(_loc9_);
            _loc10_ = _loc2_ & 0xFF;
            if(_loc10_ <= 128)
            {
               _loc7_ = _loc2_ >> 16 & 0xFF;
               _loc13_ = _loc2_ >> 8 & 0xFF;
               _loc4_ *= _loc10_ / 128;
               _loc10_ = 128;
               _loc2_ = (_loc7_ << 16) + (_loc13_ << 8) + _loc10_;
               _loc9_ = ColorConverter.hslToRGB(_loc2_);
               _loc3_ = uint(_loc4_ << 24 | _loc9_);
            }
            _loc12_[_loc8_] = _loc3_;
            _loc8_++;
         }
         _loc14_.setVector(_loc14_.rect,_loc12_);
         return _loc14_;
      }
   }
}

