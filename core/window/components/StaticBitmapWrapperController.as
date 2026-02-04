package com.sulake.core.window.components
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.class_3067;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class StaticBitmapWrapperController extends BitmapDataController implements IStaticBitmapWrapperWindow, class_2201, class_3067
   {
      
      protected var _assetUri:String;
      
      protected var var_822:Boolean = false;
      
      public function StaticBitmapWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_822)
            {
               _bitmapData.dispose();
            }
            super.dispose();
         }
      }
      
      public function get assetUri() : String
      {
         return _assetUri;
      }
      
      public function set assetUri(param1:String) : void
      {
         if(_assetUri == param1)
         {
            return;
         }
         _assetUri = param1;
         if(param1 == null || param1.length <= 0)
         {
            if(var_822)
            {
               _bitmapData.dispose();
            }
            _bitmapData = null;
            var_822 = false;
            _context.invalidate(this,null,1);
         }
         else
         {
            _context.getResourceManager().retrieveAsset(_assetUri,this);
         }
      }
      
      public function receiveAsset(param1:IAsset, param2:String) : void
      {
         if(_disposed || !_context.getResourceManager().isSameAsset(_assetUri,param2))
         {
            return;
         }
         var _loc4_:BitmapDataAsset = param1 as BitmapDataAsset;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc3_:BitmapData = _loc4_.content as BitmapData;
         if(_loc3_ == null)
         {
            return;
         }
         if(_bitmapData != _loc3_)
         {
            if(var_822)
            {
               _bitmapData.dispose();
            }
            var_822 = false;
            var _loc5_:Rectangle = _loc4_.rectangle;
            if(_loc3_.width == null.width && _loc3_.height == null.height)
            {
               _bitmapData = _loc3_;
            }
            else
            {
               _bitmapData = new BitmapData(null.width,null.height);
               _bitmapData.copyPixels(_loc3_,null,new Point(0,0));
               var_822 = true;
            }
            _context.invalidate(this,null,1);
         }
         fitSize();
      }
      
      override public function clone() : class_1741
      {
         var _loc1_:StaticBitmapWrapperController = super.clone() as StaticBitmapWrapperController;
         if(var_822)
         {
            _loc1_._bitmapData = _bitmapData.clone();
         }
         else
         {
            _loc1_._bitmapData = _bitmapData;
         }
         _loc1_._assetUri = _assetUri;
         _loc1_.var_822 = var_822;
         return _loc1_;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.unshift(createProperty("asset_uri",_assetUri));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            var _loc3_:* = _loc2_.key;
            if("asset_uri" === _loc3_)
            {
               assetUri = _loc2_.value as String;
            }
         }
         super.properties = param1;
      }
   }
}

