package com.sulake.core.window.components
{
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.core.window.utils.class_2201;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   
   public class BitmapWrapperController extends BitmapDataController implements class_2251, class_2201
   {
      
      protected var var_723:Boolean;
      
      protected var _bitmapAssetName:String;
      
      public function BitmapWrapperController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:class_1741, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         var_723 = Boolean(param5.getWindowFactory().getThemeManager().getPropertyDefaults(param3).method_20("handle_bitmap_disposing"));
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get bitmap() : BitmapData
      {
         return _bitmapData;
      }
      
      public function set bitmap(param1:BitmapData) : void
      {
         if(var_723 && _bitmapData && param1 != _bitmapData)
         {
            _bitmapData.dispose();
         }
         _bitmapData = param1;
         fitSize();
         _context.invalidate(this,null,1);
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         bitmap = param1;
      }
      
      public function get bitmapAssetName() : String
      {
         return _bitmapAssetName;
      }
      
      public function set bitmapAssetName(param1:String) : void
      {
         _bitmapAssetName = param1;
      }
      
      public function get disposesBitmap() : Boolean
      {
         return var_723;
      }
      
      public function set disposesBitmap(param1:Boolean) : void
      {
         var_723 = param1;
      }
      
      override public function clone() : class_1741
      {
         var _loc1_:BitmapWrapperController = super.clone() as BitmapWrapperController;
         _loc1_._bitmapData = var_723 && _bitmapData ? _bitmapData.clone() : _bitmapData;
         _loc1_.var_723 = var_723;
         _loc1_._bitmapAssetName = _bitmapAssetName;
         return _loc1_;
      }
      
      override public function dispose() : void
      {
         if(_bitmapData)
         {
            if(var_723)
            {
               _bitmapData.dispose();
            }
            _bitmapData = null;
         }
         super.dispose();
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.unshift(createProperty("handle_bitmap_disposing",var_723));
         _loc1_.unshift(createProperty("bitmap_asset_name",_bitmapAssetName));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "handle_bitmap_disposing":
                  var_723 = _loc2_.value as Boolean;
                  break;
               case "bitmap_asset_name":
                  _bitmapAssetName = _loc2_.value as String;
            }
         }
         super.properties = param1;
      }
   }
}

