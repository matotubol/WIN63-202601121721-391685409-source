package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   
   public class FurnitureImageWidget implements class_3137, class_1829
   {
      
      public static const TYPE:String = "furniture_image";
      
      private static const const_470:String = "furniture_image:furnitureType";
      
      private static const SCALE_KEY:String = "furniture_image:scale";
      
      private static const const_295:String = "furniture_image:direction";
      
      private static const ITEM_TYPE_FLOOR:int = 0;
      
      private static const ITEM_TYPE_WALL:int = 1;
      
      private static const const_12:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FURNITURE_TYPE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:furnitureType","table_plasto_square","String",false);
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("furniture_image:direction",const_12[2],"String",false,const_12);
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _bitmap:class_2251;
      
      private var var_308:IRegionWindow;
      
      private var var_1834:String = "table_plasto_square";
      
      private var var_337:int = int(SCALE_DEFAULT.value);
      
      private var var_81:int = const_12.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var var_1532:class_55;
      
      private var var_3221:String;
      
      private var var_757:int = 0;
      
      private var var_1966:IStuffData = null;
      
      public function FurnitureImageWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_1532 = new class_55();
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("furniture_image_xml").content as XML) as class_1812;
         _bitmap = var_134.findChildByName("bitmap") as class_2251;
         var_308 = var_134.findChildByName("region") as IRegionWindow;
         var_308.addEventListener("WME_CLICK",onClick);
         refresh();
         var_210.rootWindow = var_134;
         var_134.width = var_210.width;
         var_134.height = var_210.height;
      }
      
      public function dispose() : void
      {
         if(!_disposed)
         {
            if(var_308 != null)
            {
               var_308.removeEventListener("WME_CLICK",onClick);
               var_308.dispose();
               var_308 = null;
            }
            _bitmap = null;
            if(var_134 != null)
            {
               var_134.dispose();
               var_134 = null;
            }
            if(var_210 != null)
            {
               var_210.rootWindow = null;
               var_210 = null;
            }
            _windowManager = null;
            _disposed = true;
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get iterator() : IIterator
      {
         return EmptyIterator.INSTANCE;
      }
      
      public function get properties() : Array
      {
         var _loc1_:Array = [];
         if(_disposed)
         {
            return _loc1_;
         }
         _loc1_.push(FURNITURE_TYPE_DEFAULT.withValue(var_1834));
         _loc1_.push(SCALE_DEFAULT.withValue(var_337));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_12[var_81]));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "furniture_image:furnitureType":
                  furnitureType = String(_loc2_.value);
                  break;
               case "furniture_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "furniture_image:direction":
                  direction = const_12.indexOf(String(_loc2_.value));
            }
         }
      }
      
      public function get furnitureType() : String
      {
         return var_1834;
      }
      
      public function set furnitureType(param1:String) : void
      {
         var_1834 = param1;
         refresh();
      }
      
      public function get scale() : int
      {
         return var_337;
      }
      
      public function set scale(param1:int) : void
      {
         var_337 = param1;
         refresh();
      }
      
      public function get direction() : int
      {
         return var_81;
      }
      
      public function set direction(param1:int) : void
      {
         var_81 = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = var_1532.getValue(param1);
         if(_loc3_ == var_1834)
         {
            refresh();
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      private function refresh() : void
      {
         var _loc1_:class_2198 = null;
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         _bitmap.bitmap = null;
         if(_windowManager.roomEngine != null)
         {
            _loc2_ = "std";
            _loc5_ = _windowManager.roomEngine.getFurnitureTypeId(var_1834);
            if(var_757 == 0)
            {
               _loc1_ = _windowManager.roomEngine.getFurnitureImage(_loc5_,new Vector3d(var_81 * 45,0,0),var_337,this,0,var_3221,-1,-1,var_1966);
            }
            else
            {
               _loc1_ = _windowManager.roomEngine.getWallItemImage(_loc5_,new Vector3d(var_81 * 45,0,0),var_337,this,0,var_1966 ? var_1966.getLegacyString() : "");
            }
            if(_loc1_ != null)
            {
               _loc4_ = _loc1_.id;
               var_1532.remove(_loc4_);
               if(_loc4_ > 0)
               {
                  var_1532.add(_loc4_,var_1834);
               }
               _bitmap.bitmap = _loc1_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc3_ = "placeholder_furni" + (var_337 == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc3_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         _bitmap.invalidate();
         var_210.width = _bitmap.bitmap.width;
         var_210.height = _bitmap.bitmap.height;
      }
      
      private function onClick(param1:WindowMouseEvent) : void
      {
      }
   }
}

