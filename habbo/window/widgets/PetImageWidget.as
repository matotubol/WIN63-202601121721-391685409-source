package com.sulake.habbo.window.widgets
{
   import com.sulake.core.utils.class_55;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IRegionWindow;
   import com.sulake.core.window.components.class_2010;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.iterators.EmptyIterator;
   import com.sulake.core.window.utils.IIterator;
   import com.sulake.core.window.utils.PropertyStruct;
   import com.sulake.habbo.avatar.pets.PetFigureData;
   import com.sulake.habbo.room.class_1829;
   import com.sulake.habbo.room.class_2198;
   import com.sulake.habbo.window.HabboWindowManagerComponent;
   import com.sulake.room.utils.Vector3d;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class PetImageWidget implements class_3567, class_1829
   {
      
      public static const TYPE:String = "pet_image";
      
      private static const FIGURE_KEY:String = "pet_image:figure";
      
      private static const SCALE_KEY:String = "pet_image:scale";
      
      private static const const_295:String = "pet_image:direction";
      
      private static const const_836:String = "pet_image:zoomX";
      
      private static const const_140:String = "pet_image:zoomY";
      
      private static const SHRINK_ON_OVERFLOW_KEY:String = "pet_image:shrink_on_overflow";
      
      private static const const_12:Array = ["northeast","east","southeast","south","southwest","west","northwest","north"];
      
      private static const SCALES:Array = [32,64];
      
      private static const FIGURE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:figure","1 0 ffffff","String");
      
      private static const SCALE_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:scale",64,"int",false,SCALES);
      
      private static const DIRECTION_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:direction",const_12[2],"String",false,const_12);
      
      private static const ZOOM_X_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomX",1,"Number");
      
      private static const ZOOM_Y_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:zoomY",1,"Number");
      
      private static const SHRINK_ON_OVERFLOW_DEFAULT:PropertyStruct = new PropertyStruct("pet_image:shrink_on_overflow",false,"Boolean");
      
      private var _disposed:Boolean;
      
      private var var_210:class_2010;
      
      private var _windowManager:HabboWindowManagerComponent;
      
      private var var_134:class_1812;
      
      private var _bitmap:class_2251;
      
      private var var_308:IRegionWindow;
      
      private var var_975:String = String(FIGURE_DEFAULT.value);
      
      private var var_337:int = int(SCALE_DEFAULT.value);
      
      private var var_81:int = const_12.indexOf(String(DIRECTION_DEFAULT.value));
      
      private var var_1402:Number = Number(ZOOM_X_DEFAULT.value);
      
      private var var_1405:Number = Number(ZOOM_Y_DEFAULT.value);
      
      private var _shrinkOnOverflow:Boolean = Boolean(SHRINK_ON_OVERFLOW_DEFAULT.value);
      
      private var var_1532:class_55;
      
      private var var_1498:BitmapData;
      
      public function PetImageWidget(param1:class_2010, param2:HabboWindowManagerComponent)
      {
         super();
         var_210 = param1;
         _windowManager = param2;
         var_1532 = new class_55();
         var_134 = _windowManager.buildFromXML(_windowManager.assets.getAssetByName("pet_image_xml").content as XML) as class_1812;
         _bitmap = var_134.findChildByName("bitmap") as class_2251;
         var_308 = var_134.findChildByName("region") as IRegionWindow;
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
         _loc1_.push(FIGURE_DEFAULT.withValue(var_975));
         _loc1_.push(SCALE_DEFAULT.withValue(var_337));
         _loc1_.push(DIRECTION_DEFAULT.withValue(const_12[var_81]));
         _loc1_.push(ZOOM_X_DEFAULT.withValue(var_1402));
         _loc1_.push(ZOOM_Y_DEFAULT.withValue(var_1405));
         _loc1_.push(SHRINK_ON_OVERFLOW_DEFAULT.withValue(_shrinkOnOverflow));
         return _loc1_;
      }
      
      public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "pet_image:figure":
                  figure = String(_loc2_.value);
                  break;
               case "pet_image:scale":
                  scale = int(_loc2_.value);
                  break;
               case "pet_image:direction":
                  direction = const_12.indexOf(String(_loc2_.value));
                  break;
               case "pet_image:zoomX":
                  zoomX = Number(_loc2_.value);
                  break;
               case "pet_image:zoomY":
                  zoomY = Number(_loc2_.value);
                  break;
               case "pet_image:shrink_on_overflow":
                  shrinkOnOverflow = Boolean(_loc2_.value);
            }
         }
      }
      
      public function get figure() : String
      {
         return var_975;
      }
      
      public function set figure(param1:String) : void
      {
         var_975 = cleanupAvatarString(param1);
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
      
      public function get shrinkOnOverflow() : Boolean
      {
         return _shrinkOnOverflow;
      }
      
      public function set shrinkOnOverflow(param1:Boolean) : void
      {
         _shrinkOnOverflow = param1;
         refresh();
      }
      
      public function imageReady(param1:int, param2:BitmapData) : void
      {
         var _loc3_:String = var_1532.getValue(param1);
         if(_loc3_ != null)
         {
            if(cleanupAvatarString(_loc3_) == var_975)
            {
               refresh();
            }
         }
      }
      
      public function imageFailed(param1:int) : void
      {
      }
      
      public function refresh() : void
      {
         var _loc4_:String = null;
         var _loc2_:class_2198 = null;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         if(_bitmap == null)
         {
            return;
         }
         _bitmap.bitmap = null;
         _bitmap.blend = var_210.blend;
         var _loc1_:PetFigureData = new PetFigureData(var_975);
         if(_windowManager.roomEngine != null)
         {
            _loc4_ = "std";
            _loc2_ = _windowManager.roomEngine.getPetImage(_loc1_.typeId,_loc1_.paletteId,_loc1_.color,new Vector3d(var_81 * 45),scale,this,true,0,_loc1_.customParts,_loc4_);
            if(_loc2_ != null)
            {
               _loc6_ = _loc2_.id;
               var_1532.remove(_loc6_);
               if(_loc6_ > 0)
               {
                  var_1532.add(_loc6_,var_975);
               }
               _bitmap.bitmap = _loc2_.data;
               _bitmap.disposesBitmap = true;
            }
         }
         if(_bitmap.bitmap == null || _bitmap.bitmap.width < 2)
         {
            _loc5_ = "placeholder_pet" + (var_337 == 32 ? "_small" : "") + "_png";
            _bitmap.bitmap = _windowManager.assets.getAssetByName(_loc5_).content as BitmapData;
            _bitmap.disposesBitmap = false;
         }
         var _loc7_:Number = zoomX;
         var _loc3_:Number = zoomY;
         var_1498 = _bitmap.bitmap;
         if(_shrinkOnOverflow && (var_1498.width * zoomX > var_210.width || var_1498.height * zoomY > var_210.height))
         {
            _loc7_ *= 0.5;
            _loc3_ *= 0.5;
         }
         if(_loc7_ != 1 || _loc3_ != 1)
         {
            _bitmap.bitmap = zoomBitmapData(_bitmap.bitmap,_loc7_,_loc3_);
         }
         _bitmap.invalidate();
      }
      
      private function zoomBitmapData(param1:BitmapData, param2:Number, param3:Number) : BitmapData
      {
         var _loc5_:Number = param1.width * param2;
         var _loc6_:Number = param1.height * param3;
         var _loc4_:BitmapData = new BitmapData(_loc5_,_loc6_,true,0);
         var _loc7_:Matrix = new Matrix();
         _loc7_.scale(param2,param3);
         _loc4_.draw(param1,_loc7_);
         return _loc4_;
      }
      
      private function cleanupAvatarString(param1:String) : String
      {
         return param1 == null ? String(FIGURE_DEFAULT.value) : param1.replace(/NaN/g,"");
      }
      
      public function get zoomX() : Number
      {
         return var_1402;
      }
      
      public function get zoomY() : Number
      {
         return var_1405;
      }
      
      public function set zoomX(param1:Number) : void
      {
         var_1402 = param1;
         refresh();
      }
      
      public function set zoomY(param1:Number) : void
      {
         var_1405 = param1;
         refresh();
      }
      
      public function get petWidth() : int
      {
         if(var_1498 == null)
         {
            return 0;
         }
         return var_1498.width;
      }
      
      public function get petHeight() : int
      {
         if(var_1498 == null)
         {
            return 0;
         }
         return var_1498.height;
      }
   }
}

