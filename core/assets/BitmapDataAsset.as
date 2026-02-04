package com.sulake.core.assets
{
   import com.sulake.core.utils.images.class_3548;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   public class BitmapDataAsset implements ILazyAsset
   {
      
      protected static var var_1885:uint = 0;
      
      protected static var var_2037:uint = 0;
      
      private static const CLONE_BITMAP_DATA:Boolean = true;
      
      private static const USE_ASYNC_LOADER:Boolean = false;
      
      private static const IMMEDIATE_PREPARE:Boolean = false;
      
      public var name:String;
      
      private var _disposed:Boolean = false;
      
      private var _rectangle:Rectangle;
      
      private var var_83:Object;
      
      private var _bitmap:BitmapData;
      
      private var _offset:Point = new Point(0,0);
      
      private var _flipH:Boolean = false;
      
      private var _flipV:Boolean = false;
      
      private var _decl:AssetTypeDeclaration;
      
      private var var_989:String;
      
      private var var_75:Loader;
      
      private var var_4439:Boolean = true;
      
      public function BitmapDataAsset(param1:AssetTypeDeclaration, param2:String = null)
      {
         super();
         _decl = param1;
         var_989 = param2;
         var_1885 = var_1885 + 1;
      }
      
      public static function get instances() : uint
      {
         return var_1885;
      }
      
      public static function get allocatedByteCount() : uint
      {
         return var_2037;
      }
      
      public function get url() : String
      {
         return var_989;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
      
      public function get offset() : Point
      {
         return _offset;
      }
      
      public function get content() : Object
      {
         if(!_bitmap)
         {
            prepareLazyContent();
         }
         return _bitmap;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get rectangle() : Rectangle
      {
         var _loc1_:BitmapData = null;
         if(!_rectangle)
         {
            _loc1_ = BitmapData(content);
            if(_loc1_)
            {
               _rectangle = _loc1_.rect;
            }
         }
         return _rectangle;
      }
      
      public function get declaration() : AssetTypeDeclaration
      {
         return _decl;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            var_1885 = var_1885 - 1;
            if(_bitmap)
            {
               try
               {
                  var_2037 -= _bitmap.width * _bitmap.height * 4;
                  if(var_4439)
                  {
                     _bitmap.dispose();
                  }
               }
               catch(e:Error)
               {
               }
            }
            if(var_83 is BitmapData)
            {
               if(var_4439)
               {
                  (var_83 as BitmapData).dispose();
               }
            }
            else if(var_83 is Bitmap)
            {
               (var_83 as Bitmap).bitmapData.dispose();
            }
            else if(var_83 is ByteArray)
            {
               (var_83 as ByteArray).clear();
            }
            var_83 = null;
            _bitmap = null;
            _offset = null;
            _decl = null;
            var_989 = null;
            _rectangle = null;
            _disposed = true;
         }
      }
      
      public function setUnknownContent(param1:Object) : void
      {
         if(param1 == null)
         {
         }
         if(_bitmap)
         {
            if(_bitmap == param1 as BitmapData)
            {
               return;
            }
            if(var_4439)
            {
               _bitmap.dispose();
            }
         }
         var_83 = param1;
         _bitmap = null;
      }
      
      public function prepareLazyContent() : void
      {
         var _loc3_:Object = null;
         var _loc2_:Bitmap = null;
         var _loc1_:Bitmap = null;
         if(var_83 == null)
         {
            return;
         }
         if(var_83 is Class)
         {
            _loc3_ = new (var_83 as Class)();
            _loc2_ = _loc3_ as Bitmap;
            if(_loc2_ != null)
            {
               _bitmap = _loc2_.bitmapData.clone();
               _loc2_.bitmapData.dispose();
               if(_bitmap != null)
               {
                  var_2037 += _bitmap.width * _bitmap.height * 4;
                  var_83 = null;
                  return;
               }
               _loc3_ = new BitmapData(20,20,true,16711680);
            }
            _bitmap = _loc3_ as BitmapData;
            if(_bitmap != null)
            {
               var_83 = null;
               return;
            }
         }
         if(var_83 is Bitmap)
         {
            _loc1_ = Bitmap(var_83);
            _bitmap = _loc1_.bitmapData;
            if(_bitmap == null)
            {
               throw new Error("Failed to convert Bitmap to BitmapDataAsset!");
            }
            var_83 = null;
         }
         if(var_83 is BitmapData)
         {
            _bitmap = var_83 as BitmapData;
            if(_bitmap != null)
            {
               var_83 = null;
               return;
            }
            throw new Error("Failed to convert BitmapData to BitmapDataAsset!");
         }
         if(var_83 is BitmapDataAsset)
         {
            _bitmap = BitmapDataAsset(var_83)._bitmap;
            _offset = BitmapDataAsset(var_83)._offset;
            _flipH = BitmapDataAsset(var_83)._flipH;
            _flipV = BitmapDataAsset(var_83)._flipV;
            if(_bitmap != null)
            {
               var_83 = null;
               return;
            }
            throw new Error("Failed to read content from BitmapDataAsset!");
         }
         if(var_83 is ByteArray)
         {
            try
            {
               _bitmap = new class_3548().decode(var_83 as ByteArray);
            }
            catch(e:Error)
            {
               class_21.log("Error decoding asset content to PNG: " + url + "::" + name);
            }
            var_83 = null;
         }
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:Loader = param1.currentTarget.loader as Loader;
         var _loc3_:Bitmap = _loc2_.content as Bitmap;
         _bitmap = _loc3_.bitmapData;
         if(var_75 && var_75.contentLoaderInfo)
         {
            var_75.contentLoaderInfo.removeEventListener("complete",onLoaderComplete);
         }
         var_75 = null;
      }
      
      public function setFromOtherAsset(param1:IAsset) : void
      {
         if(param1 is BitmapDataAsset)
         {
            _bitmap = BitmapDataAsset(param1)._bitmap;
            _offset = BitmapDataAsset(param1)._offset;
            return;
         }
         throw new Error("Provided asset should be of type BitmapDataAsset!");
      }
      
      public function setParamsDesc(param1:XMLList) : void
      {
         var _loc3_:Array = null;
         var _loc5_:String = null;
         for each(var _loc2_ in param1)
         {
            _loc5_ = _loc2_.attribute("key");
            var _loc4_:String = _loc2_.attribute("value");
            switch(_loc5_)
            {
               case "offset":
                  _loc3_ = _loc4_.split(",");
                  _offset.x = parseInt(_loc3_[0]);
                  _offset.y = parseInt(_loc3_[1]);
                  break;
               case "region":
                  _loc3_ = _loc4_.split(",");
                  if(!_rectangle)
                  {
                     _rectangle = new Rectangle();
                  }
                  _rectangle.x = parseInt(_loc3_[0]);
                  _rectangle.y = parseInt(_loc3_[1]);
                  _rectangle.width = parseInt(_loc3_[2]);
                  _rectangle.height = parseInt(_loc3_[3]);
                  break;
               case "flipH":
                  _flipH = _loc4_ == "1" || _loc4_ == "true";
                  break;
               case "flipV":
                  _flipV = _loc4_ == "1" || _loc4_ == "true";
            }
         }
      }
   }
}

