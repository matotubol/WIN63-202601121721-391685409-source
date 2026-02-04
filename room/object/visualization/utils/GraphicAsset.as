package com.sulake.room.object.visualization.utils
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import flash.display.BitmapData;
   
   public class GraphicAsset implements IGraphicAsset
   {
      
      private static const const_15:Vector.<GraphicAsset> = new Vector.<GraphicAsset>();
      
      private var _assetName:String;
      
      private var _libraryAssetName:String;
      
      private var _asset:BitmapDataAsset;
      
      private var _flipH:Boolean;
      
      private var _flipV:Boolean;
      
      private var var_5216:Boolean;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var _width:int;
      
      private var var_385:int;
      
      private var var_704:Boolean;
      
      public function GraphicAsset()
      {
         super();
      }
      
      public static function allocate(param1:String, param2:String, param3:IAsset, param4:Boolean, param5:Boolean, param6:int, param7:int, param8:Boolean = false) : GraphicAsset
      {
         var _loc9_:GraphicAsset = const_15.length > 0 ? const_15.pop() : new GraphicAsset();
         _loc9_._assetName = param1;
         _loc9_._libraryAssetName = param2;
         var _loc10_:BitmapDataAsset = param3 as BitmapDataAsset;
         if(_loc10_ != null)
         {
            _loc9_._asset = _loc10_;
            _loc9_.var_704 = false;
         }
         else
         {
            _loc9_._asset = null;
            _loc9_.var_704 = true;
         }
         _loc9_._flipH = param4;
         _loc9_._flipV = param5;
         _loc9_._offsetX = param6;
         _loc9_._offsetY = param7;
         _loc9_.var_5216 = param8;
         return _loc9_;
      }
      
      public function recycle() : void
      {
         _asset = null;
         const_15.push(this);
      }
      
      private function initialize() : void
      {
         var _loc1_:BitmapData = null;
         if(!var_704 && _asset != null)
         {
            _loc1_ = _asset.content as BitmapData;
            if(_loc1_ != null)
            {
               _width = _loc1_.width;
               var_385 = _loc1_.height;
            }
            var_704 = true;
         }
      }
      
      public function get flipV() : Boolean
      {
         return _flipV;
      }
      
      public function get flipH() : Boolean
      {
         return _flipH;
      }
      
      public function get width() : int
      {
         initialize();
         return _width;
      }
      
      public function get height() : int
      {
         initialize();
         return var_385;
      }
      
      public function get assetName() : String
      {
         return _assetName;
      }
      
      public function get libraryAssetName() : String
      {
         return _libraryAssetName;
      }
      
      public function get asset() : IAsset
      {
         return _asset;
      }
      
      public function get usesPalette() : Boolean
      {
         return var_5216;
      }
      
      public function get offsetX() : int
      {
         if(!_flipH)
         {
            return _offsetX;
         }
         return -(width + _offsetX);
      }
      
      public function get offsetY() : int
      {
         if(!_flipV)
         {
            return _offsetY;
         }
         return -(height + _offsetY);
      }
      
      public function get originalOffsetX() : int
      {
         return _offsetX;
      }
      
      public function get originalOffsetY() : int
      {
         return _offsetY;
      }
   }
}

