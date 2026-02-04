package com.sulake.habbo.groups.badge
{
   import com.sulake.core.assets.IAsset;
   import com.sulake.core.assets.IResourceManager;
   import com.sulake.core.assets.class_3067;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.groups.HabboGroupsManager;
   import flash.display.BitmapData;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import package_3.class_2862;
   import package_3.class_2927;
   
   public class BadgeEditorPartItem implements class_13, class_3067
   {
      
      public static var BASE_PART:int = 0;
      
      public static var LAYER_PART:int = 1;
      
      public static var IMAGE_WIDTH:Number = 39;
      
      public static var IMAGE_HEIGHT:Number = 39;
      
      public static var CELL_WIDTH:Number = 13;
      
      public static var CELL_HEIGHT:Number = 13;
      
      private var var_52:HabboGroupsManager;
      
      private var var_283:BadgeSelectPartCtrl;
      
      private var var_2798:int;
      
      private var var_230:int;
      
      private var var_3463:String;
      
      private var _disposed:Boolean;
      
      private var _fileName:String;
      
      private var _maskFileName:String;
      
      private var var_48:BitmapData;
      
      private var var_320:BitmapData;
      
      private var _composite:BitmapData;
      
      private var var_859:ColorTransform = new ColorTransform(1,1,1);
      
      private var var_3744:Boolean = false;
      
      private var _isLoaded:Boolean = false;
      
      private var var_3339:Boolean = false;
      
      public function BadgeEditorPartItem(param1:HabboGroupsManager, param2:BadgeSelectPartCtrl, param3:int, param4:int, param5:class_2862 = null)
      {
         super();
         var_2798 = param3;
         var_52 = param1;
         var_283 = param2;
         var_230 = param4;
         var_3463 = var_52.getProperty("image.library.badgepart.url");
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
         if(param5 == null)
         {
            _isLoaded = true;
            var_3339 = true;
            var_48 = var_52.getButtonImage("badge_part_empty");
         }
         else
         {
            _fileName = param5.fileName.replace(".gif","").replace(".png","");
            _maskFileName = param5.maskFileName.replace(".gif","").replace(".png","");
            var_3744 = _maskFileName.length > 0;
            _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT);
            _fileName = var_3463 + "badgepart_" + _fileName + ".png";
            _maskFileName = var_3463 + "badgepart_" + _maskFileName + ".png";
            var_52.windowManager.resourceManager.retrieveAsset(_fileName,this);
            var_52.windowManager.resourceManager.retrieveAsset(_maskFileName,this);
         }
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
      
      public function get partIndex() : int
      {
         return var_2798;
      }
      
      public function receiveAsset(param1:IAsset, param2:String) : void
      {
         var _loc3_:IResourceManager = var_52.windowManager.resourceManager;
         if(_loc3_.isSameAsset(_fileName,param2))
         {
            var_48 = param1.content as BitmapData;
         }
         if(_loc3_.isSameAsset(_maskFileName,param2))
         {
            var_320 = param1.content as BitmapData;
         }
         checkIsImageLoaded();
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_48)
            {
               var_48.dispose();
               var_48 = null;
            }
            if(var_320)
            {
               var_320.dispose();
               var_320 = null;
            }
            if(_composite)
            {
               _composite.dispose();
               _composite = null;
            }
            _fileName = null;
            _maskFileName = null;
            var_859 = null;
            var_283 = null;
            var_52 = null;
            _disposed = true;
         }
      }
      
      private function checkIsImageLoaded() : void
      {
         if(var_48 == null)
         {
            return;
         }
         if(var_3744 && var_320 == null)
         {
            return;
         }
         _isLoaded = true;
         if(var_230 == BASE_PART)
         {
            var_283.onBaseImageLoaded(this);
         }
         else
         {
            var_283.onLayerImageLoaded(this);
         }
      }
      
      public function getComposite(param1:BadgeLayerOptions) : BitmapData
      {
         if(!_isLoaded)
         {
            return null;
         }
         if(var_3339)
         {
            return var_48;
         }
         var _loc2_:class_2927 = var_52.guildEditorData.badgeColors[param1.colorIndex] as class_2927;
         var_859.redMultiplier = _loc2_.red / 255;
         var_859.greenMultiplier = _loc2_.green / 255;
         var_859.blueMultiplier = _loc2_.blue / 255;
         var _loc3_:Point = getPosition(param1);
         _composite.dispose();
         _composite = new BitmapData(IMAGE_WIDTH,IMAGE_HEIGHT,true,0);
         _composite.copyPixels(var_48,var_48.rect,_loc3_);
         _composite.colorTransform(_composite.rect,var_859);
         if(var_3744)
         {
            _composite.copyPixels(var_320,var_320.rect,_loc3_,null,null,true);
         }
         return _composite;
      }
      
      private function getPosition(param1:BadgeLayerOptions) : Point
      {
         var _loc2_:Number = CELL_WIDTH * param1.gridX + CELL_WIDTH / 2 - var_48.width / 2;
         var _loc3_:Number = CELL_HEIGHT * param1.gridY + CELL_HEIGHT / 2 - var_48.height / 2;
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc2_ + var_48.width > IMAGE_WIDTH)
         {
            _loc2_ = IMAGE_WIDTH - var_48.width;
         }
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         if(_loc3_ + var_48.height > IMAGE_HEIGHT)
         {
            _loc3_ = IMAGE_HEIGHT - var_48.height;
         }
         return new Point(Math.floor(_loc2_),Math.floor(_loc3_));
      }
   }
}

