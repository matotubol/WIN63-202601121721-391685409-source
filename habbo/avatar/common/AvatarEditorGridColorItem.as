package com.sulake.habbo.avatar.common
{
   import com.sulake.core.assets.BitmapDataAsset;
   import com.sulake.core.window.class_1741;
   import com.sulake.core.window.class_1812;
   import com.sulake.core.window.components.IStaticBitmapWrapperWindow;
   import com.sulake.core.window.components.class_2251;
   import com.sulake.core.window.events.WindowMouseEvent;
   import com.sulake.habbo.avatar.structure.figure.IPartColor;
   import flash.display.BitmapData;
   import flash.geom.Point;
   
   public class AvatarEditorGridColorItem
   {
      
      private static const SELECTED_ASSET:String = "avatar_editor_editor_clr_13x21_3";
      
      private static const UNSELECTED_ASSET:String = "avatar_editor_editor_clr_13x21_1";
      
      private static const COLORIZATION_ASSET:String = "avatar_editor_editor_clr_13x21_2";
      
      private var var_36:class_2582;
      
      private var _window:class_1812;
      
      private var _partColor:IPartColor;
      
      private var var_2281:Boolean = false;
      
      private var var_31:IStaticBitmapWrapperWindow;
      
      private var _isDisabledForWearing:Boolean;
      
      public function AvatarEditorGridColorItem(param1:class_1812, param2:class_2582, param3:IPartColor, param4:Boolean = false)
      {
         super();
         var_36 = param2;
         _window = param1;
         _partColor = param3;
         _isDisabledForWearing = param4;
         var_31 = _window.findChildByTag("BORDER") as IStaticBitmapWrapperWindow;
         setupColor();
         updateThumbData();
         _window.addEventListener("WME_OVER",onMouseOver);
         _window.addEventListener("WME_OUT",onMouseOut);
      }
      
      private function onMouseOut(param1:WindowMouseEvent) : void
      {
         var_31.assetUri = var_2281 ? "avatar_editor_editor_clr_13x21_3" : "avatar_editor_editor_clr_13x21_1";
      }
      
      private function onMouseOver(param1:WindowMouseEvent) : void
      {
         var_31.assetUri = "avatar_editor_editor_clr_13x21_3";
      }
      
      private function setupColor() : void
      {
         var _loc1_:BitmapDataAsset = var_36.controller.manager.windowManager.assets.getAssetByName("avatar_editor_editor_clr_13x21_2") as BitmapDataAsset;
         var _loc2_:BitmapData = _loc1_.content as BitmapData;
         var _loc3_:BitmapData = _loc2_.clone();
         var _loc4_:class_2251 = _window.findChildByTag("COLOR_IMAGE") as class_2251;
         _loc4_.bitmap = new BitmapData(_loc3_.width,_loc3_.height,true,0);
         _loc3_.colorTransform(_loc3_.rect,_partColor.colorTransform);
         _loc4_.bitmap.copyPixels(_loc3_,_loc3_.rect,new Point(0,0));
         _loc3_.dispose();
      }
      
      public function dispose() : void
      {
         var_36 = null;
         if(_window != null)
         {
            if(!_window.disposed)
            {
               _window.dispose();
            }
         }
         _window = null;
         _partColor = null;
      }
      
      public function get view() : class_1812
      {
         return _window;
      }
      
      public function get isSelected() : Boolean
      {
         return var_2281;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         var_2281 = param1;
         var_31.assetUri = var_2281 ? "avatar_editor_editor_clr_13x21_3" : "avatar_editor_editor_clr_13x21_1";
      }
      
      private function updateThumbData() : void
      {
         if(_window == null)
         {
            return;
         }
         if(_window.disposed)
         {
            return;
         }
         var_31.assetUri = "avatar_editor_editor_clr_13x21_3";
         var _loc1_:class_1741 = _window.findChildByTag("CLUB_ICON");
         if(_partColor)
         {
            _loc1_.visible = _partColor.clubLevel > 0;
         }
         else
         {
            _loc1_.visible = false;
         }
      }
      
      public function get partColor() : IPartColor
      {
         return _partColor;
      }
      
      public function get isDisabledForWearing() : Boolean
      {
         return _isDisabledForWearing;
      }
   }
}

